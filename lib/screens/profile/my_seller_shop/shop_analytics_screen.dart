import 'package:flutter/material.dart';

import '../../common/info_page.dart';

class ShopAnalyticsScreen extends StatelessWidget {
  const ShopAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.analytics,
      title: 'Shop analytics',
      subtitle:
          'Track store performance, listing views, favorites, conversion rate, and sales trends.',
      sections: [
        'Views and visitors',
        'Listing favorites',
        'Conversion rate',
        'Revenue and sales trends',
      ],
    );
  }
}
