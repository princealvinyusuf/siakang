import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

import '../theme/app_theme.dart';
import 'report_detail_screen.dart';

class DocumentViewerScreen extends StatefulWidget {
  final String title;
  final String fileUrl;

  const DocumentViewerScreen({
    super.key,
    required this.title,
    required this.fileUrl,
  });

  @override
  State<DocumentViewerScreen> createState() => _DocumentViewerScreenState();
}

class _DocumentViewerScreenState extends State<DocumentViewerScreen> {
  PdfControllerPinch? _pdfController;
  Object? _error;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  Uri _safeUri(String url) {
    // file_url can contain spaces; encode them safely
    return Uri.parse(Uri.encodeFull(url));
  }

  bool _looksLikePdf(String url) {
    final lower = url.toLowerCase();
    return lower.contains('.pdf');
  }

  Future<void> _load() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      if (!_looksLikePdf(widget.fileUrl)) {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => ReportDetailScreen(
              reportUrl: widget.fileUrl,
              title: widget.title,
            ),
          ),
        );
        return;
      }

      final resp = await http.get(_safeUri(widget.fileUrl));
      if (resp.statusCode < 200 || resp.statusCode >= 300) {
        throw Exception('HTTP ${resp.statusCode}');
      }

      final bytes = resp.bodyBytes;
      final controller = PdfControllerPinch(
        document: PdfDocument.openData(bytes),
      );

      if (!mounted) return;
      setState(() {
        _pdfController = controller;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _isLoading = false;
      });
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
          if (_pdfController != null) PdfViewPinch(controller: _pdfController!),
          if (_isLoading)
            const Center(child: CircularProgressIndicator.adaptive()),
          if (_error != null && !_isLoading)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Failed to download/open file.',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Please try again.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: AppColors.muted),
                    ),
                    const SizedBox(height: 10),
                    TextButton.icon(
                      onPressed: _load,
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}


