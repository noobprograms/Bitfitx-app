class Post {
  String pid;
  int uid;

  String content;
  DateTime dateTime;

  String comments;
  String likes;
  Post(
      {required this.pid,
      required this.uid,
      required this.dateTime,
      this.content = '',
      this.comments = '0',
      this.likes = '0'});

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pid': pid,
      'dateTime': dateTime,
      'content': content,
      'comments': comments,
      'likes': likes,
    };
  }
}
