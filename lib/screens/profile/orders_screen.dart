import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../state/app_state.dart';
import '../../theme/app_theme.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  late Future<List<dynamic>> future;

  @override
  void initState() {
    super.initState();
    future = context.read<AppState>().orderService.getOrders();
  }

  Future<void> refresh() async {
    setState(() => future = context.read<AppState>().orderService.getOrders());
    await future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Orders',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: FutureBuilder<List<dynamic>>(
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
            final orders = snapshot.data ?? [];
            if (orders.isEmpty) {
              return ListView(
                padding: const EdgeInsets.all(16),
                children: const [
                  SizedBox(height: 140),
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 54,
                    color: AppTheme.hotPink,
                  ),
                  SizedBox(height: 12),
                  Center(
                    child: Text(
                      'No orders yet',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Your purchases, returns, and dispute updates will appear here.',
                    ),
                  ),
                ],
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                final order = orders[index] as Map<String, dynamic>;
                final items = order['items'] as List? ?? [];
                return Card(
                  child: ExpansionTile(
                    leading: const Icon(
                      Icons.shopping_bag,
                      color: AppTheme.hotPink,
                    ),
                    title: Text(
                      'Order ${order['id'].toString().substring(0, 8)}',
                      style: const TextStyle(fontWeight: FontWeight.w900),
                    ),
                    subtitle: Text(
                      '${items.length} items • ${order['status']}',
                    ),
                    trailing: Text(
                      '\$${(order['total'] as num).toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        color: AppTheme.hotPink,
                      ),
                    ),
                    children: items.map((item) {
                      final map = item as Map<String, dynamic>;
                      return ListTile(
                        title: Text(map['title'] ?? 'Product'),
                        subtitle: Text(
                          'Size ${map['size']} • Qty ${map['quantity']}',
                        ),
                        trailing: Text(
                          '\$${(map['unitPrice'] as num).toStringAsFixed(2)}',
                        ),
                      );
                    }).toList(),
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
