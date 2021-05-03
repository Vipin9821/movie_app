import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/screens/splash_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
        break;
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
        break;
      case MovieDetailsPage.routeName:
        return MaterialPageRoute(
          builder: (context) => MovieDetailsPage(),
        );
        break;
      default:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );
    }
  }
}
