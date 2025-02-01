import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mmimage_mobile/models/name_model.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/beauty_suit.dart';
import '../models/image_suit.dart';
import '../utils.dart';

const String _latestURL = 'http://43.143.5.32:1314/latest';
const String _beautyURL = 'http://43.143.5.32:1314/beauty';

class GlobalPersistence {
  static const String key = 'global';

  static Future<Map<String, dynamic>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final globalStr = prefs.getString(key);
    if (globalStr == null) {
      return {};
    }

    final json = jsonDecode(globalStr);
    return {
      'latest':
          json['latest'].map<ImageSuit>((e) => ImageSuit.fromJson(e)).toList(),
      'names':
          json['names'].map<NameModel>((e) => NameModel.fromJson(e)).toList(),
      'albums': json['albums'].map<String, ImageCollection>((key, value) =>
          MapEntry(key as String, ImageCollection.fromJson(value))),
      'tags': json['tags'].map<String>((e) => e as String).toList(),
      'lastUpdate': DateTime.parse(json['lastUpdate']),
    };
  }

  static Future<void> save(Map<String, dynamic> global) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(global));
  }
}

class GlobalStore extends ChangeNotifier {
  // data
  late List<ImageSuit> latest;
  late List<NameModel> names;
  late Map<String, ImageCollection> albums;
  late List<String> tags;

  // time
  DateTime lastUpdate = DateTime.fromMillisecondsSinceEpoch(0);

  // setting
  ThemeMode themeMode = ThemeMode.dark;
  int columnNum = 0;

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
    final global = await GlobalPersistence.load();
    if (global.isEmpty) return false;
    latest = global['latest'] ?? latest;
    names = global['names'] ?? names;
    albums = global['albums'] ?? albums;
    tags = global['tags'] ?? tags;
    lastUpdate = global['lastUpdate'] ?? lastUpdate;
    return true;
  }

  void save() async {
    await GlobalPersistence.save({
      'latest': latest.map((e) => e.toJson()).toList(),
      'names': names.map((e) => e.toJson()).toList(),
      'albums': albums.map((key, value) => MapEntry(key, value.toJson())),
      'tags': tags,
      'lastUpdate': lastUpdate.toIso8601String(),
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
