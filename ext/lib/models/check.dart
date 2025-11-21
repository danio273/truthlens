const Map<String, String> checkTitles = {
  'source_reliability': 'Wiarygodność źródła',
  'logic_quality': 'Jakość logiki',
  'emotional_pressure': 'Presja emocjonalna',
  'manipulative_structure': 'Struktura manipulacyjna',
};

enum CheckStatus {
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
        return CheckStatus.falseInfo;
    }
  }
}

class Check {
  final String title;
  final String shortDescription;
  final CheckStatus status;
  final String description;

  Check({
    this.title = "",
    this.shortDescription = "",
    this.status = CheckStatus.verified,
    this.description = "",
  });

  static List<Check> listFromJson(Map<String, dynamic> json) {
    return json.entries.map((e) {
      final data = e.value as Map<String, dynamic>;

      return Check(
        title: checkTitles[e.key]!,
        shortDescription: data['short'],
        status: CheckStatus.fromJson(data['status']),
        description: data['long'],
      );
    }).toList();
  }
}
