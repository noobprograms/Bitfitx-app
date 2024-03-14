import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bitfitx_project/core/utils/auth_constants.dart';
import 'package:bitfitx_project/data/models/message_model.dart';
import 'package:bitfitx_project/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:path/path.dart';

class ChatService extends ChangeNotifier {
  RxBool isLoading = false.obs;

  /////utility function to get the array of the chatrooms///////////

  static Future<List<String>> getDocumentIdsFromCollection(
      String collectionName) async {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);

    QuerySnapshot querySnapshots = await collection.get();

    List<String> documentIds = [];
    for (var snapshot in querySnapshots.docs) {
      documentIds.add(snapshot.id);
    }

    return documentIds;
  }

  Future<void> sendMessage(User sender, User receiver, String message,
      Type type, String assetLink) async {
    final Timestamp timestamp = Timestamp.now();

    Message newMessage =
        Message(sender.uid, receiver.uid, timestamp, message, type, assetLink);

    //generating the chatroom id
    List<String> ids = [sender.uid, receiver.uid];

    ids.sort();
    String chatRoomId = ids.join('-');

    //storing everything to database
    //if the type of message is text then everythings simple
    if (type == Type.text) {
      await firebaseFirestore
          .collection('rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toJson())
          .then((value) => sendPushNotif(sender, receiver, message));
    } else {
      //for images and videos we need to store them in a storage bucket
      //and just keep the url here
      Reference ref =
          firebaseStorage.ref().child('message_files').child(message);
      File myFile = File(assetLink);

      isLoading.value = true;
      UploadTask uploadTask = ref.putFile(myFile);
      TaskSnapshot snap = await uploadTask;
      isLoading.value = false;
      String downloadUrl = await snap.ref.getDownloadURL();
      newMessage.assetLink = downloadUrl;

      await firebaseFirestore
          .collection('rooms')
          .doc(chatRoomId)
          .collection('messages')
          .add(newMessage.toJson())
          .then((value) => sendPushNotif(sender, receiver, 'Media'));
    }
  }

  static Stream<QuerySnapshot> getLastUserMessage(
      User thisUser, User otherUser) {
    List<String> ids = [thisUser.uid, otherUser.uid];
    ids.sort();
    String chatRoomId = ids.join('-');
    return firebaseFirestore
        .collection('rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots();
  }

  Stream<QuerySnapshot> getChatsForUser(String thisUser, String otherUser) {
    ///calculating the chatroom id to get the right data
    List<String> ids = [thisUser, otherUser];
    ids.sort();
    String chatRoomId = ids.join('-');

    //getting the data from firebase
    return firebaseFirestore
        .collection('rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  static Future<void> sendPushNotif(
      User chatUser, User receiver, String message) async {
    print('the token value in chatservice${receiver.tokenValue!}');
    try {
      final body = {
        "priority": 'high',
        "to": receiver.tokenValue,
        "notification": {
          "title": chatUser.name,
          "body": message,
          "android_channel_id": "chats"
        },
      };
      var response =
          await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: {
                'Content-Type': 'application/json',
                'Authorization':
                    'key=fcm_push_notification_key_here'
              },
              body: jsonEncode(body));
      print(response.body);
    } catch (e) {
      print(e.toString());
    }
  }
}
