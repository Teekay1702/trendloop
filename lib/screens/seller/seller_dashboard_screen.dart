import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/seller_service.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../store_profile_screen.dart';
import '../profile/shipping_labels_screen.dart';
import '../profile/shop_analytics_screen.dart';
import '../profile/promotions_screen.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  late Future<SellerStoreData> future;

  @override
  void initState() {
    super.initState();
    future = context.read<AppState>().sellerService.getMyStore();
  }

  Future<void> refresh() async {
    setState(
      () => future = context.read<AppState>().sellerService.getMyStore(),
    );
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seller Dashboard',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<SellerStoreData>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return const Center(child: CircularProgressIndicator());
            if (snapshot.hasError)
              return ListView(
                children: [
                  SizedBox(
                    height: 420,
                    child: Center(child: Text(snapshot.error.toString())),
                  ),
                ],
              );
            final data = snapshot.data!;
            final revenue = data.products.fold<double>(
              0,
              (sum, item) => sum + item.price,
            );
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
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
                            child: Icon(
                              Icons.storefront,
                              color: AppTheme.hotPink,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.seller.shopName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 23,
                                  ),
                                ),
                                Text(
                                  data.seller.bio.isEmpty
                                      ? 'Manage your seller storefront'
                                      : data.seller.bio,
                                  style: const TextStyle(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 18),
                      FilledButton.tonalIcon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StoreProfileScreen(
                              sellerId: data.seller.id,
                              initialSeller: data.seller,
                            ),
                          ),
                        ),
                        icon: const Icon(Icons.visibility),
                        label: const Text('View public store'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _Metric(
                      label: 'Listings',
                      value: data.products.length.toString(),
                    ),
                    const SizedBox(width: 10),
                    _Metric(
                      label: 'Sales',
                      value: data.seller.sales.toString(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _Metric(
                      label: 'Rating',
                      value: data.seller.rating.toStringAsFixed(1),
                    ),
                    const SizedBox(width: 10),
                    _Metric(
                      label: 'Inventory value',
                      value: '\$${revenue.toStringAsFixed(0)}',
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Seller tools',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.local_shipping,
                      color: AppTheme.hotPink,
                    ),
                    title: const Text('Shipping labels'),
                    subtitle: const Text('Create and track shipments'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShippingLabelsScreen(),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.analytics,
                      color: AppTheme.hotPink,
                    ),
                    title: const Text('Analytics'),
                    subtitle: const Text('Views, favorites, conversions'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ShopAnalyticsScreen(),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.campaign,
                      color: AppTheme.hotPink,
                    ),
                    title: const Text('Promotions'),
                    subtitle: const Text('Boost listings and run discounts'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const PromotionsScreen(),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;
  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.hotPink,
                ),
              ),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
