import 'package:flutter/material.dart';
import 'package:app/views/Initial.dart';
import 'views/Explanation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appName = 'Nutri Potes';

    return MaterialApp(
      title: appName,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'),
        const Locale('pt', 'BR'),
      ],

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
      home: Explanation(),
    );
  }
}
