import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:final_project/services/service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:final_project/models/user.dart';
import 'package:final_project/models/product.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/auth.dart';

import 'package:http/http.dart' as http;

AuthService _auth = AuthService();

var fRef = FirebaseDatabase().reference();
final dbRef = FirebaseDatabase.instance.reference().child('favorites');

class Favoriteproduct with ChangeNotifier {
  String id;
  String productId;
  String productName;
  String description;
  double price;
  String imageUrl;
  String rate;
  String fave;
  String comment;
  bool isFavorite;
  static const firebaseFavorites =
      "https://finalproject-cd0fe.firebaseio.com/favorites.json";

  Favoriteproduct({
    this.id,
    this.productId,
    this.productName,
    this.imageUrl,
    this.description,
    this.isFavorite,
    this.price,
    this.rate,
    this.fave,
    this.comment,
  });

  Favoriteproduct.map(dynamic obj) {
    this.id = obj['id'];
    this.productId = obj['productId'];
    this.productName = obj['productName'];
    this.imageUrl = obj['imageUrl'];
  }

  Favoriteproduct.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    productId = snapshot.value['productId'];
    productName = snapshot.value['productName'];
    imageUrl = snapshot.value['name'];
  }
}

Service service = Service();

class Favorites with ChangeNotifier {
  Favoriteproduct favoriteproduct = Favoriteproduct();
  List<Favoriteproduct> _items = [];
  //Map<String, Favoriteproduct> _items = {};

  // Map<String, Favoriteproduct> get items {
  //   return {..._items};
  // }
  List<Favoriteproduct> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }
    // User user = User();
    //  dbRef.orderByChild("userId").equalTo(user.uId).once().then((DataSnapshot snapshot) {
    //   _items.add(snapshot.value["productId"]) ;
    // });

    return [..._items];
  }

  Favoriteproduct findById(String id) {
    return _items.firstWhere((fav) => fav.id == id);
  }

  int get itemCount {
    return _items.length;
  }

  // Future deleteFavorite(key) async {
  //   await dbRef.child(key).remove();
  //   return;
  // }
  //List<dynamic> productId=List<dynamic>();
  Future<List> getProductId(String id) async {
    dbRef
        .orderByChild("userId")
        .equalTo(id)
        .once()
        .then((DataSnapshot snapshot) {
      _items.add(snapshot.value["productId"]);
    });
    int a = _items.length;
    return [..._items];
  }
// Future<void> fetcAndSetProducts() async {
//     var user = await _auth.user.first;
//     String userId=user.uId;
//     String id=favoriteproduct.id;

//     // final url = 'https://finalproject-cd0fe.firebaseio.com/favorites/$userId.json.json';
//     //  try {
//     //   final response = await http.get(url);
//     //   final extractedData = json.decode(response.body) as Map<dynamic, dynamic>;
//     //   final List<Product> loadedProducts = [];
//     //   extractedData.forEach((id, prodData) {
//     //     loadedProducts.add(Product(
//     //       id: id,
//     //       rate: prodData['rate'],
//     //       name: prodData['productName'],
//     //       imageUrl: prodData['imageUrl'],
//     //       isFavorite:
//     //           favoriteData == null ? false : favoriteData[prodId] ?? false,
//     //     ));
//     //   });
//     //   _items = loadedProducts;
//     //   notifyListeners();
//     // } catch (error) {

//     // }

//   }

  Future<void> fetcAndSetFav() async {
    var user = await _auth.user.first;
    String userId = user.uId;
    Product product = Product();
    String id = product.id;
    final url =
        'https://finalproject-cd0fe.firebaseio.com/favorites/$userId.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Favoriteproduct> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Favoriteproduct(
          id: prodData['productId'],
          productName: prodData['productName'],
          description: prodData['description'],
          price: prodData['price'],
          rate: prodData['rate'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
         
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {}
  }

  //double get  totalAmo

  // void addItem(String< productId,String productName, String imageUrl){
  //   if(_items.containsKey(productId)){
  //     _items.update(productId, (existingFavoriteproduct) => Favoriteproduct(id: existingFavoriteproduct.id,productName: existingFavoriteproduct.productName,imageUrl: existingFavoriteproduct.imageUrl));

  //   }else{
  //     _items.putIfAbsent(productId, ()=>Favoriteproduct(id: DateTime.now().toString(),productName: productName,imageUrl: imageUrl),);
  //   } notifyListeners();
  // }

  // void removeItem(String id) {
  //   //_items.remove(productId);
  //   service.deleteFavorite(id);
  //   notifyListeners();
  // }
}
