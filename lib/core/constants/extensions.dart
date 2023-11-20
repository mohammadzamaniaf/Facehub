import 'package:jiffy/jiffy.dart';

extension FormatDate on DateTime {
  String yMMMEd() => Jiffy.parseFromDateTime(this).yMMMEd;
}

extension FormatDate2 on DateTime {
  String jm() => Jiffy.parseFromDateTime(this).jm;
}

extension TimeAgo on DateTime {
  String fromNow() => Jiffy.parseFromDateTime(this).fromNow();
}
