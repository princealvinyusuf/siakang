import 'package:flutter/material.dart';

class IndicatorStat {
  final String title;
  final String value;
  final String changeText;
  final IconData icon;
  final Color color;

  const IndicatorStat({
    required this.title,
    required this.value,
    required this.changeText,
    required this.icon,
    required this.color,
  });
}

class TrendPoint {
  final String monthLabel;
  final double unemploymentRate;

  const TrendPoint({
    required this.monthLabel,
    required this.unemploymentRate,
  });
}

class ReportItem {
  final String title;
  final String period;
  final String category;
  final String summary;
  final String pdfUrl;
  final String sector;
  final String semester;
  final String year;
  final String? dashboardUrl;
  final bool isLatest;

  const ReportItem({
    required this.title,
    required this.period,
    required this.category,
    required this.summary,
    required this.pdfUrl,
    required this.sector,
    required this.semester,
    required this.year,
    this.dashboardUrl,
    this.isLatest = false,
  });
}

class DataHighlight {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;

  const DataHighlight({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
  });
}

const indicatorStats = <IndicatorStat>[
  IndicatorStat(
    title: 'Total Workforce',
    value: '142.7M',
    changeText: '+0.9% vs last quarter',
    icon: Icons.groups_rounded,
    color: Color(0xFF2563EB),
  ),
  IndicatorStat(
    title: 'Unemployment Rate (TPT)',
    value: '5.1%',
    changeText: '-0.2 pts YoY',
    icon: Icons.trending_down_rounded,
    color: Color(0xFF16A34A),
  ),
  IndicatorStat(
    title: 'Total Job Vacancies',
    value: '612K',
    changeText: '+4.3% MoM',
    icon: Icons.work_outline_rounded,
    color: Color(0xFFF97316),
  ),
  IndicatorStat(
    title: 'Top Hiring Sector',
    value: 'Manufacturing',
    changeText: '18.4% of vacancies',
    icon: Icons.factory_outlined,
    color: Color(0xFF0EA5E9),
  ),
];

const unemploymentTrend = <TrendPoint>[
  TrendPoint(monthLabel: 'Jan', unemploymentRate: 5.8),
  TrendPoint(monthLabel: 'Feb', unemploymentRate: 5.7),
  TrendPoint(monthLabel: 'Mar', unemploymentRate: 5.6),
  TrendPoint(monthLabel: 'Apr', unemploymentRate: 5.6),
  TrendPoint(monthLabel: 'May', unemploymentRate: 5.5),
  TrendPoint(monthLabel: 'Jun', unemploymentRate: 5.4),
  TrendPoint(monthLabel: 'Jul', unemploymentRate: 5.4),
  TrendPoint(monthLabel: 'Aug', unemploymentRate: 5.3),
  TrendPoint(monthLabel: 'Sep', unemploymentRate: 5.3),
  TrendPoint(monthLabel: 'Oct', unemploymentRate: 5.2),
  TrendPoint(monthLabel: 'Nov', unemploymentRate: 5.2),
  TrendPoint(monthLabel: 'Dec', unemploymentRate: 5.1),
];

const reports = <ReportItem>[
  ReportItem(
    title: 'Struktur Ketenagakerjaan',
    period: 'Semester II 2024',
    category: 'Labour Market Intelligence',
    summary:
        'Struktur Ketenagakerjaan memberikan gambaran singkat kondisi pasar kerja di Indonesia, mulai dari angkatan kerja, pengangguran, hingga sebaran pekerjaan dan pendidikan.',
    pdfUrl: 'https://example.com/lmir-sem2-2024.pdf',
    sector: 'National',
    semester: 'II',
    year: '2024',
    dashboardUrl:
        'https://public.tableau.com/views/DashboardStrukturKetenagakerjaanperFeb2025/'
        'Dash_StrukturKetenagakerjaan?:showVizHome=no&:tabs=no&:toolbar=yes',
    isLatest: true,
  ),
  ReportItem(
    title: 'Kebutuhan Tenaga Kerja',
    period: 'Q3 2024',
    category: 'Labour Market Intelligence',
    summary:
        'Kebutuhan Tenaga Kerja memberikan ringkasan permintaan lowongan kerja berdasarkan sektor, jabatan, waktu, dan wilayah.',
    pdfUrl: 'https://example.com/lmir-manufacturing-q3-2024.pdf',
    sector: 'Manufacturing',
    semester: 'II',
    year: '2024',
    dashboardUrl:
        'https://public.tableau.com/views/DataCollectingDashboardV_2/Dashboard'
        '?:showVizHome=no&:tabs=no&:toolbar=yes',
  ),
  ReportItem(
    title: 'Persediaan Tenaga Kerja',
    period: 'Q2 2024',
    category: 'Labour Market Intelligence',
    summary:
        'Persediaan Tenaga Kerja menampilkan ringkasan data pencari kerja berdasarkan demografi dan wilayah.',
    pdfUrl: 'https://example.com/lmir-services-q2-2024.pdf',
    sector: 'Services',
    semester: 'I',
    year: '2024',
    dashboardUrl:
        'https://public.tableau.com/views/DashboardPersediaanTenagaKerja/'
        'DashboardPencaker_New?:showVizHome=no&:tabs=no&:toolbar=yes',
  ),
];

const dataHighlights = <DataHighlight>[
  DataHighlight(
    title: 'Labour Supply',
    value: '146.3M',
    subtitle: 'Working-age population (15-64)',
    icon: Icons.people_outline_rounded,
  ),
  DataHighlight(
    title: 'Labour Demand',
    value: '612K',
    subtitle: 'Active vacancies tracked',
    icon: Icons.work_history_outlined,
  ),
  DataHighlight(
    title: 'Median Wage',
    value: 'Rp4.85 jt',
    subtitle: 'Across tracked sectors',
    icon: Icons.payments_outlined,
  ),
  DataHighlight(
    title: 'Top Province',
    value: 'Jawa Barat',
    subtitle: '21% of total vacancies',
    icon: Icons.map_outlined,
  ),
];

