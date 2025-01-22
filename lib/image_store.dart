import 'dart:convert';
import 'dart:developer';
// import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'models/beauty_suit.dart';
import 'models/image_suit.dart';

const String _latestURL = 'http://43.143.5.32:1314/latest';
const String _beautyURL = 'http://43.143.5.32:1314/beauty';

class ImageStore extends ChangeNotifier {
  late List<ImageSuit> latest;
  late BeautySuit beauty;
  bool loaded = false;

  ImageStore() {
    initStore();
  }

  Future initStore() async {
    final latestResponse = await http.get(Uri.parse(_latestURL));
    final beautyResponse = await http.get(Uri.parse(_beautyURL));

    if (latestResponse.statusCode == 200 && beautyResponse.statusCode == 200) {
      latest = ImageSuit.fromJsonList(jsonDecode(latestResponse.body)['data']);
      beauty = BeautySuit.fromJson(jsonDecode(beautyResponse.body)['data']);
    } else {
      throw Exception('Failed to load images');
    }

    log(latest.length.toString());
    loaded = true;
    notifyListeners();
  }
}
