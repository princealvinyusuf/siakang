import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedRole = 'Analyst';
  String language = 'ID';
  bool notifyReports = true;
  bool notifyData = true;

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
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('User role',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: selectedRole,
                      items: const [
                        DropdownMenuItem(value: 'Analyst', child: Text('Analyst')),
                        DropdownMenuItem(value: 'Public', child: Text('Public')),
                        DropdownMenuItem(
                            value: 'Internal', child: Text('Internal')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() => selectedRole = value);
                        }
                      },
                      decoration: const InputDecoration(),
                    ),
                    const SizedBox(height: 16),
                    Text('Language',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 10,
                      children: [
                        ChoiceChip(
                          label: const Text('Bahasa (ID)'),
                          selected: language == 'ID',
                          onSelected: (_) => setState(() => language = 'ID'),
                          selectedColor: AppColors.primary.withOpacity(0.12),
                          labelStyle: TextStyle(
                            color: language == 'ID'
                                ? AppColors.primary
                                : AppColors.muted,
                          ),
                        ),
                        ChoiceChip(
                          label: const Text('English (EN)'),
                          selected: language == 'EN',
                          onSelected: (_) => setState(() => language = 'EN'),
                          selectedColor: AppColors.primary.withOpacity(0.12),
                          labelStyle: TextStyle(
                            color: language == 'EN'
                                ? AppColors.primary
                                : AppColors.muted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
                  SwitchListTile(
                    title: const Text('Notify when new report is published'),
                    value: notifyReports,
                    onChanged: (val) => setState(() => notifyReports = val),
                  ),
                  const Divider(height: 0),
                  SwitchListTile(
                    title: const Text('Notify when data updates are available'),
                    value: notifyData,
                    onChanged: (val) => setState(() => notifyData = val),
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

