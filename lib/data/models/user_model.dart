import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String uid;
  String name;
  String email;
  String profileImageUrl;
  String coverImageUrl;
  List following;
  List fans;

  String posts;
  String tokenValue;
  String wallet;

  User(
      {required this.uid,
      required this.name,
      required this.email,
      this.profileImageUrl = '',
      this.coverImageUrl = '',
      this.wallet = '0.0',
      required this.following,
      required this.fans,
      this.posts = "0",
      required this.tokenValue});
  void updateUser(
    String uid,
    name,
    email,
    profileImageUrl,
    coverImageUrl,
  ) {
    this.name = name;
    this.uid = uid;
    this.email = email;
    this.profileImageUrl = profileImageUrl;
    this.coverImageUrl = coverImageUrl;
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profileImageUrl': profileImageUrl,
      'coverImageUrl': coverImageUrl,
      'following': following,
      'wallet': wallet,
      'fans': fans,
      'posts': posts,
      'tokenValue': tokenValue
    };
  }

  // static User fromSnap(DocumentSnapshot snap) {
  //   var snapShot = snap.data() as Map<String, dynamic>;

  //   return User(
  //       uid: snapShot['uid'],
  //       name: snapShot['name'],
  //       email: snapShot['email'],
  //       profileImageUrl: snapShot['profileImageUrl'],
  //       coverImageUrl: snapShot['coverImageUrl'],
  //       tokenValue: snapShot['tokenValue']);
  // }
}
