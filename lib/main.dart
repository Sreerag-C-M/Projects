import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:miniflutter/Home/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDmuWu8zsniWTl8VHKVxLbCPUvVZeY913I",
          appId: "1:56449440269:android:538697e0d01b3e1b529344",
          messagingSenderId: "56449440269",
          projectId: "minipro-9d805",
          storageBucket: "minipro-9d805.appspot.com"));
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Splashscrn(),
  ));
}
 