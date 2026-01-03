import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// A card-styled Tableau embed rendered via WebView.
///
/// This is intended for dashboard previews inside scrollable screens (e.g. Home).
class TableauEmbedCard extends StatefulWidget {
  final String html;
  final double height;

  const TableauEmbedCard({
    super.key,
    required this.html,
    required this.height,
  });

  @override
  State<TableauEmbedCard> createState() => _TableauEmbedCardState();
}

class _TableauEmbedCardState extends State<TableauEmbedCard> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _isLoading = false);
          },
        ),
      )
      ..loadHtmlString(widget.html, baseUrl: 'https://public.tableau.com/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              const Center(child: CircularProgressIndicator.adaptive()),
          ],
        ),
      ),
    );
  }
}


