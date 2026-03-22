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
  static const double _tableauScale = 0.85;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) async {
            if (mounted) setState(() => _isLoading = false);
            await _applyZoomOut();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.reportUrl));
  }

  Future<void> _applyZoomOut() async {
    const js = '''
      (function() {
        var scale = $_tableauScale;
        var root = document.body;
        if (!root) return;

        root.style.transformOrigin = 'top left';
        root.style.transform = 'scale(' + scale + ')';
        root.style.width = (100 / scale) + '%';
      })();
    ''';

    // Retry a few times because Tableau content can finalize after page finish.
    for (var attempt = 0; attempt < 6; attempt++) {
      try {
        await _controller.runJavaScript(js);
      } catch (_) {
        // Ignore transient JS execution failures during navigation.
      }
      await Future<void>.delayed(const Duration(milliseconds: 250));
    }
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

