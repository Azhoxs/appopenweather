import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OpenWeatherApp extends StatelessWidget {
  const OpenWeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "OpenWeatherApp",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
          )
      ),
    );
  }
}
