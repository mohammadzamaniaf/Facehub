// likes and comments for each post have their own collections.
// But we still store the likes count

import '/core/constants/firebase_field_names.dart';

class Post {
  final String postId;
  final String posterId;
  final String content;
  final List<String> imageUrls;
  final DateTime datePublished;
  final List<String> likes;

  Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.imageUrls,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.imageUrls: imageUrls,
      FirebaseFieldNames.datePublished: datePublished.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      imageUrls: List<String>.from(
        (map[FirebaseFieldNames.imageUrls] ?? []),
      ),
      datePublished: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.datePublished] ?? 0,
      ),
      likes: List<String>.from(
        (map[FirebaseFieldNames.likes] ?? []),
      ),
    );
  }
}
