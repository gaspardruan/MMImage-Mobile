import 'package:flutter/material.dart';
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

  PaintingBinding.instance.imageCache.maximumSize = 400;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 200 * 1024 * 1024;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MMImage',
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
