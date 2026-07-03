import 'package:flutter/material.dart';

import '../common/info_page.dart';

class BuyerProtectionScreen extends StatelessWidget {
  const BuyerProtectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.lock,
      title: 'Buyer protection',
      subtitle:
          'Learn how eligible purchases are protected against non-delivery and major listing issues.',
      sections: [
        'Eligible orders',
        'Refund rules',
        'Delivery protection',
        'How to open a case',
      ],
    );
  }
}
