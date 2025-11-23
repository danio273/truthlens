import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../models/check.dart' show Check;
import '../widgets/checks_widget.dart';
import '../services/api_service.dart';

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
    final wideScreen = MediaQuery.of(context).size.width > 830;

    return Center(
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
                  SizedBox(
                      width: 500, child: _buildTextInput(wideScreen, theme)),
                  SizedBox(width: 550, child: _buildResultsArea(wideScreen)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column _buildTextInput(bool wideScreen, ThemeData theme) {
    final mainAxisAlignment =
        !wideScreen ? MainAxisAlignment.spaceBetween : MainAxisAlignment.start;

    return Column(
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
    );
  }

  Padding _buildResultsArea(bool wideScreen) {
    final padding = wideScreen
        ? EdgeInsets.only(left: 15)
        : const EdgeInsets.only(top: 20.0);

    return Padding(
      padding: padding,
      child: Skeletonizer(
        enabled: status == Status.loading,
        child: ChecksWidget(checks: checks),
      ),
    );
  }
}
