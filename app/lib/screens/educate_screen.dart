import 'package:flutter/material.dart';

import '../widgets/html_embed.dart';

import '../widgets/checks_widget.dart';
import '../widgets/check_tile.dart';
import '../models/check.dart';

import '../models/flashcard.dart';
import '../services/mock_flashcards.dart';

import '../models/criteria_data.dart';

import '../widgets/toggle_selector.dart';

const numberStatus = {
  -1: CheckStatus.empty,
  0: CheckStatus.verified,
  1: CheckStatus.questionable,
  2: CheckStatus.falseInfo,
};

enum CardStatus { solve, answer }

class EducateScreen extends StatefulWidget {
  const EducateScreen({super.key});

  @override
  State<EducateScreen> createState() => _EducateScreenState();
}

class _EducateScreenState extends State<EducateScreen> {
  final double boxkWidth = 550;

  List<int> selectedIndexes = List.filled(4, -1);

  int currentCardIndex = 0;
  final List<Flashcard> cards = falshcards;

  CardStatus status = CardStatus.solve;

  void clear() {
    setState(() {
      selectedIndexes.fillRange(0, selectedIndexes.length, -1);
      status = CardStatus.solve;
    });
  }

  void checkAnswers() {
    setState(() {
      status = CardStatus.answer;
    });
  }

  void previousCard() {
    setState(() {
      currentCardIndex--;
      status = CardStatus.solve;
      selectedIndexes.fillRange(0, selectedIndexes.length, -1);
    });
  }

  void nextCard() {
    setState(() {
      currentCardIndex++;
      status = CardStatus.solve;
      selectedIndexes.fillRange(0, selectedIndexes.length, -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final wideScreen = screenWidth > 1150;
    final mainAxisAlignment =
        wideScreen ? MainAxisAlignment.start : MainAxisAlignment.spaceBetween;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ucz się z nami", style: theme.textTheme.titleLarge),
        const SizedBox(height: 8),
        Text(
          'Analizuj krótkie teksty i ćwicz rozpoznawanie manipulacji, presji emocjonalnej i jakości źródeł.',
          style: theme.textTheme.bodyLarge,
        ),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            SizedBox(
              width: boxkWidth,
              child: cardBuild(mainAxisAlignment),
            ),
            SizedBox(
              width: boxkWidth,
              child: solveBuild(wideScreen, screenWidth, mainAxisAlignment),
            ),
          ],
        ),
      ],
    );
  }

  Column cardBuild(MainAxisAlignment mainAxisAlignment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TwitterEmbed(url: cards[currentCardIndex].url),
        SizedBox(height: 10),
        cardButtons(mainAxisAlignment),
      ],
    );
  }

  Padding solveBuild(bool wideScreen, double screenWidth,
      MainAxisAlignment mainAxisAlignment) {
    return Padding(
        padding: wideScreen
            ? EdgeInsets.only(left: 15)
            : const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (status == CardStatus.solve)
              ...criteriaList(screenWidth > 500 ? boxkWidth : screenWidth),
            if (status == CardStatus.answer) ...[
              ChecksWidget(
                checks: cards[currentCardIndex].answer,
              ),
              SizedBox(height: 10),
            ],
            answerButtons(mainAxisAlignment),
          ],
        ));
  }

  List<Padding> criteriaList(double width) {
    return criteria.asMap().entries.map((entry) {
      final index = entry.key;
      final criterion = entry.value;

      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Column(
          children: [
            CheckTile(
              check: Check(
                title: criterion.title,
                shortDescription: criterion.shortDescription,
                description: criterion.description,
                status: numberStatus[selectedIndexes[index]]!,
              ),
            ),
            const SizedBox(height: 8),
            ToggleSelector(
              width: width,
              options: criterion.options,
              selectedIndex: selectedIndexes[index],
              onChanged: (i) => setState(() => selectedIndexes[index] = i),
            ),
          ],
        ),
      );
    }).toList();
  }

  Row cardButtons(MainAxisAlignment mainAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        OutlinedButton.icon(
          icon: Icon(Icons.skip_previous),
          label: Text("Poprzedni"),
          onPressed: currentCardIndex > 0 ? () => previousCard() : null,
        ),
        SizedBox(width: 10),
        FilledButton.icon(
          icon: Icon(Icons.skip_next),
          label: Text("Następny"),
          onPressed:
              currentCardIndex < cards.length - 1 ? () => nextCard() : null,
        ),
      ],
    );
  }

  Row answerButtons(MainAxisAlignment mainAxisAlignment) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        FilledButton.icon(
          icon: Icon(Icons.send),
          label: Text("Sprawdź"),
          onPressed: () => checkAnswers(),
        ),
        const SizedBox(width: 10),
        OutlinedButton.icon(
          icon: Icon(Icons.clear),
          label: Text("Wyczyść"),
          onPressed: () => clear(),
        ),
      ],
    );
  }
}
