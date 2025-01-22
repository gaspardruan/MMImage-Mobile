import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../image_store.dart';
import 'collection_page.dart';
import 'latest_page.dart';
import 'album_page.dart';
import 'more_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var imageStore = context.watch<ImageStore>();

    // if loaded is false, show loading, else show IndexedStack
    if (!imageStore.loaded) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    var images = imageStore.latest;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          LatestPage(images: images),
          AlbumPage(),
          CollectionPage(),
          MorePage(),
        ],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(
              height: 0.8,
              fontSize: 8,
            ),
          ),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          height: 70,
          destinations: [
            NavigationDestination(
              icon: Icon(CupertinoIcons.square_grid_2x2_fill),
              label: '最新',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.collections_solid),
              label: '合集',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.heart_fill),
              label: '收藏',
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.ellipsis_circle_fill),
              label: '更多',
            ),
          ],
          onDestinationSelected: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
