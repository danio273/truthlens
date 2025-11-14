import 'package:flutter/material.dart';

import '../utils/chrome_interop.dart';
import '../data/repository.dart';
import '../widgets/check_tile.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? selectedText;
  List<Check>? checks;

  @override
  void initState() {
    super.initState();
    loadSelectedText();
  }

  Future<void> loadSelectedText() async {
    final text = await getSelectedText();
    setState(() {
      selectedText = text;
    });

    if (text.isNotEmpty) {
      await loadChecks(text);
    }
  }

  Future<void> loadChecks(String text) async {
    final result = await factCheck(text);
    setState(() {
      checks = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: selectedText == null
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    buildTextfield(),
                    if (checks != null) ...[
                      const SizedBox(height: 10),
                      ...buildChecks(),
                    ],
                  ],
                ),
              ));
  }

  TextField buildTextfield() {
    return TextField(
      controller: TextEditingController(text: selectedText),
      decoration: InputDecoration(
        hintText: "Type something to check if it's true",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        suffixIcon: selectedText!.isNotEmpty && checks == null
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 14.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              )
            : null, // TODO: send button
      ),
    );
  }

  List<CheckTile> buildChecks() {
    return checks!.asMap().entries.map((entry) {
      final index = entry.key;
      final check = entry.value;

      return CheckTile(
        check: check,
        isFirst: index == 0,
        isLast: index == checks!.length - 1,
      );
    }).toList();
  }
}
