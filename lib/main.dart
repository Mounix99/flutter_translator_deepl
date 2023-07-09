import 'package:deepl_dart/deepl_dart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TranslatorScreen(),
    );
  }
}

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  Translator translator = Translator(authKey: '5a5b2ffd-41c9-20bb-68ee-9352d67ae1f6:fx');
  late TextEditingController _controller;
  late String _translation;
  late Language _selectedLanguage;

  final SizedBox _sizedBox8 = const SizedBox(height: 8);

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _selectedLanguage = Language.en;
    _translation = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Translator'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: _controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter text to translate',
                ),
              ),
              _sizedBox8,
              DropdownButton<Language>(
                value: _selectedLanguage,
                onChanged: (Language? value) {
                  if (value != null) setState(() => _selectedLanguage = value);
                },
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                items: Language.values.map<DropdownMenuItem<Language>>((Language value) {
                  return DropdownMenuItem<Language>(
                    value: value,
                    child: Row(
                      children: [
                        Text(value.language),
                      ],
                    ),
                  );
                }).toList(),
              ),
              _sizedBox8,
              _sizedBox8,
              const Text("Translation:", style: TextStyle(fontSize: 20)),
              _sizedBox8,
              Text(_translation, style: const TextStyle(fontSize: 18)),
              Expanded(child: _sizedBox8),
              ElevatedButton(
                onPressed: () async {
                  if (_controller.text.isEmpty) return;
                  final apiTranslation = await translator.translateTextSingular(
                      _controller.text, _selectedLanguage.locale ?? _selectedLanguage.name);
                  setState(() {
                    _translation = "${apiTranslation.text} - ${_selectedLanguage.language}";
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text('Translate'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum Language {
  bg(language: "Bulgarian"),
  da(language: "Danish"),
  de(language: "German"),
  el(language: "Greek"),
  en(language: "English", locale: "en_US"),
  es(language: "Spanish"),
  et(language: "Estonian"),
  fi(language: "Finnish"),
  fr(language: "French"),
  hu(language: "Hungarian"),
  id(language: "Indonesian"),
  it(language: "Italian"),
  ja(language: "Japanese"),
  ko(language: "Korean"),
  lt(language: "Lithuanian"),
  lv(language: "Latvian"),
  nb(language: "Norwegian Bokmal"),
  nl(language: "Dutch"),
  pl(language: "Polish"),
  pt(language: "Portuguese", locale: "pt-PT"),
  ro(language: "Romanian"),
  sk(language: "Slovak"),
  sl(language: "Slovenian"),
  sv(language: "Swedish"),
  tr(language: "Turkish"),
  uk(language: "Ukrainian"),
  zh(language: "Chinese");

  const Language({
    required this.language,
    this.locale,
  });

  final String language;

  /// Some languages have different locales, e.g. Portuguese (Portugal) and Portuguese (Brazil).
  final String? locale;
}
