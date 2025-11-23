import 'package:universal_html/html.dart' as html;

void downloadFromUrl(String url) {
  final anchor = html.AnchorElement(href: url)
    ..target = '_blank';
  anchor.click();
}