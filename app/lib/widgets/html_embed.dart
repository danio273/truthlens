import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:ui_web' as ui;

import 'package:universal_html/html.dart' as html;

class HtmlEmbed extends StatefulWidget {
  final String html;
  final double width;
  final double height;
  final bool autoHeight;

  const HtmlEmbed({
    super.key,
    required this.html,
    required this.width,
    this.height = 80,
    this.autoHeight = false,
  });

  @override
  HtmlEmbedState createState() => HtmlEmbedState();
}

class HtmlEmbedState extends State<HtmlEmbed> {
  late String viewId;
  late double _height;
  html.IFrameElement? _iframe;

  @override
  void initState() {
    super.initState();

    _height = widget.height;

    viewId = "iframe_${UniqueKey()}";

    if (widget.autoHeight) {
      html.window.onMessage.listen((event) {
        if (event.data is String) {
          try {
            final data = jsonDecode(event.data);

            if (data["iframeId"] == viewId) {
              final newHeight = (data["height"] as num).toDouble() + 20;

              if (mounted && newHeight != _height) {
                setState(() => _height = newHeight);
              }

              if (_iframe != null) {
                _iframe!.style.height = "${newHeight}px";
              }
            }
          } catch (_) {}
        }
      });
    }

    ui.platformViewRegistry.registerViewFactory(
      viewId,
      (int _) {
        _iframe = html.IFrameElement()
          ..style.border = 'none'
          ..style.width = '100%'
          ..style.height = '${_height}px'
          ..srcdoc =
              widget.autoHeight ? _wrapHtmlWithAuto(widget.html) : widget.html;

        return _iframe!;
      },
    );
  }

  String _wrapHtmlWithAuto(String innerHtml) {
    return """
<!DOCTYPE html>
<html>
<head>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <style>
    body { margin: 0; }
  </style>
</head>
<body>
  $innerHtml

  <script>
    const iframeId = "$viewId";
    function sendHeight() {
      const h = document.body.scrollHeight;
      parent.postMessage(JSON.stringify({ iframeId: iframeId, height: h }), "*");
    }

    new ResizeObserver(sendHeight).observe(document.body);
    window.onload = sendHeight;
    setInterval(sendHeight, 200);
  </script>

</body>
</html>
""";
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: _height,
      child: HtmlElementView(viewType: viewId),
    );
  }
}

class TwitterEmbed extends StatelessWidget {
  final String url;

  const TwitterEmbed({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return HtmlEmbed(
      key: ValueKey(url),
      html: """
<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  </head>
  <body>
    <blockquote class="twitter-tweet">
      <p lang="pl" dir="ltr">Ukraińcy w Polsce chcą mieć coraz większy wpływ...</p>
      — Sławomir Mentzen 
      <a href="$url">Tweet</a>
    </blockquote>
    <script async src="https://platform.twitter.com/widgets.js"></script>
  </body>
</html>
""",
      autoHeight: true,
      width: 500,
    );
  }
}
