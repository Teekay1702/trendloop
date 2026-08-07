import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';
import '../screens/auth/login_screen.dart';
import 'profile/my_seller_shop/my_seller_shop_screen.dart';
import 'profile/orders_screen.dart';
import 'profile/settings/settings_screen.dart';
import 'profile/trust_safety/trust_safety_screen.dart';
import 'profile/wishlist/wishlist_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final user = state.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Me', style: TextStyle(fontWeight: FontWeight.w900)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 34,
                  backgroundColor: AppTheme.blush,
                  child: Icon(Icons.person, color: AppTheme.hotPink, size: 34),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user?.name ?? 'Guest shopper',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user == null
                            ? 'Create an account to buy, sell, and track orders'
                            : user.isSeller
                            ? '${user.seller!.shopName} seller account active'
                            : user.email,
                      ),
                    ],
                  ),
                ),
                if (user == null)
                  FilledButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                    ),
                    child: const Text('Sign in'),
                  )
                else
                  IconButton(
                    onPressed: () => state.logout(),
                    icon: const Icon(Icons.logout),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          if (user == null)
            Card(
              color: AppTheme.blush,
              child: ListTile(
                leading: const Icon(Icons.person_add, color: AppTheme.hotPink),
                title: const Text(
                  'Create your marketplace account',
                  style: TextStyle(fontWeight: FontWeight.w900),
                ),
                subtitle: const Text(
                  'Register as a buyer or create a seller shop in one step.',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                ),
              ),
            ),
          _Tile(
            icon: Icons.storefront,
            title: 'My seller shop',
            subtitle: 'Listings, analytics, shipping labels',
            page: const MySellerShopScreen(),
          ),
          _Tile(
            icon: Icons.receipt_long,
            title: 'Orders',
            subtitle: 'Purchases, returns, disputes',
            page: const OrdersScreen(),
          ),
          _Tile(
            icon: Icons.favorite,
            title: 'Wishlist',
            subtitle: 'Saved drops and sellers',
            page: const WishlistScreen(),
          ),
          _Tile(
            icon: Icons.verified_user,
            title: 'Trust & safety',
            subtitle: 'Verification, buyer protection',
            page: const TrustSafetyScreen(),
          ),
          _Tile(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'Payments, addresses, notifications',
            page: const SettingsScreen(),
          ),
        ],
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Widget page;
  const _Tile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Icon(icon, color: AppTheme.hotPink),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () =>
            Navigator.push(context, MaterialPageRoute(builder: (_) => page)),
      ),
    );
  }
}
