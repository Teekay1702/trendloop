import 'package:flutter/material.dart';

import '../common/info_page.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.payment,
      title: 'Payments',
      subtitle:
          'Manage saved cards, seller payouts, invoices, wallet credits, and billing history.',
      sections: [
        'Saved cards',
        'Seller payout account',
        'Wallet credits',
        'Billing history',
      ],
    );
  }
}
