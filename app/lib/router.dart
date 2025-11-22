import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'screens/home_screen.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/forum',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: Placeholder()),
      ),
    ),
    GoRoute(
      path: '/educate',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: Placeholder()),
      ),
    ),
    GoRoute(
      path: '/check',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: Placeholder()),
      ),
    ),
    GoRoute(
      path: '/extension',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: Placeholder()),
      ),
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
                      onPressed: () => context.go('/check'),
                      child: const Text('Sprawdź tekst'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/educate'),
                      child: const Text('Ucz się'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/forum'),
                      child: Text('Społeczność'),
                    ),
                    const SizedBox(width: 18),
                    TextButton(
                      onPressed: () => context.go('/extension'),
                      child: const Text('Pobierz rozszerzenie'),
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
