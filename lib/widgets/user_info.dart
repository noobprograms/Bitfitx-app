import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatelessWidget {
  UserInfo(
      {Key? key,
      required this.username,
      required this.profileImageUrl,
      required this.timeUploaded})
      : super(key: key);
  final String username;
  final String profileImageUrl;
  final Timestamp timeUploaded;
  int difference = 10;
  @override
  Widget build(BuildContext context) {
    difference = DateTime.now()
        .difference(DateTime.parse(timeUploaded.toDate().toString()))
        .inHours;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        children: <Widget>[
          CircleAvatar(
            radius: 15.0,
            backgroundColor: Colors.grey[300],
            backgroundImage: CachedNetworkImageProvider(profileImageUrl),
          ),
          SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  '${difference}h',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Color.fromARGB(255, 130, 128, 128),
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
