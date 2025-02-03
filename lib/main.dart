// ignore: dangling_library_doc_comments
/// file: main.dart
/// author: gaspardruan
/// time: 2025/1/31
/// email: 1039553124@qq.com

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'store.dart';
import 'route.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => GlobalStore(),
    lazy: false,
    child: const MyApp(),
  ));

  // 仅允许竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  PaintingBinding.instance.imageCache.maximumSize = 400;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 * 1024 * 1024;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode =
        context.select<GlobalStore, ThemeMode>((store) => store.themeMode);
    return MaterialApp(
      title: 'MMImage',
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: CustomRoute.generateRoute,
      initialRoute: CustomRoute.rootPage,
    );
  }
}
