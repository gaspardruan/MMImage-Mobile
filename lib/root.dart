import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'store.dart';
import 'pages/collection_page.dart';
import 'pages/latest_page.dart';
import 'pages/album_page.dart';
import 'pages/more_page.dart';
import 'utils.dart';

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
                child: InternetIndicator(),
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

  Widget _bottomNavigationBar() {
    return NavigationBarTheme(
      data: NavigationBarThemeData(
          labelTextStyle: WidgetStatePropertyAll(
        TextStyle(fontSize: 11, height: 0.5),
      )),
      child: NavigationBar(
        selectedIndex: _selectedIndex,
        height: 60,
        destinations: [
          NavigationDestination(
            icon: Icon(CupertinoIcons.square_grid_2x2_fill, size: 28),
            label: AppLocalizations.of(context)!.latest,
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.collections_solid, size: 28),
            label: AppLocalizations.of(context)!.album,
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.heart_fill, size: 28),
            label: AppLocalizations.of(context)!.collection,
          ),
          NavigationDestination(
            icon: Icon(CupertinoIcons.ellipsis_circle_fill, size: 28),
            label: AppLocalizations.of(context)!.more,
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

class InternetIndicator extends StatefulWidget {
  const InternetIndicator({super.key});

  @override
  State<InternetIndicator> createState() => _InternetIndicatorState();
}

class _InternetIndicatorState extends State<InternetIndicator> {
  final ValueNotifier<bool> _canAccessInternet = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    canAccessInternet().then((res) => _canAccessInternet.value = res);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _canAccessInternet,
      builder: (context, canAccessInternet, child) {
        return canAccessInternet
            ? CupertinoActivityIndicator(
                animating: true,
                radius: 25,
                color: Colors.white,
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.noInternet,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 3),
                  SizedBox(
                    width: 290,
                    child: Text(
                      AppLocalizations.of(context)!.noInternetHelp,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
      },
    );
  }
}
