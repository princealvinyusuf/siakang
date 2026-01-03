import 'package:flutter/material.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool notifyReports = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionHeader(title: 'Profile & Preferences'),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('Notify when new report is published'),
                    value: notifyReports,
                    onChanged: (val) => setState(() => notifyReports = val),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Theme(
                    data: Theme.of(context).copyWith(
                      dividerColor: Colors.transparent,
                    ),
                    child: ExpansionTile(
                      leading: const Icon(Icons.info_outline),
                      title: const Text('About SIPKer'),
                      subtitle: const Text('by PASKER.ID'),
                      childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                      children: const [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Tentang SIPKer',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'SIPKer (Sistem Informasi Pasar Kerja) adalah platform digital nasional yang dikembangkan untuk menyediakan informasi pasar kerja yang akurat, terintegrasi, dan berbasis data bagi masyarakat, dunia usaha, dan pemerintah.',
                        ),
                        SizedBox(height: 10),
                        Text(
                          'SIPKer berfungsi sebagai pusat pengelolaan dan analisis data ketenagakerjaan Indonesia, yang mencakup informasi lowongan kerja, karakteristik tenaga kerja, kebutuhan industri, tren pasar kerja, serta proyeksi ketenagakerjaan di tingkat nasional maupun daerah.',
                        ),
                        SizedBox(height: 10),
                        Text('Melalui SIPKer, pemerintah berupaya mendukung:'),
                        SizedBox(height: 8),
                        _Bullet(
                          text:
                              'pencari kerja dalam memperoleh informasi dan peluang kerja yang relevan,',
                        ),
                        _Bullet(
                          text: 'dunia usaha dalam menemukan tenaga kerja sesuai kebutuhan,',
                        ),
                        _Bullet(
                          text:
                              'perumusan kebijakan ketenagakerjaan yang berbasis bukti dan data.',
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 0),
                  const ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy & Terms'),
                    subtitle: Text('Read how we protect your data'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  final String text;

  const _Bullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '•',
            style: TextStyle(
              height: 1.4,
              color: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

