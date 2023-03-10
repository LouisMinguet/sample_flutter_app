import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => SettingsPageState();
}

class SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'English';
  Map<String, String> languagesList = {
    "English": "en",
    "Français": "fr",
    "Español": "es"
  };

  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();

    _isDarkMode = (AdaptiveTheme.of(context).brightness == Brightness.dark);
  }

  @override
  Widget build(BuildContext context) {
    languagesList.forEach((key, value) {
      if (value == context.locale.toLanguageTag()) {
        selectedLanguage = key;
      }
    });

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
        padding: EdgeInsets.all(16.0.dp),
        child: Column(
          children: [
            Text(
              "settings.title",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0.dp),
            ).tr(),
            languageRow(),
            themeRow(),
          ],
        ),
      ),
    );
  }

  Row languageRow() {
    List<String> languagesNameList = [];
    languagesList.forEach((key, value) {
      languagesNameList.add(key);
    });

    return Row(
      children: [
        settingsIcon(Icons.language_rounded),
        settingsText("settings.languages").tr(),
        const Spacer(),
        DropdownButton(
          value: selectedLanguage,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: languagesNameList.map((items) {
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

              if (_isDarkMode == true) {
                AdaptiveTheme.of(context).setDark();
              } else {
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
          fontWeight: FontWeight.w500),
    );
  }

  Padding settingsIcon(IconData icon) {
    return Padding(
      padding: EdgeInsets.only(right: 8.0.dp),
      child: Icon(
        icon,
        color: const Color.fromARGB(255, 125, 125, 125),
      ),
    );
  }
}
