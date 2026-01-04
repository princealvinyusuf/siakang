import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/information_api.dart';

/// Option B ("polling + local notification") implementation.
///
/// Notes:
/// - This polls while the app is running (foreground / backgrounded but alive).
/// - True periodic background execution (when the OS suspends the app) requires
///   an additional background scheduler plugin + platform setup.
class ReportNotificationService with WidgetsBindingObserver {
  ReportNotificationService._();

  static final ReportNotificationService instance = ReportNotificationService._();

  static const String _prefEnabledKey = 'notify_reports_enabled';
  static const String _prefLastSignatureKey = 'notify_reports_last_signature';

  // Matches the label used in `DataScreen` subjects list.
  static const String _defaultSubject = 'Labour Market Inteligence Report';

  static const String _androidChannelId = 'reports_channel';
  static const String _androidChannelName = 'Reports';
  static const String _androidChannelDescription =
      'Notifications when a new report/publication is available';

  // Keep modest to avoid excessive network usage while still being responsive.
  static const Duration _pollInterval = Duration(minutes: 30);

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();
  final InformationApi _api = InformationApi();

  SharedPreferences? _prefs;
  Timer? _timer;
  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;

    WidgetsBinding.instance.addObserver(this);
    _prefs = await SharedPreferences.getInstance();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );

    await _notifications.initialize(initSettings);

    // Android notification channel (required for Android 8+).
    final androidPlugin = _notifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.createNotificationChannel(
        const AndroidNotificationChannel(
          _androidChannelId,
          _androidChannelName,
          description: _androidChannelDescription,
          importance: Importance.defaultImportance,
        ),
      );
    }

    _initialized = true;
  }

  Future<bool> isEnabled() async {
    await initialize();
    return _prefs?.getBool(_prefEnabledKey) ?? false;
  }

  Future<void> setEnabled(bool enabled) async {
    await initialize();
    await _prefs?.setBool(_prefEnabledKey, enabled);

    if (enabled) {
      await _requestPermissionsIfNeeded();
      await _seedBaselineIfNeeded();
      _startPollingTimer();
      unawaited(_pollOnce(showNotificationIfNew: true));
    } else {
      _stopPollingTimer();
    }
  }

  Future<void> startIfEnabled() async {
    if (await isEnabled()) {
      await _requestPermissionsIfNeeded();
      await _seedBaselineIfNeeded();
      _startPollingTimer();
    } else {
      _stopPollingTimer();
    }
  }

  void _startPollingTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(_pollInterval, (_) {
      unawaited(_pollOnce(showNotificationIfNew: true));
    });
  }

  void _stopPollingTimer() {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> _seedBaselineIfNeeded() async {
    final prefs = _prefs;
    if (prefs == null) return;
    if (prefs.getString(_prefLastSignatureKey)?.isNotEmpty == true) return;

    // First-time enable: record current latest so we don't notify immediately.
    await _pollOnce(showNotificationIfNew: false);
  }

  Future<void> _pollOnce({required bool showNotificationIfNew}) async {
    final prefs = _prefs;
    if (prefs == null) return;
    if (!(prefs.getBool(_prefEnabledKey) ?? false)) return;

    try {
      var items = await _api.fetchPublikasi(subject: _defaultSubject);
      if (items.isEmpty) {
        // Fallback: if the subject filter yields nothing, check the latest
        // publication overall.
        items = await _api.fetchPublikasi();
      }
      if (items.isEmpty) return;

      final latest = items.first;
      final latestSignature = '${latest.id}|${latest.date}|${latest.title}';
      final lastSignature = prefs.getString(_prefLastSignatureKey);

      if (lastSignature == null || lastSignature.isEmpty) {
        await prefs.setString(_prefLastSignatureKey, latestSignature);
        return;
      }

      if (latestSignature != lastSignature) {
        await prefs.setString(_prefLastSignatureKey, latestSignature);
        if (showNotificationIfNew) {
          await _showNewReportNotification(title: latest.title);
        }
      }
    } catch (e) {
      // Ignore transient network/API errors; we'll retry on the next interval.
      if (kDebugMode) {
        debugPrint('ReportNotificationService poll error: $e');
      }
    }
  }

  Future<void> _showNewReportNotification({required String title}) async {
    const androidDetails = AndroidNotificationDetails(
      _androidChannelId,
      _androidChannelName,
      channelDescription: _androidChannelDescription,
      importance: Importance.defaultImportance,
      priority: Priority.defaultPriority,
    );
    const details = NotificationDetails(android: androidDetails);

    await _notifications.show(
      1001,
      'New report published',
      title,
      details,
    );
  }

  Future<void> _requestPermissionsIfNeeded() async {
    // iOS permission prompt.
    await _notifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    // Android 13+ runtime permission prompt.
    await _notifications
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      unawaited(_pollOnce(showNotificationIfNew: true));
    }
  }
}


