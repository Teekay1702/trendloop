import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_theme.dart';

class SellScreen extends StatefulWidget {
  const SellScreen({super.key});

  @override
  State<SellScreen> createState() => _SellScreenState();
}

class _SellScreenState extends State<SellScreen> {
  final title = TextEditingController();
  final description = TextEditingController();
  final price = TextEditingController();
  String category = 'Women';
  String condition = 'Like new';
  bool submitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sell an item',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppTheme.ink,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Row(
              children: [
                Icon(Icons.auto_awesome, color: AppTheme.hotPink),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Turn your closet into a storefront. Add photos, set your price, and ship when sold.',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _PhotoDropzone(),
          const SizedBox(height: 14),
          TextField(
            controller: title,
            decoration: const InputDecoration(labelText: 'Listing title'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: description,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            value: category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: [
              'Women',
              'Outerwear',
              'Shoes',
              'Accessories',
              'Denim',
              'Sets',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => category = v!),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField(
            value: condition,
            decoration: const InputDecoration(labelText: 'Condition'),
            items: [
              'New',
              'New with tags',
              'Like new',
              'Excellent',
              'Good',
            ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => setState(() => condition = v!),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: price,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Price',
              prefixText: '\$',
            ),
          ),
          const SizedBox(height: 22),
          FilledButton(
            onPressed: submitting
                ? null
                : () async {
                    setState(() => submitting = true);
                    final state = context.read<AppState>();
                    try {
                      if (!state.isLoggedIn) {
                        throw Exception(
                          'Please create an account or sign in before listing products.',
                        );
                      }
                      if (!state.isSeller) {
                        throw Exception(
                          'Your account needs a seller shop before listing products. Create one during registration.',
                        );
                      }
                      await state.createProduct({
                        'title': title.text,
                        'description': description.text,
                        'category': category,
                        'condition': condition,
                        'price': double.tryParse(price.text) ?? 0,
                        'sizes': ['S', 'M', 'L'],
                        'stock': 1,
                      });
                      await state.loadProducts();
                      if (context.mounted)
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Listing created')),
                        );
                    } catch (e) {
                      if (context.mounted)
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      if (mounted) setState(() => submitting = false);
                    }
                  },
            child: Text(submitting ? 'Publishing...' : 'Publish listing'),
          ),
        ],
      ),
    );
  }
}

class _PhotoDropzone extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo_outlined, size: 34),
          SizedBox(height: 8),
          Text(
            'Add up to 8 photos',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          Text('Demo uses a default product image'),
        ],
      ),
    );
  }
}
