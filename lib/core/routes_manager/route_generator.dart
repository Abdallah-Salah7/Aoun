import 'package:aoun/core/routes_manager/routes.dart';
import 'package:flutter/material.dart';

import '../../feature/presentation/screens/home_page.dart';



class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homePage:
      return MaterialPageRoute(builder: (_) => const HomePage());

      case Routes.signIn:
        // return MaterialPageRoute(builder: (_) => const SignInScreen());
      case Routes.onBoard:
        // return MaterialPageRoute(builder: (_) => const OnBoardScreen());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder:
          (_) => Scaffold(
            appBar: AppBar(title: const Text('No Route Found')),
            body: const Center(child: Text('No Route Found')),
          ),
    );
  }
}
