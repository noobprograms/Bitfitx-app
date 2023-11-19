import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String pid;
  String uid;

  String content;
  Timestamp dateTime;
  String postPictureUrl;
  String comments;
  String likes;

  static final defaultDate = DateTime.now();
  Post({
    required this.pid,
    required this.uid,
    required this.postPictureUrl,
    required this.dateTime,
    this.content = '',
    this.comments = '0',
    this.likes = '0',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pid': pid,
      'dateTime': dateTime,
      'postPictureUrl': postPictureUrl,
      'content': content,
      'comments': comments,
      'likes': likes,
    };
  }
}
