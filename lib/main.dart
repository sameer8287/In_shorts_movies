import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:in_shorts_movies/data/local/db_helper.dart';
import 'package:in_shorts_movies/feature/landing/presentation/provider/internet_connectivity_provider.dart';
import 'package:in_shorts_movies/feature/movies/presentation/provider/movie_list_provider.dart';
import 'package:in_shorts_movies/feature/movies/domain/usecase/movie_usecase.dart';
import 'package:in_shorts_movies/feature/movies/data/repository/movie_repository_impl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

import 'core/l10n/generated/l10n.dart';
import 'core/provider/core_provider.dart';
import 'core/router/router.dart';
import 'core/theme/app_theme.dart';
import 'feature/landing/presentation/provider/landing_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbHelper.instance.initDatabase();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CoreProvider()),
        ChangeNotifierProvider(create: (_) => InternetConnectivityProvider()),
        ChangeNotifierProvider(create: (_) => LandingProvider()),
        ChangeNotifierProvider(
          create: (_) => MoviesListProvider(
            movieUseCase: MovieUseCase(
              movieRepository: MovieRepositoryImpl(),
            ),
          ),
        ),
      ],
      child: GlobalLoaderOverlay(
        overlayWidgetBuilder: (progress) {
          return Center(
            child: CircularProgressIndicator(
              color: AppTheme.primaryBlue, // Set your desired color here
            ),
          );
        },
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<CoreProvider>(
      builder: (context, value, child) {
        return MaterialApp.router(
          title: 'In Shorts Movies',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.light,
          supportedLocales: S.delegate.supportedLocales,
          locale: value.locale,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
