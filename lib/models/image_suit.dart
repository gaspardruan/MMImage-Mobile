class ImageSuit {
  final int id;
  final String name;
  final int count;
  final String prefix;
  final DateTime time;

  ImageSuit(
      {required this.id,
      required this.name,
      required this.count,
      required this.prefix,
      required this.time});

  ImageSuit.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        count = json['count'],
        prefix = json['prefix'],
        time = DateTime.parse(json['time']);

  static List<ImageSuit> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((e) => ImageSuit.fromJson(e)).toList();
  }
}
