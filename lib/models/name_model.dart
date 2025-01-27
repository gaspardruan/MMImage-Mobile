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
}
