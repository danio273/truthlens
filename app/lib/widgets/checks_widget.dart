import 'package:flutter/material.dart';
import '../models/check.dart';

import 'check_tile.dart';

class ChecksWidget extends StatelessWidget {
  final List<Check> checks;

  const ChecksWidget({
    super.key,
    List<Check>? checks,
  }) : checks = checks ??
            const [
              Check(
                title: "Wiarygodność źródła",
                shortDescription:
                    "Sprawdza, czy informacje pochodzą z rzetelnych źródeł.",
              ),
              Check(
                title: "Jakość logiki",
                shortDescription: "Ocena, czy wnioski są logiczne i sensowne.",
              ),
              Check(
                title: "Presja emocjonalna",
                shortDescription:
                    "Analizuje, czy tekst wywołuje emocje, manipulując odbiorcą.",
              ),
              Check(
                title: "Struktura manipulacyjna",
                shortDescription:
                    "Sprawdza, czy struktura tekstu kieruje opinią czy informuje.",
              ),
            ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...checks.asMap().entries.map((entry) {
          final index = entry.key;
          final check = entry.value;

          return CheckTile(
            check: check,
            isFirst: index == 0,
            isLast: index == checks.length - 1,
          );
        })
      ],
    );
  }
}
