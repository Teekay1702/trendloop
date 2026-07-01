import 'package:flutter/material.dart';

import '../common/info_page.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.help,
      title: 'Help center',
      subtitle:
          'Find FAQs, contact support, review marketplace policies, and track support tickets.',
      sections: [
        'Buyer FAQs',
        'Seller FAQs',
        'Contact support',
        'Support ticket history',
      ],
    );
  }
}
