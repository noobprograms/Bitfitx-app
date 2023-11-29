import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum MediaType { image, video }

class Story {
  final String sid;
  final String url;
  final MediaType media;
  final Duration duration;
  final String uid;
  final String name;
  final String profileImageUrl;
  Timestamp timeUploaded;
  // static final defaultDate = Timestamp.now();

  Story(
      {required this.url,
      required this.sid,
      required this.media,
      required this.duration,
      required this.uid,
      required this.name,
      required this.profileImageUrl,
      required this.timeUploaded});

  Map<String, dynamic> toJson() => {
        "url": url,
        "sid": sid,
        "media": media.name,
        "duration": duration.toString(),
        "uid": uid,
        "name": name,
        "profileImageUrl": profileImageUrl,
        "timeUploaded": timeUploaded,
      };
  static Story fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Story(
      url: snapshot['url'],
      sid: snapshot['sid'],
      media: MediaType.values.byName(snapshot['media']),
      duration: snapshot['duration'] as Duration,
      uid: snapshot['uid'],
      name: snapshot['name'],
      profileImageUrl: snapshot['profileImageUrl'],
      timeUploaded: snapshot['timeUploaded'],
    );
  }

  static Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }
}
