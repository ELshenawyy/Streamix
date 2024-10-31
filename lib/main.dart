import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_app/search/presentation/controller/history_bloc.dart';
import 'package:movie_app/search/presentation/controller/history_events.dart';
import 'package:movie_app/settings/presentation/controllers/manager/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/utils/app_strings.dart';
import 'Splash/presentation/views/splash_view.dart';
import 'core/services/service_locator.dart';
import 'core/global/theme/theme_data/theme_data_light.dart';
import 'core/global/theme/theme_data/theme_data_dark.dart';
import 'curved_navigation_bar/presentaion/manager/navigation_provider.dart';
import 'curved_navigation_bar/presentaion/screens/navigation_curved_bar.dart';
import 'favourits/presentation/controller/favoutite_screen_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await ScreenUtil.ensureScreenSize(); // Initialize ScreenUtil

  ServiceLocator().init(); // Initialize the service locator

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteMovieProvider()),

      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<HistoryBloc>()..add(LoadHistory())),
          // Add other BlocProviders here if needed
        ],
      child: const MyApp(),
    ),
  ));
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
          home: SplashView(), // Your splash screen or main screen
        );
      },
    );
  }
}
