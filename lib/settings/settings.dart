import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {

  String selectedLanguage = 'English'; // Default language is English
  List<String> languagesList = ['English', 'Français', 'Español'];
  List<String> languagesTagList = ['en', 'fr', 'es'];

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();

    // String languageCode = context.locale.toLanguageTag();
    // print(languageCode);
    _isDarkMode = (AdaptiveTheme.of(context).brightness == Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text("settings.title", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),).tr(),
            languageRow(),
            themeRow(),
          ],
        ),
      ),
    );
  }

  Row languageRow() {
    return Row(
      children: [
        settingsIcon(Icons.language_rounded),
        settingsText("settings.languages").tr(),
        const Spacer(),
        DropdownButton(
          value: selectedLanguage,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: languagesList.map((items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedLanguage = newValue ?? "English";
              if (selectedLanguage == "English") {
                context.setLocale(const Locale('en'));
              } else if (selectedLanguage == "Français") {
                context.setLocale(const Locale('fr'));
              } else if (selectedLanguage == "Español") {
                context.setLocale(const Locale('es'));
              }
            });
          },
        ),
      ],
    );
  }

  Row themeRow() {
    return Row(
      children: [
        settingsIcon(Icons.dark_mode_outlined),
        settingsText("settings.darkmode").tr(),
        const Spacer(),
        Switch(
          value: _isDarkMode,
          onChanged: (b) {
            setState(() {
              _isDarkMode = b;

              if(_isDarkMode == true) {
                print("Switch to dark");
                AdaptiveTheme.of(context).setDark();
              } else {
                print("Switch to light");
                AdaptiveTheme.of(context).setLight();
              }
            });
          },
        ),
      ],
    );
  }

  Text settingsText(String text) {
    return Text(
      text,
      style: const TextStyle(
        // color: Color.fromARGB(255, 70, 70, 70),
        fontWeight: FontWeight.w500
      ),
    );
  }

  Padding settingsIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Icon(
        icon,
        color: const Color.fromARGB(255, 125, 125, 125),
      ),
    );
  }
}