import 'package:cloud_firestore/cloud_firestore.dart';

class GroupPost {
  String pid;
  String uid;

  String content;
  Timestamp dateTime;
  String postPictureUrl;
  String comments;
  String likes;
  String onSale;
  String price;
  String gid;

  static final defaultDate = DateTime.now();
  GroupPost({
    required this.pid,
    required this.uid,
    required this.postPictureUrl,
    required this.dateTime,
    required this.gid,
    this.content = '',
    this.comments = '0',
    this.likes = '0',
    this.onSale = 'false',
    this.price = '0.0',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pid': pid,
      'gid': gid,
      'dateTime': dateTime,
      'postPictureUrl': postPictureUrl,
      'content': content,
      'comments': comments,
      'likes': likes,
      'onSale': onSale,
      'price': price,
    };
  }
}
