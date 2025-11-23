import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'widgets/root_scaffold.dart';

import 'screens/home_screen.dart' show HomeScreen;
import 'screens/check_screen.dart' show CheckScreen;
import 'screens/educate_screen.dart' show EducateScreen;

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) =>
          const NoTransitionPage(child: HomeScreen()),
    ),
    GoRoute(
      path: '/check',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: CheckScreen()),
      ),
    ),
    GoRoute(
      path: '/educate',
      pageBuilder: (context, state) => const NoTransitionPage(
        child: RootScaffold(child: EducateScreen()),
      ),
    ),
    GoRoute(
      path: '/forum',
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
