import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/check.dart' show Check;
import '../widgets/check_widget.dart';
import '../utils/fact_check.dart';

enum Status { empty, loading, success, error }

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final textEditingController = TextEditingController();

  List<Check>? checks;
  Status status = Status.empty;

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  void showError(String error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Problem z analizą"),
        content: Text(error),
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Zamknij"))
        ],
      ),
    );
  }

  void _checkText() async {
    final text = textEditingController.text;

    if (text.isEmpty) {
      return;
    }

    setState(() {
      status = Status.loading;
    });

    final result = await factCheck(text);

    if (result == null) {
      showError("Serwer chwilowo nie odpowiada. Spróbuj za moment!");
      setState(() => status = Status.error);
      return;
    }

    if (!result["processable"]) {
      showError(result["reason"]);
      setState(() => status = Status.error);
      return;
    }

    setState(() {
      checks = Check.listFromJson(result["factors"]);
      status = Status.success;
    });
  }

  void _clearText() {
    setState(() {
      checks = null;
      textEditingController.clear();
      status = Status.empty;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final wideScreen = screenWidth > 830;

    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sprawdź tekst", style: theme.textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Wklej dowolny tekst i zobacz, jak wiarygodny jest jego przekaz w czterech kategoriach.',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                alignment: WrapAlignment.start,
                children: [
                  _buildTextInput(wideScreen, screenWidth, theme),
                  _buildResultsArea(wideScreen, screenWidth),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding _buildResultsArea(bool wideScreen, double screenWidth) {
    final padding = wideScreen
        ? EdgeInsets.symmetric(horizontal: screenWidth * 0.02)
        : const EdgeInsets.symmetric(vertical: 10.0);

    return Padding(
      padding: padding,
      child: Skeletonizer(
        enabled: status == Status.loading,
        child: ChecksWidget(checks: checks),
      ),
    );
  }

  ConstrainedBox _buildTextInput(
      bool wideScreen, double screenWidth, ThemeData theme) {
    final maxWidth = wideScreen ? screenWidth * 0.45 : screenWidth;
    final mainAxisAlignment =
        !wideScreen ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxWidth,
      ),
      child: Column(
        children: [
          TextField(
            controller: textEditingController,
            onChanged: (_) {
              setState(() {});
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
            ),
            minLines: wideScreen ? 12 : 5,
            maxLines: wideScreen ? 30 : 12,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: mainAxisAlignment,
            children: [
              FilledButton.icon(
                icon: Icon(Icons.send),
                label: Text("Sprawdź"),
                onPressed: () => _checkText(),
              ),
              const SizedBox(width: 10),
              OutlinedButton.icon(
                icon: Icon(Icons.clear),
                label: Text("Wyczyść"),
                onPressed: () => _clearText(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
