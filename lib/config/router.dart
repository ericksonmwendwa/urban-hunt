import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urban_hunt/models/auth_model.dart';
import 'package:urban_hunt/screens/app_screen.dart';
import 'package:urban_hunt/screens/error_404_screen.dart';
import 'package:urban_hunt/screens/login_screen.dart';
import 'package:urban_hunt/screens/register_screen.dart';
import 'package:urban_hunt/screens/splash_screen.dart';

bool isPublicRoute(String? route) {
  return route == '/login' || route == '/register' || route == '/splash';
}

Route<dynamic> generateRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (BuildContext context) {
      final bool isLoggedIn = context.read<AuthModel?>() != null;
      final bool isPublic = isPublicRoute(settings.name);

      if (!isPublic && !isLoggedIn) {
        return const LoginScreen();
      }

      switch (settings.name) {
        case '/':
          return const AppScreen();
        case '/splash':
          return const SplashScreen();
        case '/login':
          return const LoginScreen();
        case '/register':
          return const RegisterScreen();
        default:
          return const Error404Screen();
      }
    },
    settings: settings,
  );
}
