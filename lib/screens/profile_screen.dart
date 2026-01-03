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
              child: const Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.info_outline),
                    title: Text('About SIPKer'),
                    subtitle:
                        Text('by PASKER.ID'),
                  ),
                  Divider(height: 0),
                  ListTile(
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

