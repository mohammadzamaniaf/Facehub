import 'package:flutter/foundation.dart' show immutable;

@immutable
class Story {
  final String imageUrl;
  final DateTime createdAt;
  final String storyId;
  final String authorId;
  final List<String> views;

  const Story({
    required this.imageUrl,
    required this.createdAt,
    required this.storyId,
    required this.authorId,
    required this.views,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'imageUrl': imageUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'storyId': storyId,
      'authorId': authorId,
      'views': views,
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      imageUrl: map['imageUrl'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int),
      storyId: map['storyId'] as String,
      authorId: map['authorId'] as String,
      views: List<String>.from((map['views'] as List<String>)),
    );
  }
}
