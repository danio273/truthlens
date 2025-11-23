import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/navigation_item.dart';

class RootScaffold extends StatelessWidget {
  final Widget child;
  const RootScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 650;

    final navItems = [
      NavigationItem(label: 'Sprawdź tekst', route: '/check'),
      NavigationItem(label: 'Ucz się', route: '/educate'),
      NavigationItem(label: 'Społeczność', route: '/forum'),
    ];

    return Scaffold(
      drawer: isMobile ? _MobileDrawer(navItems: navItems) : null,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primaryContainer,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.07),
        title: Row(
          children: [
            TextButton(
              child: Text(
                'TruthLens',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () => context.go('/'),
            ),
            const SizedBox(width: 24),
            if (!isMobile)
              Row(
                children: [
                  for (final item in navItems)
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: _NavButton(item: item),
                    ),
                ],
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Center(child: child),
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final List<NavigationItem> navItems;
  const _MobileDrawer({required this.navItems});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'TruthLens',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView(
                children: [
                  for (final item in navItems)
                    ListTile(
                      title: Text(
                        item.label,
                        style: theme.textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.go(item.route);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final NavigationItem item;
  const _NavButton({required this.item});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => context.go(item.route),
      child: Text(
        item.label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
