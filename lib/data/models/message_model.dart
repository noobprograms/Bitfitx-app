import 'package:cloud_firestore/cloud_firestore.dart';

enum Type { text, image, video, any }

class Message {
  Message(
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.message,
    this.type,
    this.assetLink,
  );
  final String senderId;
  final String receiverId;
  final Timestamp timestamp;
  String message;
  String assetLink;
  final Type type;
  // static Message fromJson(Map<String, dynamic> json) {
  //   return new Message(
  //       json['senderId'],
  //       json['receiverId'],
  //       json['timestamp'].toDate(),
  //       json['message'],
  //       json['type'],
  //       json['assetLink']);
  // }

  Map<String, dynamic> toJson() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'timestamp': timestamp,
      'message': message,
      'type': type.name,
      'asset': assetLink,
    };
  }
}
