// likes and comments for each post have their own collections.
// But we still store the likes count

import '/core/constants/firebase_field_names.dart';

class Post {
  final String postId;
  final String posterId;
  final String content;
  final List<String> imageUrls;
  final DateTime datePublished;
  final int likesCount;

  Post({
    required this.postId,
    required this.posterId,
    required this.content,
    required this.imageUrls,
    required this.datePublished,
    required this.likesCount,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      FirebaseFieldNames.postId: postId,
      FirebaseFieldNames.posterId: posterId,
      FirebaseFieldNames.content: content,
      FirebaseFieldNames.imageUrls: imageUrls,
      FirebaseFieldNames.datePublished: datePublished.millisecondsSinceEpoch,
      FirebaseFieldNames.likesCount: likesCount,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map[FirebaseFieldNames.postId] as String,
      posterId: map[FirebaseFieldNames.posterId] as String,
      content: map[FirebaseFieldNames.content] as String,
      imageUrls: List<String>.from(
          (map[FirebaseFieldNames.imageUrls] as List<String>)),
      datePublished: DateTime.fromMillisecondsSinceEpoch(
          map[FirebaseFieldNames.datePublished] as int),
      likesCount: map[FirebaseFieldNames.likesCount] as int,
    );
  }
}

List<Post> fakePosts = [
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
  Post(
    postId: '1',
    posterId: '11',
    content: 'Fake text',
    imageUrls: [],
    datePublished: DateTime(2023, 07, 20),
    likesCount: 21403,
  ),
];