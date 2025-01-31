import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'stores/colletion_store.dart';
import 'stores/global_store.dart';
import 'route.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => GlobalStore(),
      lazy: false,
    ),
    ChangeNotifierProvider(
      create: (context) => CollectionStore(),
      lazy: false,
    ),
  ], child: const MyApp()));

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
            seedColor: Colors.pink, brightness: Brightness.light),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.pink, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      onGenerateRoute: CustomRoute.generateRoute,
      initialRoute: CustomRoute.mainPage,
    );
  }
}
