import 'dart:convert';import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User with ChangeNotifier {
  final String uId;
  String name;
  String lastname;
  String email;
  List<String> comments;
  String imageUrl;
  List<String> favorites;

  User(
      {this.uId,
      this.name,
      this.lastname,
      this.imageUrl,
      this.comments,
      this.favorites,
      this.email});

       Future<void> fetcAndSetUser() async {
   FirebaseUser user = await FirebaseAuth.instance.currentUser();
User userr = User();

  if (user.displayName != null) {
    userr.name = user.displayName;
  } else {
    userr.name = 'user';
  }
  if (user.photoUrl != null) {
    userr.imageUrl = user.photoUrl;
  } else {
    userr.imageUrl =
        'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png';
  }

  return userr;
   
  }
}
