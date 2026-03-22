import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReportDetailScreen extends StatefulWidget {
  final String reportUrl;
  final String title;

  const ReportDetailScreen({
    super.key,
    required this.reportUrl,
    required this.title,
  });

  @override
  State<ReportDetailScreen> createState() => _ReportDetailScreenState();
}

class _ReportDetailScreenState extends State<ReportDetailScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;
  static const double _initialTableauScale = 0.85;
  static const double _minScale = 0.60;
  static const double _scaleStep = 0.05;
  double _currentScale = _initialTableauScale;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            if (mounted) setState(() => _isLoading = false);
            await _applyZoom(scale: _currentScale);
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.reportUrl));
  }

  Future<void> _applyZoom({required double scale}) async {
    final js = '''
      (function() {
        var scale = $scale;
        var frame = document.querySelector('iframe');
        if (frame) {
          frame.style.transformOrigin = 'top left';
          frame.style.position = 'absolute';
          frame.style.left = '0';
          frame.style.top = '0';
          frame.style.transform = 'scale(' + scale + ')';
          frame.style.width = (100 / scale) + '%';
          frame.style.height = (100 / scale) + '%';
          return;
        }

        // Fallback for Tableau pages rendered without a nested iframe.
        var root = document.body;
        if (!root) return;
        root.style.transformOrigin = 'top left';
        root.style.transform = 'scale(' + scale + ')';
        root.style.width = (100 / scale) + '%';
      })();
    ''';

    // Match Home behavior: retry while Tableau finishes async rendering.
    for (var attempt = 0; attempt < 20; attempt++) {
      try {
        await _controller.runJavaScript(js);
      } catch (_) {
        // Ignore transient JS execution failures during navigation.
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
  }

  Future<void> _handleZoomOutPressed() async {
    final nextScale = (_currentScale - _scaleStep).clamp(_minScale, 1.0);
    if (nextScale == _currentScale) return;
    setState(() => _currentScale = nextScale);
    await _applyZoom(scale: _currentScale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: 'Zoom out',
            icon: const Icon(Icons.zoom_out_rounded),
            onPressed: _handleZoomOutPressed,
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: _controller),
          if (_isLoading)
            const Center(child: CircularProgressIndicator.adaptive()),
        ],
      ),
    );
  }
}

