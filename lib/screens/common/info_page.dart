import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';

class InfoPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final List<String> sections;
  final Widget? action;

  const InfoPage({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.sections = const [],
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title, style: const TextStyle(fontWeight: FontWeight.w900))),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(color: AppTheme.blush, borderRadius: BorderRadius.circular(26)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(icon, color: AppTheme.hotPink, size: 44),
              const SizedBox(height: 14),
              Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 24)),
              const SizedBox(height: 8),
              Text(subtitle, style: const TextStyle(height: 1.4)),
            ]),
          ),
          const SizedBox(height: 16),
          if (sections.isEmpty)
            const Card(
              child: ListTile(
                leading: Icon(Icons.construction, color: AppTheme.hotPink),
                title: Text('Page ready for implementation', style: TextStyle(fontWeight: FontWeight.w900)),
                subtitle: Text('Connect backend data, forms, and workflows here as the feature grows.'),
              ),
            )
          else
            ...sections.map((section) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const Icon(Icons.check_circle_outline, color: AppTheme.hotPink),
                    title: Text(section, style: const TextStyle(fontWeight: FontWeight.w800)),
                  ),
                )),
          if (action != null) ...[
            const SizedBox(height: 12),
            action!,
          ],
        ],
      ),
    );
  }
}
