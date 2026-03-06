import 'source.dart';

const Map<String, String> checkTitles = {
  'source_reliability': 'Wiarygodność źródła',
  'logic_quality': 'Jakość logiki',
  'emotional_pressure': 'Presja emocjonalna',
  'manipulative_structure': 'Struktura manipulacyjna',
};

enum CheckStatus {
  empty,
  verified,
  questionable,
  falseInfo;

  static CheckStatus fromJson(String value) {
    switch (value) {
      case 'verified':
        return CheckStatus.verified;
      case 'questionable':
        return CheckStatus.questionable;
      case 'false_info':
        return CheckStatus.falseInfo;
      default:
        return CheckStatus.empty;
    }
  }
}

class Check {
  final String title;
  final String shortDescription;
  final CheckStatus status;
  final String? description;
  final List<Source>? sources;

  const Check({
    required this.title,
    required this.shortDescription,
    this.status = CheckStatus.empty,
    this.description,
    this.sources,
  });

  static List<Check> listFromJson(Map<String, dynamic> json) {
    return json.entries.map((e) {
      final data = e.value as Map<String, dynamic>;

      return Check(
        title: checkTitles[e.key]!,
        shortDescription: data['short'],
        status: CheckStatus.fromJson(data['status']),
        description: data['long'],
        sources: data["sources"] != null
            ? Source.listFromJson(data["sources"])
            : null,
      );
    }).toList();
  }
}
