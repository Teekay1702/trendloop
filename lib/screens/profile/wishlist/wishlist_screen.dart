import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';
import 'saved_products_screen.dart';
import 'saved_stores_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wishlist',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: AppTheme.blush,
              borderRadius: BorderRadius.circular(26),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.favorite, color: AppTheme.hotPink, size: 42),
                SizedBox(height: 12),
                Text(
                  'Saved products and stores',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 23),
                ),
                SizedBox(height: 8),
                Text(
                  'Items and sellers you favorite will appear here so you can revisit drops later.',
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.favorite_border,
                color: AppTheme.hotPink,
              ),
              title: const Text('Saved products'),
              subtitle: const Text('Tap the heart on any product to save it.'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedProductsScreen()),
              ),
            ),
          ),
          Card(
            child: ListTile(
              leading: const Icon(
                Icons.storefront_outlined,
                color: AppTheme.hotPink,
              ),
              title: const Text('Saved stores'),
              subtitle: const Text(
                'Follow stores to see their new drops here.',
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SavedStoresScreen()),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
