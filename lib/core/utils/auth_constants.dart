import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart' as userModel;
import '../../googleauth/controller/auth_controller.dart';

AuthController authController = AuthController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
var firebaseStorage = FirebaseStorage.instance;
GoogleSignIn googleSign = GoogleSignIn();
Future<SharedPreferences> prefs = SharedPreferences.getInstance();

//requestion the permission for push notifications

FirebaseMessaging messaging = FirebaseMessaging.instance;
