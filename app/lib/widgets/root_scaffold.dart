import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScaffold extends StatelessWidget {
  final Widget child;
  const RootScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMobile = MediaQuery.of(context).size.width < 650;

    final navItems = [
      ('Sprawdź tekst', '/check'),
      ('Ucz się', '/educate'),
      ('Społeczność', '/forum'),
      ('Rozszerzenie', '/extension'),
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
                      child: _NavButton(
                        label: item.$1,
                        route: item.$2,
                      ),
                    ),
                ],
              ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: child,
      ),
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  final List<(String, String)> navItems;
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
                        item.$1,
                        style: theme.textTheme.bodyLarge,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        context.go(item.$2);
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
  final String label;
  final String route;
  const _NavButton({required this.label, required this.route});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextButton(
      onPressed: () => context.go(route),
      child: Text(
        label,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onPrimaryContainer,
        ),
      ),
    );
  }
}
