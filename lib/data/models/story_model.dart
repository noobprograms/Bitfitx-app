import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaType { image, video }

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final User user;
  DateTime timeUploaded;
  static final defaultDate = DateTime.now();

  Story(
      {required this.url,
      required this.media,
      required this.duration,
      required this.user,
      DateTime? timeUploaded})
      : this.timeUploaded = timeUploaded ?? defaultDate;

  Map<String, dynamic> toJson() => {
        "url": url,
        "media": media.name,
        "duration": duration.toString(),
        "user": user.uid,
        "timeUploaded": timeUploaded.toString(),
      };
  Story fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    Future thisUser = getUser(snapshot);
    return Story(
      url: snapshot['url'],
      media: MediaType.values.byName(snapshot['media']),
      duration: snapshot['duration'] as Duration,
      user: thisUser as User,
      timeUploaded: snapshot['timeUploaded'] as DateTime,
    );
  }

  Future getUser(var snapshot) async {
    return await firebaseFirestore
        .collection('users')
        .doc(snapshot['user'])
        .get();
  }
}
