import 'package:jiffy/jiffy.dart';

extension FormatDate on DateTime {
  String yMMMEd() => Jiffy.parseFromDateTime(this).yMMMEd;
}

extension TimeAgo on DateTime {
  String fromNow() => Jiffy.parseFromDateTime(this).fromNow();
}
