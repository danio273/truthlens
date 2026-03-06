import 'package:flutter/material.dart';

import '../widgets/html_embed.dart';

import '../widgets/checks_widget.dart';
import '../widgets/check_tile.dart';
import '../models/check.dart';

import '../models/flashcard.dart';
import '../services/mock_flashcards.dart';

import '../models/criteria_data.dart';

import '../widgets/toggle_selector.dart';

enum CardStatus { solve, answer }

class EducateScreen extends StatefulWidget {
  const EducateScreen({super.key});

  @override
  State<EducateScreen> createState() => _EducateScreenState();
}

class _EducateScreenState extends State<EducateScreen> {
  final double boxkWidth = 550;

  List<CheckStatus> userAnswers = List.filled(4, CheckStatus.empty);

  int currentCardIndex = 0;
  final List<Flashcard> cards = falshcards;

  CardStatus status = CardStatus.solve;

  void clear() {
    setState(() {
      userAnswers.fillRange(0, userAnswers.length, CheckStatus.empty);
      status = CardStatus.solve;
    });
  }

  void checkUserAnswers() {
    final correctAnswers =
        cards[currentCardIndex].answer.map((check) => check.status).toList();

    int points = 0;
    final maxPoints = correctAnswers.length * 3;

    for (int i = 0; i < correctAnswers.length; i++) {
      if (userAnswers[i].index == 0) break;

      final diff = (correctAnswers[i].index - userAnswers[i].index).abs();

      if (diff == 0) points += 3;
      if (diff == 1) points += 1;
    }

    double percentage = (points / maxPoints) * 100;

    Icon resultIcon;

    if (percentage >= 75) {
      resultIcon = Icon(Icons.emoji_events, size: 50, color: Colors.green);
    } else if (percentage >= 50) {
      resultIcon =
          Icon(Icons.warning_amber_rounded, size: 50, color: Colors.orange);
    } else {
      resultIcon = Icon(Icons.error, size: 50, color: Colors.red);
    }

    setState(() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(20),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                resultIcon,
                SizedBox(height: 16),
                Text(
                  "$points / $maxPoints",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  "${percentage.toStringAsFixed(0)}%",
                  style: TextStyle(fontSize: 20, color: Colors.grey[600]),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              OutlinedButton.icon(
                icon: Icon(Icons.delete),
                label: Text("Wyczyść"),
                onPressed: () {
                  Navigator.of(context).pop();
                  clear();
                },
              ),
              FilledButton.icon(
                icon: Icon(Icons.close),
                label: Text("Zamknij"),
                onPressed: () {
                  Navigator.of(context).pop();
                  status = CardStatus.answer;
                },
              ),
            ],
          );
        },
      );
    });
  }

  void previousCard() {
    setState(() {
      currentCardIndex--;
      clear();
    });
  }

  void nextCard() {
    setState(() {
      currentCardIndex++;
      clear();
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
                status: userAnswers[index],
              ),
            ),
            const SizedBox(height: 8),
            ToggleSelector(
              width: width,
              options: criterion.options,
              selectedIndex: userAnswers[index].index - 1,
              onChanged: (i) => setState(
                  () => userAnswers[index] = CheckStatus.values[i + 1]),
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

  Widget answerButtons(MainAxisAlignment mainAxisAlignment) {
    return status == CardStatus.solve
        ? FilledButton.icon(
            icon: Icon(Icons.send),
            label: Text("Sprawdź"),
            onPressed: () => checkUserAnswers(),
          )
        : OutlinedButton.icon(
            icon: Icon(Icons.clear),
            label: Text("Wyczyść"),
            onPressed: () => clear(),
          );
  }
}
