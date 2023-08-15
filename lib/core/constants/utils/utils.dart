import 'package:flutter/cupertino.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

final today = DateTime.now();
// 18 years ago
final initialDate = DateTime.now().subtract(const Duration(days: 365 * 18));
// User can be born anytime after 1900 AD
final firstDate = DateTime(1900);
// User should at least be 7 years old
final lastDate = DateTime.now().subtract(const Duration(days: 365 * 7));

Future<DateTime?> pickSimpleDate({
  required BuildContext context,
  required DateTime? date,
}) async {
  final dateTime = await DatePicker.showSimpleDatePicker(
    context,
    initialDate: date ?? initialDate,
    firstDate: firstDate,
    lastDate: lastDate,
    dateFormat: "dd-MMMM-yyyy",
  );

  return dateTime;
}
