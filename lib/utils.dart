import 'package:mmimage_mobile/models/image_suit.dart';

const baseURL = 'http://newxiuren.com/uploadfiles/';
const pageSize = 24;
const cacheStep = 16;

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
