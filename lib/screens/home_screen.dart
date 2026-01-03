import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../data/highlight_statistics_api.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/indicator_card.dart';
import '../widgets/section_header.dart';
import 'report_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _api = HighlightStatisticsApi();
  late Future<_IndicatorsData> _indicatorsFuture;
  bool _showAllIndicators = false;

  @override
  void initState() {
    super.initState();
    _indicatorsFuture = _loadIndicators();
  }

  Future<_IndicatorsData> _loadIndicators() async {
    final resp = await _api.fetchAll();
    return _IndicatorsData(
      tertiary: _toIndicatorStats(resp.tertiary, seedOffset: 0),
      primary: _toIndicatorStats(resp.primary, seedOffset: 10),
      secondary: _toIndicatorStats(resp.secondary, seedOffset: 20),
    );
  }

  List<IndicatorStat> _toIndicatorStats(
    List<HighlightStatisticItem> items, {
    required int seedOffset,
  }) {
    final colors = <Color>[
      AppColors.accentBlue,
      AppColors.accentGreen,
      AppColors.accentOrange,
      AppColors.secondary,
      AppColors.primary,
    ];

    return items.asMap().entries.map((entry) {
      final idx = entry.key;
      final item = entry.value;
      final valueWithUnit =
          item.unit.isEmpty ? item.value : '${item.value} ${item.unit}';
      return IndicatorStat(
        title: item.title,
        value: valueWithUnit,
        changeText: item.description,
        icon: _mapFaLogoToIcon(item.logo),
        color: colors[(seedOffset + idx) % colors.length],
      );
    }).toList();
  }

  IconData _mapFaLogoToIcon(String rawLogo) {
    final logo = rawLogo.trim();
    switch (logo) {
      case 'fa-briefcase':
        return Icons.work_outline_rounded;
      case 'fa-chart-line':
        return Icons.show_chart_rounded;
      case 'fa-user-check':
        return Icons.person_rounded;
      case 'fa-user-times':
        return Icons.person_off_rounded;
      case 'fa-percent':
        return Icons.percent_rounded;
      case 'fa-users':
        return Icons.groups_rounded;
      case 'fa-user-tie':
        return Icons.badge_outlined;
      case 'fa-building':
        return Icons.apartment_rounded;
      case 'fa-bullhorn':
        return Icons.campaign_rounded;
      case 'fa-file-alt':
        return Icons.description_outlined;
      default:
        return Icons.analytics_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final latestReport =
        reports.firstWhere((r) => r.isLatest, orElse: () => reports.first);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(),
            const SizedBox(height: 16),
            SectionHeader(
              title: 'Indikator Utama',
              onAction: () => setState(() {
                _showAllIndicators = !_showAllIndicators;
              }),
              actionLabel: _showAllIndicators ? 'Hide' : 'See all',
            ),
            const SizedBox(height: 10),
            FutureBuilder<_IndicatorsData>(
              future: _indicatorsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox(
                    height: 160,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
                if (snapshot.hasError) {
                  return SizedBox(
                    height: 160,
                    child: _IndicatorsError(
                      onRetry: () => setState(() {
                        _indicatorsFuture = _loadIndicators();
                      }),
                    ),
                  );
                }

                final data = snapshot.data;
                if (data == null || data.tertiary.isEmpty) {
                  return const SizedBox(
                    height: 160,
                    child: Center(
                      child: Text('No indicators available right now.'),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _IndicatorCarousel(stats: data.tertiary),
                    if (_showAllIndicators) ...[
                      const SizedBox(height: 14),
                      Text(
                        'Sisi Demand',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      _IndicatorCarousel(stats: data.primary),
                      const SizedBox(height: 14),
                      Text(
                        'Informasi KarirHub by Kemnaker',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 8),
                      _IndicatorCarousel(stats: data.secondary),
                    ],
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            SectionHeader(
              title: 'Unemployment Rate (Last 12 Months)',
              actionLabel: 'Download CSV',
              onAction: () {},
            ),
            const SizedBox(height: 10),
            _TrendChart(),
            const SizedBox(height: 18),
            SectionHeader(
              title: 'Latest Report',
              actionLabel: 'View library',
              onAction: () {},
            ),
            const SizedBox(height: 10),
            _LatestReportCard(report: latestReport),
          ],
        ),
      ),
    );
  }
}

class _IndicatorCarousel extends StatelessWidget {
  final List<IndicatorStat> stats;

  const _IndicatorCarousel({required this.stats});

  @override
  Widget build(BuildContext context) {
    if (stats.isEmpty) {
      return const SizedBox(
        height: 160,
        child: Center(child: Text('No data')),
      );
    }
    return SizedBox(
      height: 160,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.9),
        itemCount: stats.length,
        itemBuilder: (context, index) => IndicatorCard(stat: stats[index]),
      ),
    );
  }
}

class _IndicatorsData {
  final List<IndicatorStat> tertiary;
  final List<IndicatorStat> primary;
  final List<IndicatorStat> secondary;

  const _IndicatorsData({
    required this.tertiary,
    required this.primary,
    required this.secondary,
  });
}

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.analytics_outlined, color: AppColors.primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SIPKer by PASKER.ID',
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                'Kemnaker RI',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IndicatorsError extends StatelessWidget {
  final VoidCallback onRetry;

  const _IndicatorsError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Could not load indicators.',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              'Please check your connection and try again.',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: 10),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final spots = unemploymentTrend.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.unemploymentRate);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 220,
            child: LineChart(
              LineChartData(
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (_) => Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((barSpot) {
                        final month =
                            unemploymentTrend[barSpot.x.toInt()].monthLabel;
                        return LineTooltipItem(
                          '$month\n${barSpot.y.toStringAsFixed(1)}%',
                          Theme.of(context).textTheme.bodyMedium!,
                        );
                      }).toList();
                    },
                  ),
                ),
                gridData: const FlGridData(show: true, horizontalInterval: 0.2),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 0.2,
                      getTitlesWidget: (value, meta) => Text(
                        '${value.toStringAsFixed(1)}%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: AppColors.muted, fontSize: 11),
                      ),
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= unemploymentTrend.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            unemploymentTrend[index].monthLabel,
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(color: AppColors.muted, fontSize: 11),
                          ),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minY: 4.8,
                maxY: 6.0,
                lineBarsData: [
                  LineChartBarData(
                    isCurved: true,
                    color: AppColors.primary,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    spots: spots,
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.35),
                          Colors.transparent,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
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

class _LatestReportCard extends StatelessWidget {
  final ReportItem report;

  const _LatestReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              report.title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              report.summary,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.muted),
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Chip(
                  label: Text(report.period),
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  labelStyle: const TextStyle(color: AppColors.primary),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(report.category),
                  backgroundColor: Colors.grey.shade200,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => ReportDetailScreen(
                      reportUrl: 'https://public.tableau.com/app/profile/tableau.developers/viz/WorldIndicators/GDPpercapita',
                      title: report.title,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.open_in_new_rounded),
              label: const Text('View Report'),
            ),
          ],
        ),
      ),
    );
  }
}

