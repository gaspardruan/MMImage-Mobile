import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/name_model.dart';
import 'models/beauty_suit.dart';
import 'models/image_suit.dart';
import 'utils.dart';

const String _latestURL = 'http://43.143.5.32:1314/latest';
// 'https://gist.githubusercontent.com/gaspardruan/a6eca088981a25d9ea61ec50cf54b129/raw/latest.json';

const String _beautyURL = 'http://43.143.5.32:1314/beauty';
// 'https://gist.githubusercontent.com/gaspardruan/a6eca088981a25d9ea61ec50cf54b129/raw/beauty.json';

class GlobalStore extends ChangeNotifier {
  // ------- need to be persisted -------
  // image data
  late List<ImageSuit> latest; // latest page
  late List<NameModel> names; // album page
  late Map<String, ImageCollection> albums; // album detail page
  late List<String> tags; // album page

  // time
  DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  // setting
  ThemeMode themeMode = ThemeMode.system;
  int columnNum = 0;

  // collection
  Map<String, ImageSuit> collections = {};

  // ------------------------------------

  // version
  String version = '0.0.0';

  bool loaded = false;

  GlobalStore() {
    initStore();
  }

  Future initStore() async {
    final notFirstLoad = await updateFromLocal();
    version = (await PackageInfo.fromPlatform()).version;
    if (notFirstLoad) {
      loaded = true;
      notifyListeners();

      if (shouldUpdate(lastUpdate)) {
        await updateFromServer();
        lastUpdate = DateTime.now();
        notifyListeners();
      }
    } else {
      await updateFromServer();
      lastUpdate = DateTime.now();
      loaded = true;
      notifyListeners();
    }
  }

  Future<void> updateFromServer() async {
    final latestResponse = await http.get(Uri.parse(_latestURL));
    final beautyResponse = await http.get(Uri.parse(_beautyURL));

    if (latestResponse.statusCode == 200 && beautyResponse.statusCode == 200) {
      latest = ImageSuit.fromJsonList(jsonDecode(latestResponse.body)['data']);
      final beauty =
          BeautySuit.fromJson(jsonDecode(beautyResponse.body)['data']);
      names = _nameTrans(beauty.names);
      tags = _extractTags(beauty.names.keys.toList());
      albums = beauty.collections;
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<bool> updateFromLocal() async {
    final json = await GlobalPersistence.load();
    if (json.isEmpty) return false;

    latest =
        json['latest'].map<ImageSuit>((e) => ImageSuit.fromJson(e)).toList() ??
            latest;
    names =
        json['names'].map<NameModel>((e) => NameModel.fromJson(e)).toList() ??
            names;
    albums = json['albums'].map<String, ImageCollection>((key, value) =>
            MapEntry(key as String, ImageCollection.fromJson(value))) ??
        albums;
    tags = json['tags'].map<String>((e) => e as String).toList() ?? tags;
    lastUpdate = DateTime.parse(json['lastUpdate']);
    themeMode = ThemeMode.values[json['themeMode'] ?? 0];
    columnNum = json['columnNum'] ?? columnNum;
    collections = json['collections'].map<String, ImageSuit>((key, value) =>
            MapEntry(key as String, ImageSuit.fromJson(value))) ??
        collections;

    return true;
  }

  void save() async {
    await GlobalPersistence.save({
      'latest': latest.map((e) => e.toJson()).toList(),
      'names': names.map((e) => e.toJson()).toList(),
      'albums': albums.map((key, value) => MapEntry(key, value.toJson())),
      'tags': tags,
      'lastUpdate': lastUpdate.toIso8601String(),
      'themeMode': themeMode.index,
      'columnNum': columnNum,
      'collections':
          collections.map((key, value) => MapEntry(key, value.toJson()))
    });
  }

  void setThemeMode(ThemeMode mode) {
    themeMode = mode;
    notifyListeners();
  }

  void setColumnNum(int num) {
    columnNum = num;
    notifyListeners();
  }

  void like(ImageSuit suit) {
    final key = getId(suit);
    if (!collections.containsKey(key)) {
      collections[key] = suit;
      notifyListeners();
    }
  }

  void dislike(ImageSuit suit) {
    final key = getId(suit);
    if (collections.containsKey(key)) {
      collections.remove(key);
      notifyListeners();
    }
  }

  void toggle(ImageSuit suit) {
    final key = getId(suit);
    // create a new map to trigger the change
    collections = Map.from(collections);
    if (collections.containsKey(key)) {
      collections.remove(key);
    } else {
      collections[key] = suit;
    }
    notifyListeners();
  }

  List<NameModel> _nameTrans(Map<String, List<String>> nameMap) {
    List<NameModel> result = [];
    List<NameModel> odd = [];
    final RegExp tagReg = RegExp(r'^[A-Z]');
    nameMap.forEach((tag, names) {
      if (names.isEmpty) return;

      names.sort();

      if (tagReg.hasMatch(tag)) {
        result.add(NameModel(name: names[0], tag: tag, showSuspension: true));
        for (int i = 1; i < names.length; i++) {
          result.add(NameModel(name: names[i], tag: tag));
        }
      } else {
        for (int i = 0; i < names.length; i++) {
          odd.add(NameModel(name: names[i], tag: '#'));
        }
      }
    });
    odd[0].isShowSuspension = true;
    result.addAll(odd);
    return result;
  }

  List<String> _extractTags(List<String> rawTags) {
    final List<String> tags = [];
    final RegExp tagReg = RegExp(r'^[A-Z]');
    for (var t in rawTags) {
      if (tagReg.hasMatch(t)) {
        tags.add(t);
      }
    }
    if (tags.length < rawTags.length) tags.add('#');
    return tags;
  }
}

class GlobalPersistence {
  static const String key = 'global';

  static Future<Map<String, dynamic>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final globalStr = prefs.getString(key);
    if (globalStr == null) return {};

    return jsonDecode(globalStr);
  }

  static Future<void> save(Map<String, dynamic> global) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(global));
  }
}
