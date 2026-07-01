import 'package:flutter/material.dart';

import '../common/info_page.dart';

class ShippingLabelsScreen extends StatelessWidget {
  const ShippingLabelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.local_shipping,
      title: 'Shipping labels',
      subtitle:
          'Prepare parcels, buy labels, print packing slips, and track delivery progress for seller orders.',
      sections: [
        'Create a shipping label',
        'Print packing slip',
        'Track active shipments',
        'Manage return labels',
      ],
    );
  }
}
