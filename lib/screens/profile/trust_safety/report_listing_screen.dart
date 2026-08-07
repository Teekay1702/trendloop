import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class ReportListingScreen extends StatelessWidget {
  const ReportListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.report,
      title: 'Report a listing or seller',
      subtitle:
          'Flag counterfeit products, unsafe behavior, scams, policy violations, or suspicious seller activity.',
      sections: [
        'Report counterfeit item',
        'Report unsafe behavior',
        'Report payment scam',
        'Block seller',
      ],
    );
  }
}
