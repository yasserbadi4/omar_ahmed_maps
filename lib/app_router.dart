import 'package:flutter/material.dart';
import 'package:omar_ahmed_maps/constants/strings.dart';
import 'package:omar_ahmed_maps/presentation/screens/login_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
    }
  }
}
