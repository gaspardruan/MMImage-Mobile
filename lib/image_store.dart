import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mmimage_mobile/models/name_model.dart';

import 'models/beauty_suit.dart';
import 'models/image_suit.dart';

const String _latestURL = 'http://43.143.5.32:1314/latest';
const String _beautyURL = 'http://43.143.5.32:1314/beauty';

class ImageStore extends ChangeNotifier {
  late List<ImageSuit> latest;
  late List<NameModel> names;
  late Map<String, ImageCollection> albums;
  late List<String> tags;
  bool loaded = false;

  ImageStore() {
    initStore();
  }

  Future initStore() async {
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

    log(latest.length.toString());
    loaded = true;
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
