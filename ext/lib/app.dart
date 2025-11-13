import 'package:flutter/material.dart';
import 'utils/chrome_interop.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TruthLens',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TruthLens Checkup'),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String? selectedText;

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
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: selectedText == null
          ? const CircularProgressIndicator()
          : selectedText != ""
              ? Column(
                  children: [
                    Text(selectedText!),
                    checkTile(
                      title: "Source",
                      titles: [
                        "Source indicated?",
                        "Source credibility",
                        "Publication date",
                        "Direct link available",
                      ],
                      subtitles: [
                        "Is a source provided?",
                        "Is it scientific, journalistic, dubious, or anonymous?",
                        "Is the information up to date?",
                        "Can the original source be verified?",
                      ],
                    ),
                    checkTile(
                      title: "Facts & Arguments",
                      titles: [
                        "Supported by evidence",
                        "Context accuracy",
                        "Overgeneralizations",
                      ],
                      subtitles: [
                        "Are there data, studies, or quotes?",
                        "Is the information presented correctly?",
                        "Statements like 'everyone thinks...' or 'never happens...'",
                      ],
                    ),
                    checkTile(
                      title: "Manipulation",
                      titles: [
                        "Emotional triggers",
                        "Clickbait / sensationalism",
                        "Unverified authority claims",
                      ],
                      subtitles: [
                        "Fear, anger, or excessive enthusiasm.",
                        "Does the headline match the content?",
                        "Claims like 'The scientist says...' without reference.",
                      ],
                    ),
                    checkTile(
                      title: "Logic",
                      titles: [
                        "False cause-effect",
                        "Reasoning errors",
                      ],
                      subtitles: [
                        "Claims like 'Vaccine → disease' without evidence.",
                        "Contradictions or exaggerations in arguments.",
                      ],
                    ),
                    checkTile(
                      title: "Confidence Level",
                      titles: [
                        "Misinformation",
                        "Needs verification",
                        "Verified",
                      ],
                      subtitles: [
                        "Clearly false or misleading information.",
                        "Uncertain information requiring further checking.",
                        "Information confirmed by reliable sources.",
                      ],
                    ),
                  ],
                )
              : Text("No text selected"),
    );
  }

  ExpansionTile checkTile({
    required String title,
    required List<String> titles,
    required List<String> subtitles,
  }) {
    return ExpansionTile(
      title: Text(title),
      children: List.generate(
        titles.length,
        (index) => ListTile(
          title: Text(titles[index]),
          subtitle: Text(subtitles[index]),
        ),
      ),
    );
  }
}
