import 'package:flutter/material.dart';

import 'models/image_suit.dart';
import 'pages/album_detail_page.dart';
import 'pages/main_page.dart';
import 'pages/view_page.dart';

class CustomRoute {
  static const String mainPage = '/';
  static const String viewPage = '/view';
  static const String albumDetailPage = '/album_detail';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mainPage:
        return MaterialPageRoute(builder: (_) => MainPage());
      case viewPage:
        return MaterialPageRoute(
            builder: (_) => ViewPage(
                  imageSuit: settings.arguments as ImageSuit,
                ));
      case albumDetailPage:
        final args =
            settings.arguments as ({String name, List<ImageSuit> images});
        return MaterialPageRoute(
            builder: (_) => AlbumDetailPage(
                  name: args.name,
                  images: args.images,
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
