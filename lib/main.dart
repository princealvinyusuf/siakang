import 'package:flutter/material.dart';
import 'navigation/tab_nav_controller.dart';
import 'screens/data_screen.dart';
import 'screens/home_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/reports_screen.dart';
import 'services/report_notification_service.dart';
import 'theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReportNotificationService.instance.initialize();
  await ReportNotificationService.instance.startIfEnabled();
  runApp(const PaskerIdLmiApp());
}

class PaskerIdLmiApp extends StatelessWidget {
  const PaskerIdLmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SIPKer by PASKER.ID',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: const _Shell(),
    );
  }
}

class _Shell extends StatefulWidget {
  const _Shell();

  @override
  State<_Shell> createState() => _ShellState();
}

class _ShellState extends State<_Shell> {
  final ValueNotifier<int> _index = ValueNotifier<int>(0);

  final List<Widget> _screens = const [
    HomeScreen(),
    ReportsScreen(),
    DataScreen(),
    ProfileScreen(),
  ];

  @override
  void dispose() {
    _index.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TabNavController(
      notifier: _index,
      child: ValueListenableBuilder<int>(
        valueListenable: _index,
        builder: (context, idx, _) {
          return Scaffold(
            body: _screens[idx],
            bottomNavigationBar: NavigationBar(
              selectedIndex: idx,
              labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
              onDestinationSelected: (value) => _index.value = value,
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.home_outlined),
                  selectedIcon: Icon(Icons.home),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: Icon(Icons.menu_book_outlined),
                  selectedIcon: Icon(Icons.menu_book),
                  label: 'Reports',
                ),
                NavigationDestination(
                  icon: Icon(Icons.dataset_outlined),
                  selectedIcon: Icon(Icons.dataset),
                  label: 'Data',
                ),
                NavigationDestination(
                  icon: Icon(Icons.info_outline),
                  selectedIcon: Icon(Icons.info),
                  label: 'About',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

