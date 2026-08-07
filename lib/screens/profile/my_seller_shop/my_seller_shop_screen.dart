import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../state/app_state.dart';
import '../../../theme/app_theme.dart';
import '../../seller/seller_dashboard_screen.dart';
import '../../seller/seller_listings_screen.dart';
import 'shipping_labels_screen.dart';
import 'shop_analytics_screen.dart';
import '../../store_profile_screen.dart';

class MySellerShopScreen extends StatelessWidget {
  const MySellerShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AppState>().currentUser;
    final seller = user?.seller;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My seller shop',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (seller == null)
            _EmptySellerShop()
          else ...[
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                gradient: const LinearGradient(
                  colors: [AppTheme.ink, Color(0xFF4B1732)],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.storefront, color: AppTheme.hotPink),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              seller.shopName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 24,
                              ),
                            ),
                            Text(
                              seller.bio.isEmpty
                                  ? 'Your seller storefront'
                                  : seller.bio,
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _ShopMetric(
                        label: 'Rating',
                        value: seller.rating.toStringAsFixed(1),
                      ),
                      _ShopMetric(
                        label: 'Followers',
                        value: seller.followers.toString(),
                      ),
                      _ShopMetric(
                        label: 'Sales',
                        value: seller.sales.toString(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _ActionTile(
              icon: Icons.dashboard,
              title: 'Seller dashboard',
              subtitle: 'View analytics and seller tools',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SellerDashboardScreen(),
                ),
              ),
            ),
            _ActionTile(
              icon: Icons.inventory_2,
              title: 'Manage listings',
              subtitle: 'Create and review your products',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SellerListingsScreen()),
              ),
            ),
            _ActionTile(
              icon: Icons.visibility,
              title: 'View public store',
              subtitle: 'See what buyers see',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => StoreProfileScreen(
                    sellerId: seller.id,
                    initialSeller: seller,
                  ),
                ),
              ),
            ),
            _ActionTile(
              icon: Icons.local_shipping,
              title: 'Shipping labels',
              subtitle: 'Prepare parcels and track shipping',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShippingLabelsScreen()),
              ),
            ),
            _ActionTile(
              icon: Icons.analytics,
              title: 'Shop analytics',
              subtitle: 'Views, favorites, sales performance',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ShopAnalyticsScreen()),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EmptySellerShop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppTheme.blush,
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.storefront, color: AppTheme.hotPink, size: 42),
            const SizedBox(height: 12),
            const Text(
              'You do not have a seller shop yet',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 22),
            ),
            const SizedBox(height: 8),
            const Text(
              'Create a seller profile to list products and manage your own storefront.',
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {},
              child: const Text('Seller onboarding coming soon'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShopMetric extends StatelessWidget {
  final String label;
  final String value;

  const _ShopMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(.14),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 18,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const _ActionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.hotPink),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
