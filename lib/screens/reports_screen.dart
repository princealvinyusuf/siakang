import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/report_card.dart';
import '../widgets/section_header.dart';
import 'report_detail_screen.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? yearFilter;
  String? semesterFilter;
  String? sectorFilter;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = reports.where((report) {
      final matchesQuery = report.title.toLowerCase().contains(
            _searchController.text.toLowerCase(),
          ) ||
          report.summary.toLowerCase().contains(
                _searchController.text.toLowerCase(),
              );
      final matchesYear = yearFilter == null || report.year == yearFilter;
      final matchesSemester =
          semesterFilter == null || report.semester == semesterFilter;
      final matchesSector =
          sectorFilter == null || report.sector == sectorFilter;
      return matchesQuery && matchesYear && matchesSemester && matchesSector;
    }).toList();

    final years =
        reports.map((r) => r.year).toSet().toList()..sort((a, b) => b.compareTo(a));
    final semesters = reports.map((r) => r.semester).toSet().toList();
    final sectors = reports.map((r) => r.sector).toSet().toList();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeader(title: 'Report Library'),
                const SizedBox(height: 10),
                TextField(
                  controller: _searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: const InputDecoration(
                    hintText: 'Search reports (year, sector, keyword)',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: [
                    _FilterChip(
                      label: 'Year',
                      value: yearFilter ?? 'All',
                      options: ['All', ...years],
                      onSelected: (value) {
                        setState(() {
                          yearFilter = value == 'All' ? null : value;
                        });
                      },
                    ),
                    _FilterChip(
                      label: 'Semester',
                      value: semesterFilter ?? 'All',
                      options: ['All', ...semesters],
                      onSelected: (value) {
                        setState(() {
                          semesterFilter = value == 'All' ? null : value;
                        });
                      },
                    ),
                    _FilterChip(
                      label: 'Sector',
                      value: sectorFilter ?? 'All',
                      options: ['All', ...sectors],
                      onSelected: (value) {
                        setState(() {
                          sectorFilter = value == 'All' ? null : value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final report = filtered[index];
                return ReportCard(
                  report: report,
                  onReadSummary: () => _showSummarySheet(context, report),
                  onDownload: () => _openPdf(report.pdfUrl),
                  onOpenDetail: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ReportDetailScreen(
                        reportUrl:
                            'https://public.tableau.com/app/profile/tableau.developers/viz/WorldIndicators/GDPpercapita',
                        title: report.title,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openPdf(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open PDF')),
        );
      }
    }
  }

  void _showSummarySheet(BuildContext context, ReportItem report) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Summary',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: [
                  Chip(
                    label: Text(report.period),
                    backgroundColor: AppColors.primary.withOpacity(0.08),
                  ),
                  Chip(
                    label: Text(report.sector),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                report.summary,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.muted),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                  _openPdf(report.pdfUrl);
                },
                icon: const Icon(Icons.picture_as_pdf_outlined),
                label: const Text('Download PDF'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onSelected;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      initialValue: value,
      onSelected: onSelected,
      itemBuilder: (_) {
        return options
            .map(
              (opt) => PopupMenuItem<String>(
                value: opt,
                child: Text(opt),
              ),
            )
            .toList();
      },
      child: Chip(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$label: $value'),
            const Icon(Icons.arrow_drop_down),
          ],
        ),
        backgroundColor: AppColors.card,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColors.primary),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      ),
    );
  }
}

