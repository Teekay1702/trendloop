import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class DisputesReturnsScreen extends StatelessWidget {
  const DisputesReturnsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.gavel,
      title: 'Disputes and returns',
      subtitle:
          'Manage return requests, refund cases, and marketplace dispute resolution.',
      sections: [
        'Open cases',
        'Return requests',
        'Refund status',
        'Marketplace decisions',
      ],
    );
  }
}
