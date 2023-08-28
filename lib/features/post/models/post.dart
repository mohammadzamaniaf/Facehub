import '/core/constants/firebase_field_names.dart';

class Post {
  final String postId;
  final String posterId;
  final String content;
  final String postType;
  final String fileUrl;
  final DateTime datePublished;
  final List<String> likes;

  Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.postType,
    required this.fileUrl,
    required this.datePublished,
    required this.likes,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.fileUrl: fileUrl,
      FirebaseFieldNames.datePublished: datePublished.millisecondsSinceEpoch,
      FirebaseFieldNames.likes: likes,
      FirebaseFieldNames.postType: postType,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] ?? '',
      posterId: map[FirebaseFieldNames.posterId] ?? '',
      content: map[FirebaseFieldNames.content] ?? '',
      postType: map[FirebaseFieldNames.postType] ?? '',
      fileUrl: map[FirebaseFieldNames.fileUrl] ?? '',
      datePublished: DateTime.fromMillisecondsSinceEpoch(
        map[FirebaseFieldNames.datePublished] ?? 0,
      ),
      likes: List<String>.from(
        (map[FirebaseFieldNames.likes] ?? []),
      ),
    );
  }
}
