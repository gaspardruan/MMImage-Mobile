import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mmimage_mobile/route.dart';
import 'package:provider/provider.dart';

import 'image_store.dart';

void main() {
  // 设置手机状态栏为白色
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // 设置状态栏背景颜色为透明
    statusBarIconBrightness: Brightness.light, // 设置状态栏图标为亮色
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ImageStore()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
