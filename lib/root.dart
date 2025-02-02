import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

import 'store.dart';
import 'pages/collection_page.dart';
import 'pages/latest_page.dart';
import 'pages/album_page.dart';
import 'pages/more_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> with WidgetsBindingObserver {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      context.read<GlobalStore>().save();
    }
  }

  @override
  Widget build(BuildContext context) {
    final loaded = context.select<GlobalStore, bool>((store) => store.loaded);

    if (!loaded) {
      return Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/beauty.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: SizedBox(
                  width: 60,
                  height: 60,
                  child: LoadingIndicator(
                    indicatorType: Indicator.ballSpinFadeLoader,
                    colors: [Colors.white],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final pages = <Widget>[
      const LatestPage(),
      const AlbumPage(),
      const CollectionPage(),
      const MorePage(),
    ];

    return Scaffold(
      // body: PageStorage(bucket: _bucket, child: pages[_selectedIndex]),
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
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
