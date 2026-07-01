import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/seller_service.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../product_detail_screen.dart';
import '../sell_screen.dart';

class SellerListingsScreen extends StatefulWidget {
  const SellerListingsScreen({super.key});

  @override
  State<SellerListingsScreen> createState() => _SellerListingsScreenState();
}

class _SellerListingsScreenState extends State<SellerListingsScreen> {
  late Future<SellerStoreData> future;

  @override
  void initState() {
    super.initState();
    future = context.read<AppState>().sellerService.getMyStore();
  }

  Future<void> refresh() async {
    setState(() {
      future = context.read<AppState>().sellerService.getMyStore();
    });

    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Listings',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SellScreen()),
          );
          if (mounted) refresh();
        },
        icon: const Icon(Icons.add),
        label: const Text('New listing'),
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
            final products = snapshot.data!.products;
            if (products.isEmpty)
              return ListView(
                children: const [
                  SizedBox(
                    height: 420,
                    child: Center(
                      child: Text('You have not listed any products yet.'),
                    ),
                  ),
                ],
              );
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(product: product),
                      ),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: product.images.first,
                        width: 62,
                        height: 62,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(
                      '${product.stock} in stock • ${product.condition}',
                    ),
                    trailing: Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: AppTheme.hotPink,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
