import 'package:flutter/material.dart';

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
        children: const [
          Card(
            child: ListTile(
              leading: Icon(Icons.inbox_outlined),
              title: Text('No seller orders yet'),
              subtitle: Text('Orders from buyers will appear here.'),
            ),
          ),
          Card(
            child: ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Next step'),
              subtitle: Text(
                'Add seller-specific order filtering on the backend for production.',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
