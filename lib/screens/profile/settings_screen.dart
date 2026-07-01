import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import 'addresses_screen.dart';
import 'appearance_screen.dart';
import 'help_center_screen.dart';
import 'language_region_screen.dart';
import 'notifications_screen.dart';
import 'payments_screen.dart';
import '../verify_email_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: AppTheme.blush,
                child: Icon(Icons.person, color: AppTheme.hotPink),
              ),
              title: Text(
                user?.name ?? 'User',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
              subtitle: Text(user?.email ?? ''),
            ),
          ),
          const SizedBox(height: 10),
          if (user?.emailVerified != true)
            Card(
              color: AppTheme.blush,
              child: ListTile(
                leading: const Icon(
                  Icons.mark_email_unread,
                  color: AppTheme.hotPink,
                ),
                title: const Text(
                  'Verify email',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: const Text('Confirm your email for account security'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const VerifyEmailScreen()),
                ),
              ),
            ),
          const _SettingsTile(
            icon: Icons.payment,
            title: 'Payments',
            subtitle: 'Cards, payouts, wallet, and billing',
            page: PaymentsScreen(),
          ),
          const _SettingsTile(
            icon: Icons.location_on,
            title: 'Addresses',
            subtitle: 'Shipping and return addresses',
            page: AddressesScreen(),
          ),
          const _SettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Push, email, and promotional alerts',
            page: NotificationsScreen(),
          ),
          const _SettingsTile(
            icon: Icons.language,
            title: 'Language and region',
            subtitle: 'Currency, country, and app language',
            page: LanguageRegionScreen(),
          ),
          const _SettingsTile(
            icon: Icons.palette,
            title: 'Appearance',
            subtitle: 'Theme and display preferences',
            page: AppearanceScreen(),
          ),
          const _SettingsTile(
            icon: Icons.help,
            title: 'Help center',
            subtitle: 'FAQs and support tickets',
            page: HelpCenterScreen(),
          ),
          const SizedBox(height: 16),
          FilledButton.tonalIcon(
            onPressed: () => context.read<AppState>().logout(),
            icon: const Icon(Icons.logout),
            label: const Text('Sign out'),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  final Widget page;

  const _SettingsTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.hotPink),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}
