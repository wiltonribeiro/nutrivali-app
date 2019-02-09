import 'package:flutter/material.dart';
import 'package:app/views/SplashScreen.dart';
import 'package:app/config/MyLocalizationsDelegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Nutrivali';

    return MaterialApp(
      title: appName,
      localizationsDelegates: [
        const MyLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode || supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },

      theme: ThemeData(

        brightness: Brightness.dark,
        primaryColor: const Color(0xFFfafafa),
        primaryColorDark: const Color(0xFF4f4f4f),
        accentColor: const Color(0xFFff7b73),
        backgroundColor: const Color(0xFF807d82),
        canvasColor: const Color(0xFFfafafa),

        fontFamily: 'Ubuntu',

        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
