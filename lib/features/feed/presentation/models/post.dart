// likes and comments for each post have their own collections.
// But we still store the likes count

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
      'postId': postId,
      'posterId': posterId,
      'content': content,
      'imageUrls': imageUrls,
      'datePublished': datePublished.millisecondsSinceEpoch,
      'likesCount': likesCount,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] as String,
      posterId: map['posterId'] as String,
      content: map['content'] as String,
      imageUrls: List<String>.from((map['imageUrls'] as List<String>)),
      datePublished:
          DateTime.fromMillisecondsSinceEpoch(map['datePublished'] as int),
      likesCount: map['likesCount'] as int,
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
