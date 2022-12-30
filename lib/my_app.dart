import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:sample_flutter_app/settings/settings.dart';

class MyApp extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MyApp({super.key, this.savedThemeMode});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
          brightness: Brightness.light,
          // Custom the themes here
          fontFamily: 'Poppins'),
      dark: ThemeData(
          brightness: Brightness.dark,
          // Custom the themes here
          fontFamily: 'Poppins'),
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        darkTheme: darkTheme,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        home: FlutterSizer(builder: (context, orientation, screenType) {
          return const MyHomePage();
        }),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appbar_title").tr(),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              });
            },
            icon: const Icon(Icons.settings_rounded),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(right: 16.0.dp, left: 16.0.dp),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("selected_language").tr(
                  args: [context.locale.toString()],
                  namedArgs: {'param': 'Yeah!'}),
            ],
          ),
        ),
      ),
    );
  }
}
