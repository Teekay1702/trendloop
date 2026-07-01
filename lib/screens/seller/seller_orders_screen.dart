import 'package:flutter/material.dart';

import 'seller_order_details_screen.dart';

class SellerOrdersScreen extends StatelessWidget {
  const SellerOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seller Orders',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: ListTile(
              leading: const Icon(Icons.inbox_outlined),
              title: const Text('No seller orders yet'),
              subtitle: const Text('Orders from buyers will appear here.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellerOrderDetailsScreen(),
                ),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('Next step'),
              subtitle: const Text(
                'Add seller-specific order filtering on the backend for production.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellerOrdersRoadmapScreen(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
