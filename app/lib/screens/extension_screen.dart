import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/step_item.dart';
import '../utils/download_from_url.dart';

class ExtensionScreen extends StatelessWidget {
  const ExtensionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final String extensionUrl =
        "https://raw.githubusercontent.com/danio273/truthlens/main/ext/extension.crx";

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
                    'Rozszerzenie TruthLens',
                    style: theme.textTheme.displaySmall?.copyWith(
                      color: theme.colorScheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Analizuj teksty bezpośrednio w przeglądarce i ucz się rozpoznawać fake newsy',
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
                        onPressed: () => downloadFromUrl(extensionUrl),
                        child: const Text('Pobierz rozszerzenie (CRX)'),
                      ),
                      OutlinedButton(
                        onPressed: () => context.go('/'),
                        child: const Text('Powrót do strony głównej'),
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
                    'Jak to działa',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  StepItem(
                    number: 1,
                    text: 'Zaznacz tekst na dowolnej stronie internetowej',
                  ),
                  StepItem(
                    number: 2,
                    text: 'Kliknij ikonę rozszerzenia w przeglądarce',
                  ),
                  StepItem(
                    number: 3,
                    text:
                        'Zobacz analizę: wiarygodność źródła, logika, presja emocjonalna, manipulacja',
                  ),
                  StepItem(
                    number: 4,
                    text:
                        'Ucz się na flashcards lub dziel się w forum społeczności',
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
                    'Instrukcja instalacji rozszerzenia z pliku CRX',
                    style: theme.textTheme.headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  InstructionStep(
                    number: 1,
                    text: 'Pobierz plik .crx na swój komputer.',
                  ),
                  InstructionStep(
                    number: 2,
                    text:
                        'Otwórz Chrome, kliknij trzy kropki > Rozszerzenia > Zarządzaj rozszerzeniami',
                    shortcutText:
                        'Alternatywnie: przejdź do chrome://extensions/',
                  ),
                  InstructionStep(
                    number: 3,
                    text:
                        'Włącz tryb deweloperski (Developer mode) w prawym górnym rogu.',
                  ),
                  InstructionStep(
                    number: 4,
                    text:
                        'Przeciągnij plik .crx na stronę rozszerzeń i potwierdź instalację.',
                  ),
                  InstructionStep(
                    number: 5,
                    text:
                        'Rozszerzenie powinno pojawić się w pasku narzędzi przeglądarki.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            ColoredBox(
              color: theme.colorScheme.surfaceContainerHigh,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Wrap(
                  spacing: 16,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    _bottomNavigationButton(context, '/check', 'Sprawdź tekst'),
                    _bottomNavigationButton(context, '/educate', 'Ucz się'),
                    _bottomNavigationButton(context, '/forum', 'Społeczność'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ElevatedButton _bottomNavigationButton(
      BuildContext context, String route, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      onPressed: () => context.go(route),
      child: Text(label),
    );
  }
}
