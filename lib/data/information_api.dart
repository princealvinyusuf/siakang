import 'dart:convert';

import 'package:http/http.dart' as http;

class PublicationItem {
  final int id;
  final String title;
  final String description;
  final String date; // API format: YYYY-MM-DD
  final String fileUrl;

  const PublicationItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.fileUrl,
  });

  factory PublicationItem.fromJson(Map<String, dynamic> json) {
    return PublicationItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim() ?? '',
      date: (json['date'] as String?)?.trim() ?? '',
      fileUrl: (json['file_url'] as String?)?.trim() ?? '',
    );
  }
}

class InformationApi {
  static const _endpoint =
      'https://paskerid.kemnaker.go.id/api/information?type=publikasi';

  Future<List<PublicationItem>> fetchPublikasi() async {
    final resp = await http.get(Uri.parse(_endpoint));
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('HTTP ${resp.statusCode}');
    }

    final decoded = jsonDecode(utf8.decode(resp.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Unexpected JSON');
    }

    final data = decoded['data'];
    if (data is! List) return const [];

    final items = data
        .whereType<Map<String, dynamic>>()
        .map(PublicationItem.fromJson)
        .where((e) => e.title.isNotEmpty && e.fileUrl.isNotEmpty)
        .toList();

    // newest first (date is YYYY-MM-DD so lexical sort works)
    items.sort((a, b) => b.date.compareTo(a.date));
    return items;
  }
}


