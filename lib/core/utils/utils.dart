import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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

// show Snack Bar
void showSnackBar({
  required String title,
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(title),
      ),
    );
}

// Show Toast Message
void showToastMessage({
  required String text,
}) {
  Fluttertoast.showToast(
    msg: text,
    backgroundColor: Colors.black54,
    fontSize: 18,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
  );
}

// Pick image
Future<File?> pickImage({
  required ImageSource source,
}) async {
  File? image;
  final picker = ImagePicker();
  final file = await picker.pickImage(
    source: source,
    maxHeight: 720,
    maxWidth: 720,
  );
  if (file != null) {
    image = File(file.path);
  }
  return image;
}

// Pick Video
Future<File?> pickVideo({
  required ImageSource source,
}) async {
  File? video;
  final picker = ImagePicker();
  final file = await picker.pickVideo(
    source: source,
    maxDuration: const Duration(minutes: 5),
  );
  if (file != null) {
    video = File(file.path);
  }
  return video;
}

// Pick image
Future<File?> pickImageOrVideo({
  required BuildContext context,
}) async {
  return showDialog(
    context: context,
    builder: (_) {
      return SimpleDialog(
        children: [
          TextButton(
            onPressed: () async {
              await pickVideo(source: ImageSource.gallery).then((video) {
                if (video != null) {
                  Navigator.of(context).pop(video);
                  return video;
                }
                Navigator.of(context).pop();
              });
            },
            child: const Text('Pick Video'),
          ),
          TextButton(
            onPressed: () async {
              await pickImage(source: ImageSource.gallery).then((image) {
                if (image != null) {
                  Navigator.of(context).pop(image);
                  return image;
                }
                Navigator.of(context).pop();
              });
            },
            child: const Text('Pick Image'),
          ),
        ],
      );
    },
  );
}
