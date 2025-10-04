import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_shorts_movies/core/utils/helper_function.dart';
import 'package:provider/provider.dart';
import '../../../../core/router/router_name.dart';
import '../../../../core/theme/app_theme.dart';
import '../provider/landing_provider.dart';

class Landing extends StatelessWidget {
  final Widget child;

  const Landing({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: Consumer<LandingProvider>(
        builder: (context, provider, child) {
          return BottomNavigationBar(
            backgroundColor: AppTheme.bottomNavColor,
            currentIndex: provider.currentIndex,
            selectedItemColor: AppTheme.primaryColor,
            unselectedItemColor: context.theme.dividerColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              provider.setCurrentIndex(index);
              String route = RouteName.moviesList;
              if (index == 1) {
                route = RouteName.bookMark;
              }
              if (index == 2) {
                route = RouteName.profile;
              }
              context.goNamed(route);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home), //Image.asset(AssetConstant.homeIcn, height: 24, width: 24, color: context.theme.primaryColor),
                label: context.l10n.home,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bookmark_border),
                //Image.asset(AssetConstant.resourceIcn, height: 24, width: 24, color: context.theme.primaryColor),
                label: context.l10n.bookmark,
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person_outlined), label: context.l10n.profile),
            ],
          );
        },
      ),
    );
  }
}
