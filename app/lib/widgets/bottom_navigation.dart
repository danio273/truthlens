import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/navigation_item.dart';

class BottomNavigation extends StatelessWidget {
  final List<NavigationItem> items;

  const BottomNavigation({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Wrap(
        spacing: 16,
        runSpacing: 8,
        alignment: WrapAlignment.center,
        children: items
            .map((item) => _bottomNavigationButton(context, item))
            .toList(),
      ),
    );
  }

  ElevatedButton _bottomNavigationButton(
      BuildContext context, NavigationItem item) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: () {
        item.onPressed?.call();
        context.go(item.route);
      },
      child: Text(
        item.label,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
