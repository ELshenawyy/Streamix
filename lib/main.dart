import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'core/services/service_locator.dart';
import 'core/global/theme/theme_data/theme_data_light.dart'; // Import the light theme
import 'core/global/theme/theme_data/theme_data_dark.dart';
import 'movies/presentation/screens/movies_screen.dart';  // Import the dark theme

void main() {
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.system; // Start with the system theme mode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: lightTheme,           // Light theme data
      darkTheme: darkTheme,        // Dark theme data
      themeMode: _themeMode,       // Control the theme mode
      home: MoviesScreen(onThemeChanged: _toggleTheme),
    );
  }
  void _toggleTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
