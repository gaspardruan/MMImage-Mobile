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
  Widget? page;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final imageStore = context.read<ImageStore>();
    if (imageStore.loaded) {
      page = AlbumPage(
        names: imageStore.names,
        albums: imageStore.albums,
        tags: imageStore.tags,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var imageStore = context.watch<ImageStore>();

    if (!imageStore.loaded) {
      return const Scaffold(
        body: Center(
          child: Icon(
            CupertinoIcons.camera_fill,
            size: 100,
          ),
        ),
      );
    }

    final images = imageStore.latest;

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          LatestPage(images: images),
          page!,
          const CollectionPage(),
          const MorePage(),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  NavigationBarTheme _bottomNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
        labelTextStyle: WidgetStateProperty.all(
          const TextStyle(
            height: 0.8,
            fontSize: 8,
          ),
        ),
      ),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 70,
        destinations: [
          const NavigationDestination(
            icon: Icon(CupertinoIcons.square_grid_2x2_fill),
            label: '最新',
          ),
          const NavigationDestination(
            icon: Icon(CupertinoIcons.collections_solid),
            label: '合集',
          ),
          const NavigationDestination(
            icon: Icon(CupertinoIcons.heart_fill),
            label: '收藏',
          ),
          const NavigationDestination(
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
    );
  }
}
