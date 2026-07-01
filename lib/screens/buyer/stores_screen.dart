import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/store_summary.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../store_profile_screen.dart';

class StoresScreen extends StatefulWidget {
  const StoresScreen({super.key});

  @override
  State<StoresScreen> createState() => _StoresScreenState();
}

class _StoresScreenState extends State<StoresScreen> {
  late Future<List<StoreSummary>> future;

  @override
  void initState() {
    super.initState();
    future = context.read<AppState>().sellerService.getStores();
  }

  Future<void> refresh() async {
    setState(() => future = context.read<AppState>().sellerService.getStores());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Stores',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<List<StoreSummary>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return ListView(
                children: [
                  SizedBox(
                    height: 420,
                    child: Center(child: Text(snapshot.error.toString())),
                  ),
                ],
              );
            }
            final stores = snapshot.data ?? [];
            if (stores.isEmpty) {
              return ListView(
                children: const [
                  SizedBox(
                    height: 420,
                    child: Center(
                      child: Text('No stores have been created yet.'),
                    ),
                  ),
                ],
              );
            }
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: stores.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (_, index) => _StoreCard(store: stores[index]),
            );
          },
        ),
      ),
    );
  }
}

class _StoreCard extends StatelessWidget {
  final StoreSummary store;

  const _StoreCard({required this.store});

  @override
  Widget build(BuildContext context) {
    final seller = store.seller;
    return InkWell(
      borderRadius: BorderRadius.circular(26),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              StoreProfileScreen(sellerId: seller.id, initialSeller: seller),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.blush,
                    child: Icon(Icons.storefront, color: AppTheme.hotPink),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Flexible(
                              child: Text(
                                seller.shopName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (seller.verified)
                              const Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                  size: 17,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          '${store.productCount} products • ${seller.followers} followers • ${seller.rating.toStringAsFixed(1)} ★',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.chevron_right),
                ],
              ),
              if (seller.bio.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(seller.bio, maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
              if (store.previewProducts.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 92,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: store.previewProducts.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (_, index) => ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: store.previewProducts[index].images.first,
                        width: 82,
                        height: 92,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
