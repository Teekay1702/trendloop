import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'account_verification_screen.dart';
import 'buyer_protection_screen.dart';
import 'disputes_returns_screen.dart';
import 'privacy_security_screen.dart';
import 'report_listing_screen.dart';

class TrustSafetyScreen extends StatelessWidget {
  const TrustSafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trust & safety',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SafetyCard(
            icon: Icons.verified_user,
            title: 'Account verification',
            subtitle: 'Verify your identity to increase marketplace trust.',
            page: AccountVerificationScreen(),
          ),
          _SafetyCard(
            icon: Icons.lock,
            title: 'Buyer protection',
            subtitle:
                'Eligible orders are protected against non-delivery and major listing issues.',
            page: BuyerProtectionScreen(),
          ),
          _SafetyCard(
            icon: Icons.report,
            title: 'Report a listing or seller',
            subtitle:
                'Flag suspicious products, counterfeit items, or unsafe behavior.',
            page: ReportListingScreen(),
          ),
          _SafetyCard(
            icon: Icons.gavel,
            title: 'Disputes and returns',
            subtitle:
                'Manage return requests, refunds, and marketplace dispute cases.',
            page: DisputesReturnsScreen(),
          ),
          _SafetyCard(
            icon: Icons.shield,
            title: 'Privacy and security',
            subtitle:
                'Review login security, blocked users, and data controls.',
            page: PrivacySecurityScreen(),
          ),
        ],
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget page;

  const _SafetyCard({
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
