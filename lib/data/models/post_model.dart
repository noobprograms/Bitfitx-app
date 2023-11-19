class Post {
  String pid;
  String uid;

  String content;
  DateTime dateTime;
  String postPictureUrl;
  String comments;
  String likes;

  static final defaultDate = DateTime.now();
  Post({
    required this.pid,
    required this.uid,
    required this.postPictureUrl,
    this.content = '',
    this.comments = '0',
    this.likes = '0',
    DateTime? dateTime,
  }) : this.dateTime = dateTime ?? defaultDate;

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pid': pid,
      'dateTime': dateTime.toString(),
      'postPictureUrl': postPictureUrl,
      'content': content,
      'comments': comments,
      'likes': likes,
    };
  }
}
