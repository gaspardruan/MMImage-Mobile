import 'image_suit.dart';

class BeautySuit {
  final Map<String, List<String>> names;
  final Map<String, ImageCollection> collections;

  BeautySuit({required this.names, required this.collections});

  BeautySuit.fromJson(Map<dynamic, dynamic> json)
      : names = json['names'].map<String, List<String>>(
            (key, value) => MapEntry(key as String, List<String>.from(value))),
        collections = json['images'].map<String, ImageCollection>(
            (key, value) =>
                MapEntry(key as String, ImageCollection.fromJson(value)));
}

class ImageCollection {
  final int num;
  final List<ImageSuit> suits;

  ImageCollection({required this.num, required this.suits});

  ImageCollection.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        suits = ImageSuit.fromJsonList(json['images']);
}
