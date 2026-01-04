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
    isLatest: true,
  ),
  ReportItem(
    title: 'Sector Deep Dive: Manufacturing Hiring Outlook',
    period: 'Q3 2024',
    category: 'Labour Market Intelligence',
    summary: 'Manufacturing led hiring growth with strong export clusters and domestic substitution momentum.',
    pdfUrl: 'https://example.com/lmir-manufacturing-q3-2024.pdf',
    sector: 'Manufacturing',
    semester: 'II',
    year: '2024',
  ),
  ReportItem(
    title: 'Services Labour Demand and Wages',
    period: 'Q2 2024',
    category: 'Labour Market Intelligence',
    summary: 'Services hiring rebalanced toward logistics and digital trade; wage growth stable at 3.1% YoY.',
    pdfUrl: 'https://example.com/lmir-services-q2-2024.pdf',
    sector: 'Services',
    semester: 'I',
    year: '2024',
  ),
  ReportItem(
    title: 'Provincial Labour Conditions Dashboard',
    period: 'Semester I 2024',
    category: 'Labour Market Intelligence',
    summary: 'Provincial dispersion narrowed; top 5 provinces contributed 54% of new vacancies.',
    pdfUrl: 'https://example.com/lmir-provincial-sem1-2024.pdf',
    sector: 'Regional',
    semester: 'I',
    year: '2024',
  ),
  ReportItem(
    title: 'Green Jobs and Transition Skills',
    period: '2023 Annual',
    category: 'Labour Market Intelligence',
    summary: 'Early signals of green skills demand in energy, transport, and manufacturing supply chains.',
    pdfUrl: 'https://example.com/lmir-green-jobs-2023.pdf',
    sector: 'Green Economy',
    semester: 'II',
    year: '2023',
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

