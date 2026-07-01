import 'package:flutter/material.dart';

import '../common/info_page.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.notifications,
      title: 'Notifications',
      subtitle:
          'Control push, email, and promotional alerts for orders, offers, drops, and seller activity.',
      sections: [
        'Order updates',
        'New store drops',
        'Seller messages',
        'Promotions and coupons',
      ],
    );
  }
}
