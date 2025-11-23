import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RootScaffold extends StatelessWidget {
  final Widget child;
  const RootScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              boxShadow: [
                BoxShadow(
                  color: Colors.black..withValues(alpha: 0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 0.5),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      onPressed: () => context.go('/'),
                      child: Text(
                        'TruthLens',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    _NavButton(label: 'Sprawdź tekst', route: '/check'),
                    _NavButton(label: 'Ucz się', route: '/educate'),
                    _NavButton(label: 'Społeczność', route: '/forum'),
                    _NavButton(label: 'Rozszerzenie', route: '/extension'),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: child,
              ),
            ),
          ),
        ],
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
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: TextButton(
        onPressed: () => context.go(route),
        child: Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ),
    );
  }
}
