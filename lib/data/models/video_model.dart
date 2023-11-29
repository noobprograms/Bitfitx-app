import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String vid;
  String uid;

  String content;
  Timestamp dateTime;
  String videoUrl;
  String comments;
  String likes;
  String onSale;
  String price;

  static final defaultDate = DateTime.now();
  Video({
    required this.vid,
    required this.uid,
    required this.videoUrl,
    required this.dateTime,
    this.content = '',
    this.comments = '0',
    this.likes = '0',
    this.onSale = 'false',
    this.price = '0.0',
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'pid': vid,
      'dateTime': dateTime,
      'postPictureUrl': videoUrl,
      'content': content,
      'comments': comments,
      'likes': likes,
      'onSale': onSale,
      'price': price,
    };
  }
}
