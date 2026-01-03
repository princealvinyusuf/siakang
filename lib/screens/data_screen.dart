import 'package:flutter/material.dart';
import '../data/information_api.dart';
import '../data/mock_data.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';
import 'document_viewer_screen.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  final _api = InformationApi();
  late Future<List<PublicationItem>> _publikasiFuture;
  bool _showAll = false;
  String? _selectedSubject;

  static const _subjects = <String>[
    'Seputar Pasar Kerja (SPARK)',
    'Infografis SIPK',
    'Angkatan Kerja',
    'Pedoman / Regulasi',
    'Labour Market Inteligence Report',
    'Infografis Job Fair',
  ];

  @override
  void initState() {
    super.initState();
    _publikasiFuture = _api.fetchPublikasi(subject: _selectedSubject);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Data'),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: dataHighlights
                  .map((item) => _HighlightCard(item: item))
                  .toList(),
            ),
            const SizedBox(height: 20),
            SectionHeader(
              title: 'Quick downloads',
              actionLabel: _showAll ? 'Hide' : 'View all',
              onAction: () => setState(() => _showAll = !_showAll),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String?>(
              value: _selectedSubject,
              decoration: InputDecoration(
                labelText: 'Subject',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              items: [
                const DropdownMenuItem<String?>(
                  value: null,
                  child: Text('All subjects'),
                ),
                ..._subjects.map(
                  (s) => DropdownMenuItem<String?>(
                    value: s,
                    child: Text(s, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  _selectedSubject = value;
                  _showAll = false;
                  _publikasiFuture = _api.fetchPublikasi(subject: value);
                });
              },
            ),
            const SizedBox(height: 8),
            FutureBuilder<List<PublicationItem>>(
              future: _publikasiFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return _PublikasiError(
                    onRetry: () => setState(() {
                      _publikasiFuture =
                          _api.fetchPublikasi(subject: _selectedSubject);
                    }),
                  );
                }

                final items = snapshot.data ?? const <PublicationItem>[];
                if (items.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text('No downloads available right now.'),
                  );
                }

                final visible =
                    _showAll ? items : items.take(5).toList(growable: false);
                return Column(
                  children: visible
                      .map(
                        (item) => _PublicationTile(
                          item: item,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => DocumentViewerScreen(
                                  title: item.title,
                                  fileUrl: item.fileUrl,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final DataHighlight item;

  const _HighlightCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 48) / 2,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.icon, color: AppColors.primary),
              ),
              const SizedBox(height: 10),
              Text(
                item.title,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Text(
                item.value,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 2),
              Text(
                item.subtitle,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.muted),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PublicationTile extends StatelessWidget {
  final PublicationItem item;
  final VoidCallback onTap;

  const _PublicationTile({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final subtitle = [
      if (item.date.isNotEmpty) item.date,
      if (item.subject.isNotEmpty) item.subject,
      if (item.description.isNotEmpty) item.description,
    ].join('\n');

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.secondary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(
            Icons.cloud_download_outlined,
            color: AppColors.secondary,
          ),
        ),
        title: Text(
          item.title,
          style: Theme.of(context).textTheme.titleMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          subtitle,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.muted),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
      ),
    );
  }
}

class _PublikasiError extends StatelessWidget {
  final VoidCallback onRetry;

  const _PublikasiError({required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(
            'Could not load downloads.',
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
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: onRetry,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}

