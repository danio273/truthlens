import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/check.dart';
import '../models/source.dart';

import '../utils/open_url.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        if (!_expanded)
                          RichText(
                            text: TextSpan(
                              style: DefaultTextStyle.of(context).style,
                              children: [
                                TextSpan(text: widget.check.shortDescription),
                                if (widget.check.sources != null) ...[
                                  const TextSpan(text: "  "),
                                  WidgetSpan(
                                    alignment: PlaceholderAlignment.middle,
                                    child: Icon(
                                      Icons.link,
                                      size: 14,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                  TextSpan(
                                    text:
                                        " ${widget.check.sources!.length} źródła",
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
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
              if (widget.check.sources != null) ...[
                Divider(),
                _sources(widget.check.sources!),
              ],
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
    final brightness = Theme.of(context).brightness;

    final outerColor = {
      Brightness.light: {
        CheckStatus.verified: Color(0xff95ff7d),
        CheckStatus.questionable: Color(0xffffdb80),
        CheckStatus.falseInfo: Color(0xfffcddda),
      },
      Brightness.dark: {
        CheckStatus.verified: Color(0xff3d7131),
        CheckStatus.questionable: Color(0xff743700),
        CheckStatus.falseInfo: Color(0xff8b1f12),
      }
    }[brightness]![status];

    final innerColor = {
      Brightness.light: {
        CheckStatus.verified: Color(0xff3d7131),
        CheckStatus.questionable: Color(0xffb46000),
        CheckStatus.falseInfo: Color(0xffe43731),
      },
      Brightness.dark: {
        CheckStatus.verified: Color(0xff7ce265),
        CheckStatus.questionable: Color(0xfffdba0b),
        CheckStatus.falseInfo: Color(0xffec9291),
      }
    }[brightness]![status];

    return Skeleton.replace(
      replacement: CircleAvatar(radius: 20),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: outerColor,
        child: CircleAvatar(
          radius: 10,
          backgroundColor: innerColor,
          child: Icon(
            status == CheckStatus.verified ? Icons.check : Icons.priority_high,
            fontWeight: FontWeight.w900,
            size: 11,
            color: outerColor,
          ),
        ),
      ),
    );
  }

  Wrap _sources(List<Source> sources) {
    return Wrap(
      spacing: 5,
      runSpacing: 5,
      children: [
        for (final source in sources)
          Tooltip(
            message: "${_textLimit(source.snippet, 50)} ${source.displayLink}",
            child: OutlinedButton.icon(
              icon: Icon(Icons.link),
              label: Text(_textLimit(source.title, 15)),
              onPressed: () => openUrl(source.link),
            ),
          ),
      ],
    );
  }

  static String _textLimit(String text, int max) {
    return text.length <= max ? text : "${text.substring(0, max)}...";
  }
}
