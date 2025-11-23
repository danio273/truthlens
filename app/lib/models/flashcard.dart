import 'package:app/models/check.dart';

class Flashcard {
  final String url;
  final List<Check> answer;

  Flashcard({
    required this.url,
    required this.answer,
  });
}
