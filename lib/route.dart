import 'package:flutter/material.dart';

import 'pages/main_page.dart';
import 'pages/view_page.dart';

class CustomRoute {
  static const String mainPage = '/';
  static const String viewPage = '/view';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case viewPage:
        return MaterialPageRoute(
            builder: (_) => ViewPage(
                  images: settings.arguments as List<String>,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
