import 'dart:async';
import 'package:final_project/models/product.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/models/comment.dart';
import 'package:final_project/models/user.dart';
import 'package:flutter/foundation.dart';


class DatabaseService with ChangeNotifier {
  final dbRef = FirebaseDatabase.instance.reference();
  final dbRef2 = FirebaseDatabase.instance.reference().child("favorites");

  //Kayıt ekranından sonra isim soyisim al bu metoda gönder.
  void createUserProfile(String uid) {
    dbRef.child("users").child(uid).set({
      "imageUrl":
          "https://www.fenbilimlerianadolulisesi.com/wp-content/uploads/2019/08/user-2517433_960_720-300x300.png",
      "favorites": ["weXlKAuAOefkgGYR2FgMQqyKzCd2", "-LxIsyx5Q_ChoSuVQYvx"],
      "lastname": " ",
      "name": " ",
      "comments": ["commentId", "commentId"]
    });
    //final CollectionReference projectCollection= Firestore.instance.collection('projetData');
  }

  List<Comment> userComments = List<Comment>();
  Future getUserComments(String uid) async {
    var result = await dbRef.child("comments").once();
    for (var i in result.value) {
      if (i.value["userId"] == uid) {
        Comment comment = Comment();
        comment.id = i.key;
        comment.comment = i.value["comment"];
        userComments.add(comment);
      }
    }
    return userComments;
  }

  fillUserInfoInComment(String uid) async {
    var userMap = {"name": "", "lastname": "", "imageUrl": ""};
    try {
      await dbRef.child("users/$uid").once().then((DataSnapshot snapshot) {
        userMap["name"] = snapshot.value["name"];
        userMap["lastname"] = snapshot.value["lastname"];
        userMap["imageUrl"] = snapshot.value["imageUrl"];
      });
      return userMap;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  fillProductInfoInComment(String id) async {
    Product product;

    //  var userMap = {"name": "", "description": "", "imageUrl": "","price":""};
    try {
      await dbRef2
          .orderByKey()
          .equalTo(id)
          .once()
          .then((DataSnapshot snapshot) {
        product.name = snapshot.value["name"];
        product.description = snapshot.value["description"];
        product.imageUrl = snapshot.value["imageUrl"];
        product.price = snapshot.value["price"];
      });
      return product;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // fillBrandInfoInComment(String brandId) async {
  //   var brandMap = {"name": ""};
  //   try {
  //     await dbRef.child("brands/$brandId").once().then((DataSnapshot snapshot) {
  //       brandMap["name"] = snapshot.value["name"];
  //     });
  //     return brandMap;
  //   } catch (e) {}
  // }

  //Firebaseden veri çekme
  User getUser(String uid) {
    User user = User();
    dbRef.child("users/$uid").once().then((DataSnapshot snapshot) {
      user.name = snapshot.value["name"];
      user.lastname=snapshot.value["lastname"];
    });
    return user;
  }

  List<dynamic> productId = List<dynamic>();
  List getProductId(String id) {
    User user = User();

    dbRef2.orderByKey().equalTo(user.uId).once().then((DataSnapshot snapshot) {
      productId.add(snapshot.value["productId"]);
    });

    return productId;
  }

  List<Product> product;

  //  Product getProduct(String id) {
  //   dbRef.orderByChild("productId").equalTo(id).once().then((DataSnapshot snapshot) {
  //     product.add(snapshot.value["name"],);
  //     product.description=;
  //     product.price=snapshot.value["price"];
  //     product.imageUrl=snapshot.value["imageUrl"];

  //   });
  //   return product;
  // }
  List<User> _items = [];

  //Kullanıcının adını soyadını girdiği ekranın metodu
  //Genişleticelek..
  Future updateUserInfo(User user) async {
    if (user != null) {
      await dbRef.child("users").child(user.uId).set({
        "name": user.name,
        "lastname": user.lastname,
        "imageUrl":
            "https://www.fenbilimlerianadolulisesi.com/wp-content/uploads/2019/08/user-2517433_960_720-300x300.png",
        "favorites": ["weXlKAuAOefkgGYR2FgMQqyKzCd2", "-LxIsyx5Q_ChoSuVQYvx"],
        "comments": ["commentId", "commentId"]
      });
    }
  }

  List<Comment> _itemsc = [];
  Comment findById(String id) {
    return _itemsc.firstWhere((comment) => comment.id == id);
  }

  Map<String, Comment> _itemss = {};
  Map<String, Comment> get items {
    return {..._itemss};
  }

  productInfo(String uid) async {
    var userMap = { "isFavorite": ""};
    try {
      dbRef2.orderByKey().equalTo(uid).once().then((DataSnapshot snapshot) {
        if (snapshot.value["isFavorite"] == true) {
           userMap["isFavorite"] = snapshot.value["isFavorite"];

          print("nurselin");
        }
        else{print("boss");}
        //  userMap["name"] = snapshot.value["name"];
        // userMap["lastname"] = snapshot.value["lastname"];
        // userMap["imageUrl"] = snapshot.value["imageUrl"];
      });

      // await dbRef.child("users/$uid").once().then((DataSnapshot snapshot) {

      //   userMap["name"] = snapshot.value["name"];
      //   userMap["lastname"] = snapshot.value["lastname"];
      //   userMap["imageUrl"] = snapshot.value["imageUrl"];
      // });
      // return userMap;
    } catch (e) {
      print(e.toString());
      return userMap;
    }
  }

  List<Comment> _userFromFirebaseUser() {
    dbRef.once().then((DataSnapshot dataSnapshot) {
      var comments = dataSnapshot as Map<String, dynamic>;
      comments.forEach((k, v) {
        Comment comment = Comment();
        comment.id = k;
        comment.comment = v["comment"];
        comment.userId = v["userId"];
        comment.date = v["date"];
      });
    });

    // return comments != [] ? comments : null;
  }
}
