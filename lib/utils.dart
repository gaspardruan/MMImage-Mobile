import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/image_suit.dart';

// const value
const baseURL = 'http://newxiuren.com/uploadfiles/';
const gihubHome = 'https://github.com/gaspardruan/MMImage-Mobile';
const bilibiliHome = 'https://space.bilibili.com/470093851';
const pageSize = 24;
const viewCacheStep = 16;
const coverCacheStep = 16;

// ------- image data utils -------

String getYearFromId(int id) {
  return id.toString().substring(0, 4);
}

String getCoverURL(int id, String prefix) {
  return '$baseURL/$prefix/${getYearFromId(id)}/$id/cover.jpg';
}

List<String> getImageURLs(ImageSuit suit) {
  final id = suit.id;
  final prefix = suit.prefix;
  return List.generate(
      suit.count,
      (i) =>
          '$baseURL/$prefix/${getYearFromId(id)}/$id/${id * 100 + i + 1}.jpg',
      growable: false);
}

String getId(ImageSuit suit) {
  return '${suit.prefix}-${suit.id}';
}

bool shouldUpdate(DateTime lastUpdate) {
  final now = DateTime.now();
  final oneClock = DateTime(now.year, now.month, now.day, 1, 1);
  final yesterdayOncClock = oneClock.subtract(Duration(days: 1));
  return now.isAfter(oneClock) && lastUpdate.isBefore(oneClock) ||
      now.isBefore(oneClock) && lastUpdate.isBefore(yesterdayOncClock);
}

// ------- string utils -------

String getTimeStr(DateTime time) {
  // 2021-09-01 12:00:00
  return time.toString().substring(0, 19);
}

Icon getThemeModeIcon(ThemeMode themeMode) {
  switch (themeMode) {
    case ThemeMode.system:
      return const Icon(CupertinoIcons.sun_min_fill);
    case ThemeMode.light:
      return const Icon(CupertinoIcons.sun_max_fill);
    case ThemeMode.dark:
      return const Icon(CupertinoIcons.moon_stars_fill);
  }
}

// ------- external url utils -------

Future<void> launchURL(String url) async {
  if (!await launchUrl(Uri.parse(url), mode: LaunchMode.platformDefault)) {
    throw 'Could not launch $url';
  }
}

void goGithubHome() {
  launchURL(gihubHome);
}

void goBilibiliHome() {
  launchURL(bilibiliHome);
}
