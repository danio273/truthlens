import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const RootScaffold(child: Placeholder()),
    ),
    GoRoute(
      path: '/forum',
      builder: (context, state) => const RootScaffold(child: Placeholder()),
    ),
    GoRoute(
      path: '/educate',
      builder: (context, state) => const RootScaffold(child: Placeholder()),
    ),
    GoRoute(
      path: '/check',
      builder: (context, state) => const RootScaffold(child: Placeholder()),
    ),
  ],
);

class RootScaffold extends StatelessWidget {
  final Widget child;
  const RootScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    TextButton(
                      child: Text(
                        'TruthLens',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      onPressed: () => context.go('/'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/forum'),
                      child: Text('Społeczność'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/educate'),
                      child: const Text('Ucz się z nami'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/check'),
                      child: const Text('Sprawdź tekst'),
                    ),
                  ],
                ),
                CircleAvatar(child: Icon(Icons.person)),
              ],
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
