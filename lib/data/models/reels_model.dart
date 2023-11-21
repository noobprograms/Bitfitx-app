import 'package:cloud_firestore/cloud_firestore.dart';

class Reel {
  String username;
  String uid;
  String rid;
  List likes;
  int commentCount;
  int shareCount;

  String caption;
  String videoUrl;

  String profilePhoto;

  Reel({
    required this.username,
    required this.uid,
    required this.rid,
    required this.likes,
    required this.commentCount,
    required this.shareCount,
    required this.caption,
    required this.videoUrl,
    required this.profilePhoto,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "rid": rid,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "caption": caption,
        "videoUrl": videoUrl,
      };

  static Reel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Reel(
      username: snapshot['username'],
      uid: snapshot['uid'],
      rid: snapshot['rid'],
      likes: snapshot['likes'],
      commentCount: snapshot['commentCount'],
      shareCount: snapshot['shareCount'],
      caption: snapshot['caption'],
      videoUrl: snapshot['videoUrl'],
      profilePhoto: snapshot['profilePhoto'],
    );
  }
}
