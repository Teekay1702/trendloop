import 'package:flutter/material.dart';

import '../common/info_page.dart';

class SellerOrderDetailsScreen extends StatelessWidget {
  const SellerOrderDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.inbox_outlined,
      title: 'Seller order details',
      subtitle:
          'Orders from buyers will appear here with fulfillment, shipping, and buyer communication tools.',
      sections: [
        'Paid orders',
        'Packing queue',
        'Shipment tracking',
        'Buyer messages',
      ],
    );
  }
}

class SellerOrdersRoadmapScreen extends StatelessWidget {
  const SellerOrdersRoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const InfoPage(
      icon: Icons.info_outline,
      title: 'Seller orders roadmap',
      subtitle:
          'Production seller order management needs seller-specific order filtering and fulfillment workflows.',
      sections: [
        'Add seller order API',
        'Filter order items by seller',
        'Add fulfillment statuses',
        'Add shipping label integration',
      ],
    );
  }
}
