import 'dart:developer';

import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  const MorePage({super.key});

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    log("Morepage build");
    return Scaffold(
      body: Center(
        child: Text('More Page'),
      ),
    );
  }
}
