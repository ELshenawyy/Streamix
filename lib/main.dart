import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/app_strings.dart';

import 'core/services/service_locator.dart';
import 'movies/presentation/screens/movies_screen.dart';

void main() {
  ServiceLocator().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: Colors.grey.shade900),
      home: const MoviesScreen(),
    );
  }
}
