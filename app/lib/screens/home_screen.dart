import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/step_item.dart';

import '../models/navigation_item.dart';
import '../widgets/bottom_navigation.dart';

import '../utils/open_url.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final repoUrl = "https://github.com/danio273/truthlens";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
              color: theme.colorScheme.primaryContainer,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TruthLens – Twoje narzędzie do analizy tekstów',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Sprawdzaj, ucz się, dziel się faktami',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 16,
                    runSpacing: 8,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.go('/check');
                        },
                        child: const Text('Sprawdź teraz'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.go('/educate');
                        },
                        child: const Text('Ucz się'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.go('/forum');
                        },
                        child: const Text('Społeczność'),
                      ),
                      FilledButton(
                        onPressed: () {
                          context.go('/extension');
                        },
                        child: const Text('Rozszerzenie'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'O projekcie',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'TruthLens analizuje teksty pod kątem wiarygodności źródła, logiki, presji emocjonalnej i struktury manipulacyjnej. '
                    'Uczy rozpoznawać fake newsy i pozwala dzielić się wiedzą w społeczności.',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Funkcje',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _FeatureCard(
                        title: 'Rozszerzenie',
                        description:
                            'Analizuj teksty bezpośrednio w przeglądarce.',
                        icon: Icons.analytics,
                      ),
                      _FeatureCard(
                        title: 'Ucz się',
                        description:
                            'Rozpoznawaj fake newsy za pomocą flashcards.',
                        icon: Icons.school,
                      ),
                      _FeatureCard(
                        title: 'Społeczność',
                        description:
                            'Dziel się odkryciami, dyskutuj i weryfikuj wpisy.',
                        icon: Icons.people,
                      ),
                      _FeatureCard(
                        title: 'API dla developerów',
                        description:
                            'Samodzielne API gotowe do integracji w każdej aplikacji.',
                        icon: Icons.api,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Container(
              color: theme.colorScheme.surfaceContainerHigh,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jak to działa',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  StepItem(
                    number: 1,
                    text: 'Zainstaluj rozszerzenie przeglądarki',
                  ),
                  StepItem(
                    number: 2,
                    text: 'Zaznacz tekst na stronie',
                  ),
                  StepItem(
                    number: 3,
                    text: 'Kliknij ikonę → zobacz analizę',
                  ),
                  StepItem(
                    number: 4,
                    text: 'Ucz się na flashcards / dziel się w forum',
                  ),
                ],
              ),
            ),
            BottomNavigation(
              items: [
                NavigationItem(
                  route: '/extension',
                  label: 'Zainstaluj roszerzenie teraz',
                ),
                NavigationItem(
                  route: '/',
                  label: 'Repozytorium GitHub',
                  onPressed: () => openUrl(repoUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;

  const _FeatureCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 48, color: theme.colorScheme.onSecondaryContainer),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSecondaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.textTheme.bodyMedium
                ?.copyWith(color: theme.colorScheme.onSecondaryContainer),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
