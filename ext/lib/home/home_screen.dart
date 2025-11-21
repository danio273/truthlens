import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../services/chrome_interop.dart';
import '../services/fact_service.dart';
import '../models/check.dart';
import 'check_tile.dart';
import '../utils/snackbar.dart';

enum LoadingStatus { empty, loading, success, error }

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Check> checks = List.generate(
    4,
    (_) => Check(
      title: "Wiarygodność źródła",
      shortDescription: "There are many variations of passages",
    ),
  ); // empty list for skeleton

  LoadingStatus status = LoadingStatus.empty;

  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSelectedText();
  }

  @override
  void dispose() {
    super.dispose();
    textEditingController.dispose();
  }

  Future<void> loadSelectedText() async {
    final text = await getSelectedText();

    final newStatus =
        text.isNotEmpty ? LoadingStatus.loading : LoadingStatus.empty;

    setState(() {
      textEditingController.text = text;
      status = newStatus;
    });

    if (text.isNotEmpty) {
      await loadChecks(text);
    } else {
      setState(() {
        status = LoadingStatus.empty;
      });
    }
  }

  Future<void> loadChecks(String text) async {
    setState(() {
      status = LoadingStatus.loading;
    });

    final result = await factCheck(text);

    if (result == null) {
      Snackbar.show("Serwer chwilowo nie odpowiada. Spróbuj za moment!");
      status = LoadingStatus.error;
      return;
    }

    if (!result["processable"]) {
      Snackbar.show(result["reason"]);
      status = LoadingStatus.error;
      return;
    }

    setState(() {
      textEditingController.text = result["summary"];
      checks = Check.listFromJson(result["factors"]);
      status = LoadingStatus.success;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            buildTextfield(),
            if (status == LoadingStatus.success ||
                status == LoadingStatus.loading) ...[
              const SizedBox(height: 10),
              Skeletonizer(
                enabled: status == LoadingStatus.loading,
                child: Column(children: buildChecks()),
              ),
            ],
          ],
        ),
      ),
    );
  }

  TextField buildTextfield() {
    return TextField(
      controller: textEditingController,
      onChanged: (_) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: "Wpisz coś, aby to sprawdzić",
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
        suffixIcon: status == LoadingStatus.loading
            ? Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 14.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 3),
                ),
              )
            : IconButton(
                onPressed: textEditingController.text.isEmpty
                    ? null
                    : () => loadChecks(textEditingController.text),
                icon: Icon(Icons.send),
              ),
      ),
    );
  }

  List<CheckTile> buildChecks() {
    return checks.asMap().entries.map((entry) {
      final index = entry.key;
      final check = entry.value;

      return CheckTile(
        check: check,
        isFirst: index == 0,
        isLast: index == checks.length - 1,
      );
    }).toList();
  }
}
