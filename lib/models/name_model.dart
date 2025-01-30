import 'package:azlistview/azlistview.dart';

class NameModel extends ISuspensionBean {
  String name;
  String tag;

  NameModel({
    required this.name,
    required this.tag,
    showSuspension = false,
  }) {
    super.isShowSuspension = showSuspension;
  }

  @override
  String getSuspensionTag() => tag;

  NameModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        tag = json['tag'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'tag': tag,
      };
}
