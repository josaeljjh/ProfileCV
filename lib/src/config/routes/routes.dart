import 'dart:io';

import 'package:flutter/material.dart';
import '../../ui/pages/dashboard/dashboard_screen.dart';

class Routes {
  static const home = '/';

  Route routes(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _createRoute(
          settings,
              (context) => DashBoardScreen.create(context),
        );
      default:
        _createRoute(
          settings,
              (context) => const DashBoardScreen(),
        );
    }
    throw Exception('This route does not exist');
  }

  Route _createRoute(
      RouteSettings? settings,
      Widget Function(BuildContext context) predicated,
      ) {
    if (Platform.isIOS) {
      return MaterialPageRoute(
          builder: (context) => predicated(context), settings: settings);
    }
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (context, animation, secondaryAnimation) =>
          predicated(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        final tween = Tween(begin: begin, end: end);
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
