import 'dart:collection';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view_gallery.dart';

import '../utils.dart';

class ViewPage extends StatefulWidget {
  const ViewPage({super.key, required this.images});

  final List<String> images;

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  final HashSet<int> _cachedIndexes = HashSet<int>();
  int _pageIndex = 0;
  bool _isAppBarVisible = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _preloadImage(0, cacheStep);
  }

  void _preloadImage(int start, [int step = 1]) {
    if (start < 0 || start >= widget.images.length) {
      return;
    }
    final int end = min(widget.images.length, start + step);
    for (int i = start; i < end; i++) {
      if (!_cachedIndexes.contains(i)) {
        final String url = widget.images[i];
        precacheImage(CachedNetworkImageProvider(url), context);
        _cachedIndexes.add(i);
      }
    }
  }

  void _toggleAppBar() {
    setState(() {
      _isAppBarVisible = !_isAppBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          floatingActionButton: _pageNumLabel(context),
          floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          body: GestureDetector(
            onTap: _toggleAppBar,
            child: _photoPageView(),
          ),
        ),
        AnimatedPositioned(
          curve: Curves.easeInOut,
          duration: Duration(milliseconds: 200),
          top: _isAppBarVisible ? 0 : -100,
          left: 0,
          right: 0,
          child: _appBar(context),
        ),
      ],
    );
  }

  GestureDetector _appBar(BuildContext context) {
    return GestureDetector(
      onTap: _toggleAppBar,
      child: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 3,
        toolbarOpacity: 0.6,
        toolbarHeight: 48,
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
          size: 20,
        ),
        leading: IconButton(
          icon: const Icon(CupertinoIcons.back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.heart),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Padding _pageNumLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text("${_pageIndex + 1} / ${widget.images.length}",
          style: TextStyle(
              fontSize: 10, color: Theme.of(context).colorScheme.onSurface)),
    );
  }

  PhotoViewGallery _photoPageView() {
    return PhotoViewGallery.builder(
      allowImplicitScrolling: true,
      wantKeepAlive: true,
      itemCount: widget.images.length,
      builder: (context, index) => PhotoViewGalleryPageOptions(
        imageProvider: CachedNetworkImageProvider(widget.images[index]),
      ),
      pageController: PageController(
        initialPage: _pageIndex,
      ),
      onPageChanged: (index) {
        if (index > _pageIndex) {
          _preloadImage(index + cacheStep - 1);
        }
        setState(() {
          _pageIndex = index;
        });
      },
      scrollDirection: Axis.horizontal,
      backgroundDecoration:
          BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
    );
  }
}
