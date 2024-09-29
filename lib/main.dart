import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'Splash/presentation/views/splash_view.dart';
import 'core/global/theme/manager/theme_notifier.dart';
import 'core/services/service_locator.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/global/theme/theme_data/theme_data_dark.dart';
import 'curved_navigation_bar/presentaion/manager/navigation_provider.dart';
import 'favourits/presentation/controller/favoutite_screen_provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();

  ServiceLocator().init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NavigationProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => FavoriteMovieProvider(),
        )
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        ScreenUtil.init(context);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppStrings.appName,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeNotifier.themeMode,
          home: const SplashView(),
        );
      },
    );
  }
}
