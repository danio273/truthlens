class Source {
  final String title;
  final String snippet;
  final String displayLink;
  final String link;

  Source({
    required this.title,
    required this.snippet,
    required this.displayLink,
    required this.link,
  });

  static List<Source> listFromJson(List<dynamic> json) {
    return json.map((e) {
      final data = e as Map<String, dynamic>;

      return Source(
        title: data['title'],
        snippet: data['snippet'],
        displayLink: data['displayLink'],
        link: data['link'],
      );
    }).toList();
  }
}
