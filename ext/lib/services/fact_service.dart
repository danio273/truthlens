import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>?> factCheck(String fact) async {
  final url = Uri.parse('https://api.truthlens.pl/');

  final body = {
    "query": fact,
  };

  final response = await http.post(
    url,
    headers: {"Content-Type": "application/json"},
    body: jsonEncode(body),
  );

  if (response.statusCode != 200) {
    return null;
  }

  return jsonDecode(response.body);
}
