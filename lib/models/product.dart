import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/services/service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';import 'package:final_project/services/auth.dart';


class Product with ChangeNotifier {
    Service service = Service();

   String id;
   String name;
   String description;
   double price;
   String imageUrl;
   String rate;
   String fave;
   String comment;
   String category;
  bool isFavorite;
    static const firebaseFavorites = "https://finalproject-cd0fe.firebaseio.com/favorites.json";

  Product(
      { this.id,
       this.name,
       this.description,
       this.price,
       this.imageUrl,
       this.rate,
       this.fave,this.comment,
       this.category,
      this.isFavorite = false});



  Product.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['title'];
    this.description=obj['description'];
    this.price = obj['price'];
    this.imageUrl = obj['imageUrl'];
    this.rate = obj['rate'];


  }


 
  Product.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    name = snapshot.value['name'];
    description = snapshot.value['description']; 
    price = snapshot.value['price'];  
    rate = snapshot.value['rate'];
    imageUrl = snapshot.value['name'];

  }
void _setFavValue(bool newValue){
  isFavorite=newValue;
  notifyListeners();
}  AuthService _auth = AuthService();

  Future<void> toggleFavoriteStatus() async {
    // final oldStatus = isFavorite;
    // isFavorite = !isFavorite;
     //service.addFavorite(productId, name, description, imageUrl);

   // service.addFavorite(productId);
    // notifyListeners();
    var user = await _auth.user.first;
    String userId=user.uId;
final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://finalproject-cd0fe.firebaseio.com/favorites/$userId/$id.json';
    try {
      final response = await http.put(
        url,
        body: json.encode({
          "productId":id,
          "isFavorite":isFavorite,
          "description":description,
          "imageUrl":imageUrl,
          "productName":name,
          "rate":rate,
          "price":price
        }
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
 //service.updateFavCount(productId, fave);
  // await http.post(firebaseFavorites,
  //       body: json.encode({'userId': userId,'productId':productId}));
  }
}
