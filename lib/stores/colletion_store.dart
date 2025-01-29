import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/image_suit.dart';
import '../utils.dart';

class CollectionPersistence {
  static const String key = 'collections';

  static Future<Map<String, ImageSuit>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final collectionStr = prefs.getString(key);
    if (collectionStr == null) {
      return {};
    }

    Map<String, dynamic> json = jsonDecode(collectionStr);
    final Map<String, ImageSuit> collections = {};
    json.forEach((key, value) {
      collections[key] = ImageSuit.fromJson(value);
    });
    return collections;
  }

  static Future<void> save(Map<String, ImageSuit> collections) async {
    final prefs = await SharedPreferences.getInstance();
    final json = collections.map((key, value) => MapEntry(key, value.toJson()));

    final collectionStr = jsonEncode(json);
    await prefs.setString(key, collectionStr);
  }
}

class CollectionStore extends ChangeNotifier {
  Map<String, ImageSuit> collections = {};

  CollectionStore() {
    initStore();
  }

  void initStore() async {
    collections = await CollectionPersistence.load();
    notifyListeners();
  }

  void save() async {
    await CollectionPersistence.save(collections);
  }

  bool contains(ImageSuit suit) {
    return collections.containsKey(getId(suit));
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
    if (collections.containsKey(key)) {
      collections.remove(key);
    } else {
      collections[key] = suit;
    }
    notifyListeners();
  }
}
