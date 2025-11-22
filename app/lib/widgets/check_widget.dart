import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/check.dart';

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

          return _CheckTile(
            check: check,
            isFirst: index == 0,
            isLast: index == checks.length - 1,
          );
        })
      ],
    );
  }
}

class _CheckTile extends StatefulWidget {
  final Check check;
  final bool isFirst;
  final bool isLast;

  const _CheckTile({
    required this.check,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<_CheckTile> createState() => _CheckTileState();
}

class _CheckTileState extends State<_CheckTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final screenWidth = MediaQuery.of(context).size.width;
    final wideScreen = screenWidth > 830;

    return Container(
      width: wideScreen ? screenWidth * 0.45 : screenWidth,
      decoration: BoxDecoration(
        color: cs.surfaceContainerLow,
        borderRadius: _borderRadius,
      ),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: widget.check.description != null
                  ? () => setState(() => _expanded = !_expanded)
                  : null,
              child: Row(
                children: [
                  _statusIcon(widget.check.status),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.check.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        if (!_expanded) Text(widget.check.shortDescription)
                      ],
                    ),
                  ),
                  if (widget.check.description != null)
                    Icon(
                      _expanded ? Icons.expand_less : Icons.expand_more,
                      color: cs.onSecondaryContainer,
                    )
                ],
              ),
            ),
            if (_expanded) ...[
              const SizedBox(height: 3),
              const Divider(),
              const SizedBox(height: 3),
              Text(widget.check.description!),
            ],
          ],
        ),
      ),
    );
  }

  BorderRadius get _borderRadius {
    return BorderRadius.only(
      topLeft: Radius.circular(widget.isFirst ? 18 : 4),
      topRight: Radius.circular(widget.isFirst ? 18 : 4),
      bottomLeft: Radius.circular(widget.isLast ? 18 : 4),
      bottomRight: Radius.circular(widget.isLast ? 18 : 4),
    );
  }

  Widget _statusIcon(CheckStatus status) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    final outerColor = {
      Brightness.light: {
        CheckStatus.verified: Color(0xff95ff7d),
        CheckStatus.questionable: Color(0xffffdb80),
        CheckStatus.falseInfo: Color(0xfffcddda),
        CheckStatus.empty: theme.colorScheme.primary,
      },
      Brightness.dark: {
        CheckStatus.verified: Color(0xff3d7131),
        CheckStatus.questionable: Color(0xff743700),
        CheckStatus.falseInfo: Color(0xff8b1f12),
        CheckStatus.empty: theme.colorScheme.onPrimary,
      }
    }[brightness]![status];

    final innerColor = {
      Brightness.light: {
        CheckStatus.verified: Color(0xff3d7131),
        CheckStatus.questionable: Color(0xffb46000),
        CheckStatus.falseInfo: Color(0xffe43731),
        CheckStatus.empty: theme.colorScheme.onPrimary,
      },
      Brightness.dark: {
        CheckStatus.verified: Color(0xff7ce265),
        CheckStatus.questionable: Color(0xfffdba0b),
        CheckStatus.falseInfo: Color(0xffec9291),
        CheckStatus.empty: theme.colorScheme.primary,
      }
    }[brightness]![status];

    final icon = {
      CheckStatus.verified: Icons.check,
      CheckStatus.questionable: Icons.priority_high,
      CheckStatus.falseInfo: Icons.priority_high,
      CheckStatus.empty: Icons.question_mark,
    }[status];

    return Skeleton.replace(
      replacement: CircleAvatar(radius: 20),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: outerColor,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: innerColor,
          child: Icon(
            icon,
            fontWeight: FontWeight.w900,
            size: 11,
            color: outerColor,
          ),
        ),
      ),
    );
  }
}
