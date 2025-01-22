import 'package:flutter/material.dart';

class LatestPage extends StatefulWidget {
  const LatestPage({super.key, required this.images});

  final List<String> images;

  @override
  State<LatestPage> createState() => _LatestPageState();
}

class _LatestPageState extends State<LatestPage> {
  final int _pageSize = 24;
  int _maxPage = 0;
  int _page = 0;
  List<String> visibleImages = [];

  @override
  void initState() {
    super.initState();
    _maxPage = (widget.images.length / _pageSize).ceil();
    visibleImages.addAll(widget.images.getRange(0, _pageSize));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: SafeArea(
            child: Scrollbar(
          radius: const Radius.circular(2),
          child: GridView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8.0),
            itemCount: visibleImages.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: (constraints.maxWidth - 16) ~/ 160,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2 / 3,
            ),
            itemBuilder: (context, index) {
              return Image.network(visibleImages[index]);
            },
          ),
        )),
      );
    });
  }

  // when hit the bottom of the gridview, load more images
  ScrollController get _scrollController {
    var controller = ScrollController();
    var start = _page * _pageSize;
    var end = (_page + 1) * _pageSize;
    if (end > widget.images.length) {
      end = widget.images.length;
    }
    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          _page < _maxPage) {
        setState(() {
          _page++;
          visibleImages.addAll(widget.images.getRange(start, end));
        });
      }
    });
    return controller;
  }
}
