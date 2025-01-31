import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final normalText =
        TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 48,
        leading: IconButton(
          iconSize: 20,
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        titleTextStyle: const TextStyle(fontSize: 16),
        title: Text(title, style: normalText),
        titleSpacing: 0,
      ),
      body: child,
    );
  }
}
