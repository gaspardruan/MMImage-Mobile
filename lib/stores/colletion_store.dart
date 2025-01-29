import 'package:flutter/material.dart';

import '../models/image_suit.dart';
import '../utils.dart';

class CollectionStore extends ChangeNotifier {
  Map<String, ImageSuit> collections = {};

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
