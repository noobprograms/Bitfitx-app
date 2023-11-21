import 'package:cloud_firestore/cloud_firestore.dart';

class CommentPost {
  CommentPost(this.commentId, this.content, this.uid, this.profileImageUrl,
      this.name, this.time);
  final commentId;
  final content;
  final uid;
  final profileImageUrl;
  final name;

  final Timestamp time;

  Map<String, dynamic> toJson() {
    return {
      'commentId': commentId,
      'content': content,
      'timestamp': time,
      'uid': uid,
      'name': name,
      'profileImageUrl': profileImageUrl,
    };
  }
}
