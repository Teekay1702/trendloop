import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../state/app_state.dart';
import '../../theme/app_theme.dart';
import '../product_detail_screen.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  final searchController = TextEditingController();
  final categories = const ['All', 'Women', 'Outerwear', 'Shoes', 'Accessories', 'Denim', 'Sets'];

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () => state.loadProducts(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              title: const Text('TrendLoop', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.8)),
              actions: [
                IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
                IconButton(onPressed: () {}, icon: const Icon(Icons.notifications_none)),
              ],
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(74),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: TextField(
                    controller: searchController,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) => state.loadProducts(query: value),
                    decoration: InputDecoration(
                      hintText: 'Search dresses, cargos, gold hoops...',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.tune),
                        onPressed: () {},
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: _HeroDeal()),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 54,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) {
                    final category = categories[i];
                    final selected = state.selectedCategory == category;
                    return ChoiceChip(
                      selected: selected,
                      label: Text(category),
                      onSelected: (_) => state.selectCategory(category),
                      selectedColor: AppTheme.ink,
                      labelStyle: TextStyle(color: selected ? Colors.white : AppTheme.ink, fontWeight: FontWeight.w700),
                      side: BorderSide.none,
                      backgroundColor: Colors.white,
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemCount: categories.length,
                ),
              ),
            ),
            if (state.loading)
              const SliverFillRemaining(child: Center(child: CircularProgressIndicator()))
            else if (state.error != null)
              SliverFillRemaining(child: Center(child: Text(state.error!)))
            else
              SliverPadding(
                padding: const EdgeInsets.all(16),
                sliver: SliverGrid.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .58,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (_, i) => ProductCard(product: state.products[i]),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _HeroDeal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 10, 16, 16),
      padding: const EdgeInsets.all(20),
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(colors: [AppTheme.ink, Color(0xFF4B1732)]),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: AppTheme.hotPink, borderRadius: BorderRadius.circular(999)),
                  child: const Text('P2P DROP LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 11)),
                ),
                const SizedBox(height: 12),
                const Text('Closet finds up to 70% off', style: TextStyle(color: Colors.white, fontSize: 24, height: 1, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                const Text('Buy from verified community sellers', style: TextStyle(color: Colors.white70)),
              ],
            ),
          ),
          const Icon(Icons.local_fire_department, color: AppTheme.hotPink, size: 58),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final discount = product.originalPrice == null ? null : ((1 - product.price / product.originalPrice!) * 100).round();
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product))),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(imageUrl: product.images.first, fit: BoxFit.cover),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.9),
                      child: const Icon(Icons.favorite_border, size: 20),
                    ),
                  ),
                  if (discount != null)
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        decoration: BoxDecoration(color: AppTheme.hotPink, borderRadius: BorderRadius.circular(999)),
                        child: Text('-$discount%', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w900)),
                      ),
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(product.title, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700)),
                const SizedBox(height: 5),
                Text(product.seller?.shopName ?? 'Community seller', style: const TextStyle(fontSize: 12, color: Colors.black54)),
                const SizedBox(height: 6),
                Row(children: [
                  Text('\$${product.price.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 16, color: AppTheme.hotPink)),
                  const Spacer(),
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  Text(product.rating.toStringAsFixed(1), style: const TextStyle(fontSize: 12)),
                ]),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
