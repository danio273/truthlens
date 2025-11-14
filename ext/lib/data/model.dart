enum Status { verified, questionable, falseInfo }

class Check {
  final String title;
  final String shortDescription;
  final Status status;
  final String description;

  Check({
    required this.title,
    required this.shortDescription,
    required this.status,
    required this.description,
  });
}
