import 'dart:convert';

import 'package:http/http.dart' as http;

class HighlightStatisticItem {
  final int id;
  final String title;
  final String value;
  final String unit;
  final String description;
  final String logo;
  final int order;

  const HighlightStatisticItem({
    required this.id,
    required this.title,
    required this.value,
    required this.unit,
    required this.description,
    required this.logo,
    required this.order,
  });

  factory HighlightStatisticItem.fromJson(Map<String, dynamic> json) {
    return HighlightStatisticItem(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: (json['title'] as String?)?.trim() ?? '',
      value: (json['value'] as String?)?.trim() ?? '',
      unit: (json['unit'] as String?)?.trim() ?? '',
      description: (json['description'] as String?)?.trim() ?? '',
      logo: (json['logo'] as String?)?.trim() ?? '',
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }
}

class HighlightStatisticsApi {
  static const _endpoint =
      'https://paskerid.kemnaker.go.id/api/highlight-statistics';

  Future<List<HighlightStatisticItem>> fetchTertiary() async {
    final resp = await http.get(Uri.parse(_endpoint));
    if (resp.statusCode < 200 || resp.statusCode >= 300) {
      throw Exception('HTTP ${resp.statusCode}');
    }

    final decoded = jsonDecode(utf8.decode(resp.bodyBytes));
    if (decoded is! Map<String, dynamic>) {
      throw Exception('Unexpected JSON');
    }

    final tertiary = decoded['tertiary'];
    if (tertiary is! List) return const [];

    final items = tertiary
        .whereType<Map<String, dynamic>>()
        .map(HighlightStatisticItem.fromJson)
        .toList();
    items.sort((a, b) => a.order.compareTo(b.order));
    return items;
  }
}


