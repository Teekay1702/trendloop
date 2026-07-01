import 'package:flutter/material.dart';

import '../common/info_page.dart';

class PromotionsScreen extends StatelessWidget {
  const PromotionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.campaign,
      title: 'Promotions',
      subtitle:
          'Boost listings, create coupons, and run limited-time store discounts for buyers.',
      sections: [
        'Create coupon',
        'Run flash discount',
        'Boost a listing',
        'Review campaign results',
      ],
    );
  }
}
