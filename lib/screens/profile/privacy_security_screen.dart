import 'package:flutter/material.dart';

import '../common/info_page.dart';

class PrivacySecurityScreen extends StatelessWidget {
  const PrivacySecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.shield,
      title: 'Privacy and security',
      subtitle:
          'Manage login security, privacy controls, blocked users, and marketplace data settings.',
      sections: [
        'Password and login',
        'Two-factor authentication',
        'Blocked users',
        'Download account data',
      ],
    );
  }
}
