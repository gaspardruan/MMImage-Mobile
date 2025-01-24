import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'image_store.dart';
import 'route.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ImageStore()),
  ], child: const MyApp()));
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
