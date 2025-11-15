import 'package:flutter/material.dart';
import '../data/model.dart';

class CheckTile extends StatefulWidget {
  final Check check;
  final bool isFirst;
  final bool isLast;

  const CheckTile({
    super.key,
    required this.check,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<CheckTile> createState() => _CheckTileState();
}

class _CheckTileState extends State<CheckTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: _borderRadius,
      ),
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () => setState(() => _expanded = !_expanded),
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
              Text(widget.check.description),
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

  CircleAvatar _statusIcon(Status status) {
    final brightness = Theme.of(context).brightness;

    final outerColor = {
      Brightness.light: {
        Status.verified: Color(0xff95ff7d),
        Status.questionable: Color(0xffffdb80),
        Status.falseInfo: Color(0xfffcddda),
      },
      Brightness.dark: {
        Status.verified: Color(0xff3d7131),
        Status.questionable: Color(0xff743700),
        Status.falseInfo: Color(0xff8b1f12),
      }
    }[brightness]![status];

    final innerColor = {
      Brightness.light: {
        Status.verified: Color(0xff3d7131),
        Status.questionable: Color(0xffb46000),
        Status.falseInfo: Color(0xffe43731),
      },
      Brightness.dark: {
        Status.verified: Color(0xff7ce265),
        Status.questionable: Color(0xfffdba0b),
        Status.falseInfo: Color(0xffec9291),
      }
    }[brightness]![status];

    return CircleAvatar(
        radius: 20,
        backgroundColor: outerColor,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: innerColor,
          child: status == Status.verified
              ? Icon(
                  Icons.check,
                  fontWeight: FontWeight.w900,
                  size: 11,
                  color: outerColor,
                )
              : Text(
                  "!",
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 11,
                    color: outerColor,
                  ),
                ),
        ));
  }
}
