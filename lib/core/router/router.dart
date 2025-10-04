import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_shorts_movies/core/router/router_name.dart';
import 'package:in_shorts_movies/feature/movies/presentation/screens/bookmark_screen.dart';
import 'package:in_shorts_movies/feature/movies/presentation/screens/movie_detail_screen.dart';
import '../../feature/landing/presentation/screen/landing.dart';
import '../../feature/movies/presentation/screens/movies_list_screen.dart';
import '../../feature/profile/presentation/screens/profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

// https://sameer8287.github.io/movieDetails?id=803796

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteName.moviesList,
    routes: [
      // GoRoute(
      //   path: RouteName.onBoarding,
      //   name: RouteName.onBoarding,
      //   builder: (context, state) {
      //     return OnboardingScreen();
      //   },
      // ),
      GoRoute(
        path: RouteName.movieDetails,
        name: RouteName.movieDetails,
        builder: (context, state) {
          final id = int.tryParse(state.uri.queryParameters['id'] ?? '0') ?? 0;
          return MovieDetailScreen(id: id);
        },
      ),

      mainShellRoute,
    ],
  );

  static get mainShellRoute {
    return ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return Landing(child: child);
      },
      routes: [
        GoRoute(
          path: RouteName.moviesList,
          name: RouteName.moviesList,
          pageBuilder: (mainContext, state) {
            return MaterialPage(child: MovieListScreen());
          },
        ),

        GoRoute(
          path: RouteName.bookMark,
          name: RouteName.bookMark,
          pageBuilder: (mainContext, state) {
            return const MaterialPage(child: BookmarkScreen());
          },
        ),
        GoRoute(
          path: RouteName.profile,
          name: RouteName.profile,
          pageBuilder: (mainContext, state) {
            return const MaterialPage(child: ProfileScreen());
          },
        ),
      ],
    );
  }
}
