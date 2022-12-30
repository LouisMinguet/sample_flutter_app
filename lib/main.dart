import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'MyApp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('fr'), Locale('es')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'), // Default language
        child: MyApp(savedThemeMode: savedThemeMode)),
  );
}

// Packages to add :
  // - Languages :      https://pub.dev/packages/easy_localization
    // > To add more languages, create a file in assets/translations AND add it into ios/Runner/Info.plist, in CFBundleLocalizations
// - Themes schemes : https://pub.dev/packages/adaptive_theme
// - Responsive :     https://pub.dev/packages/flutter_sizer
