import 'package:final_project/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/services/database.dart';
import 'package:flutter_login/flutter_login.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService dbService = DatabaseService();

  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uId: user.uid,name:user.displayName,imageUrl:user.photoUrl) : null;
  }

  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

//sign in anon
  // Future signInAnon() async {
  //   try {
  //     AuthResult result = await _auth.signInAnonymously();
  //     FirebaseUser user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

//sign in with email &pass

 // Future signInWithEmailAndPassword(String email, String password) async {
     Future signInEmail(LoginData logindata) async {
     try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: logindata.name, password: logindata.password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
    // try {
    //   AuthResult result = await _auth.signInWithEmailAndPassword(
    //       email: email, password: password);
    //   FirebaseUser user = result.user;
    //   return _userFromFirebaseUser(user);
    // } catch (e) {
    //   print(e.toString());
    //   return null;
    // }
  }

//register with email & password

  // Future signUpEmail(String email, String password) async {
  //   try {
  //     AuthResult result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     FirebaseUser user = result.user;
  //     dbService.createUserProfile(user.uid);
  //     return _userFromFirebaseUser(user);
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  //register email pass
  Future signUpEmail(LoginData loginData) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: loginData.name, password: loginData.password);
      FirebaseUser user = result.user;
      dbService.createUserProfile(user.uid);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

//sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
   Future updateUser(String name,String url) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

  UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
  userUpdateInfo.displayName = name;
  userUpdateInfo.photoUrl = url;


  user.updateProfile(userUpdateInfo);
  }

}
