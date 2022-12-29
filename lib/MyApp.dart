import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedLanguage = 'English'; // Default language is English
  List<String> languagesList = ['English', 'Français', 'Español'];
  List<String> languagesTagList = ['en', 'fr', 'es'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appbar_title").tr(),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0, left: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("selected_language")
                  .tr(args: [selectedLanguage], namedArgs: {'param': 'Yeah!'}),
              const Divider(),
              const Text("Settings :"),
              Row(
                children: [
                  const Text("settings.languages").tr(),
                  const Spacer(),
                  DropdownButton(
                    value: selectedLanguage,
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: languagesList.map((items) {
                      return DropdownMenuItem(value: items, child: Text(items));
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        print(newValue);
                        selectedLanguage = newValue ?? "English";
                        if(selectedLanguage == "English") {
                          context.setLocale(const Locale('en'));
                        } else if(selectedLanguage == "Français") {
                          context.setLocale(const Locale('fr'));
                        } else if(selectedLanguage == "Español") {
                          context.setLocale(const Locale('es'));
                        }
                      });
                    },
                  ),
                ],
              ),
              const Text("settings.theme").tr(),
            ],
          ),
        ),
      ),
    );
  }
}
