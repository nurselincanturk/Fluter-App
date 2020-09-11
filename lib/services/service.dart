import 'dart:convert';
import 'package:final_project/models/brands.dart';
import 'package:final_project/models/category.dart';
import 'package:final_project/models/favorites.dart';
import 'package:final_project/models/prices.dart' as p;
import 'package:final_project/models/user.dart';
import 'package:final_project/models/store.dart';
import 'package:final_project/models/comment.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/services/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';

class Service extends ChangeNotifier {
  AuthService _auth = AuthService();
  DatabaseService service = DatabaseService();
  static const firebaseComments =
      "https://finalproject-cd0fe.firebaseio.com/comments.json";
static const firebaseStores =
      "https://finalproject-cd0fe.firebaseio.com/stores.json";
  static const firebaseFavorites =
      "https://finalproject-cd0fe.firebaseio.com/favorites.json";
  static const firebaseCategory =
      "https://finalproject-cd0fe.firebaseio.com/categories.json";
  static const firebaseProducts =
      "https://finalproject-cd0fe.firebaseio.com/products.json";
  static const firebaseUser =
      "https://finalproject-cd0fe.firebaseio.com/users.json";
  static const googleAPI = "AIzaSyAiAT5afkZBrwKOd7qf9k39DIBak-6vG_o";
  static const firebaseSignin =
      "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBXOkZo0q591PQmGSNQzzbuXHvZjKtY3PY";
  static const firebaseSignup =
      "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBXOkZo0q591PQmGSNQzzbuXHvZjKtY3PY";
  static const firebaseUserr =
      "https://finalproject-cd0fe.firebaseio.com/users.json";
       static const firebaseTartisma =
      "https://finalproject-cd0fe.firebaseio.com/tartisma.json";
      static const firebaseTartismabaslik =
      "https://finalproject-cd0fe.firebaseio.com/tartismabaslik.json";
  List<Product> _productList = [];
  List<Category> _categoryList = [];
  List<dynamic> _foodIdList = [];

  //final notesReference = FirebaseDatabase.instance.reference();
  final storesReference = FirebaseDatabase.instance.reference().child('stores');
  final productsReference =
      FirebaseDatabase.instance.reference().child('products');
  var _firebaseRef = FirebaseDatabase().reference().child('products');
  var _firebaseRef2 = FirebaseDatabase().reference().child('favorites');
  var _firebaseUsers = FirebaseDatabase().reference();
  var _firebase = FirebaseDatabase().reference();

  // List<Place> get places {
  //   // if (_showFavoritesOnly) {
  //   //   return _items.where((prodItem) => prodItem.isFavorite).toList();
  //   // }
  //   return [..._placeList];
  // }
  updateRates(key, String rate) {
    _firebaseRef.child(key).update({"rate": rate});
  }
   updateCommentCount(key, String comment) {
    _firebaseRef.child(key).update({"comment": comment});
  }
  String fave1;
  int fave2=0;
 updateFavCount(key, String fave) {
     if (fave == null) {
                  fave1 = fave2.toStringAsFixed(0);
                } else {
                  fave2 = (((int.parse(fave)) + 1));
                  fave1 = fave2.toStringAsFixed(0);
                }
    _firebaseRef.child(key).update({"fave": fave1});
  }
  Future deleteFavorite(String productId) async {
    var user = await _auth.user.first;
    String userId=user.uId;
    FirebaseDatabase.instance
        .reference()
        .child('favorites')
        .child(userId)
        .child(productId)
        .remove()
        ;
//    final dbfav = FirebaseDatabase.instance.reference().child('favorites/$userId');
//  await dbfav.child(productId).remove();
    return;
  }

  List<String> get foodIdList {
    return [..._foodIdList];
  }

// List<Product> get product(){
//   return _productList;
// }
  List<Category> get categories {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._categoryList];
  }

  String add(double rate, double rate2) {
    rate = (rate + rate2) / 2;
    return rate.toStringAsFixed(1);
  }

  Future addFavorite(String productId, String productName, String description,
      String imageUrl) async {
    var user = await _auth.user.first;
    await http.post(
      firebaseFavorites,
      body: json.encode({
        'productId': productId,
        'userId': user.uId,
        "productName": productName,
        "description": description,
        "imageUrl": imageUrl,
      }),
    ); //final jsonModel = json.decode(response.body) as Map<String, dynamic>;

//      if(pMap!= null){
//     try {
//       service.dbRef.child("favorites").child(jsonModel.values.first).set({
//         "productName":pMap['name'],
//         "description":pMap['description'],
//         "imageUrl":pMap['imageUrl'],
//         "price":pMap['price']

//       });
//     } catch (e) {
//       print(e.toString());
//     }
// }
  }

  Future updateRate(String description, String price, String imageUrl,
      String productId, String name, String rate) async {
    //    var pmap = await service.fillProductInfoInComment(productId);
    //Product product=service.getProduct(productId);

    if (productId != null) {
      productsReference.child("products").set({
        'name': name,
        'description': description,
        'price': price,
        'rate': rate,
        'imageUrl': imageUrl
      });
    }
  }

  Future addRate(String productId, String rate) async {
    final response = await http.post(
      firebaseProducts,
      body: json.encode({
        'rate': rate,
      }),
    );
    final jsonModel = json.decode(response.body) as Map<String, dynamic>;

    var userMap = await service.fillProductInfoInComment(productId);
    if (userMap != null) {
      try {
        service.dbRef
            .child("products")
            .child(jsonModel.values.first)
            .child("products")
            .set({
          "name": userMap["name"],
          "description": userMap["description"],
          "imageUrl": userMap["imageUrl"],
          "price": userMap["price"],
        });
      } catch (e) {
        print(e.toString());
      }
    }
  }

  Future addComment(String productId, String comment, String rate) async {
    var user = await _auth.user.first;
    await http.post(
      firebaseComments,
      body: json.encode({
        'comment': comment,
        'date': DateTime.now().toIso8601String(),
        'rate': rate,
        'productId': productId,
        'userId': user.uId
      }),
    );

    //  final jsonModel = json.decode(response.body) as Map<String, dynamic>;
    //Kullanıcı bilgisi çekiliyor ve aynı yoruma yükleniyor.
    //  var userMap = await service.fillUserInfoInComment(user.uId);
    // if (userMap != null) {
    //   try {
    //     service.dbRef
    //         .child("comments")
    //         .child(jsonModel.values.first)
    //         .child("user")
    //         .set({
    //       "userId": user.uId,
    //       "name": userMap["name"],
    //       "lastname": userMap["lastname"],
    //       "UserImageUrl": userMap["imageUrl"]
    //     });
    //   } catch (e) {
    //     print(e.toString());
    //   }
    // }

    //  var productName=await service.fillProductInfoInComment(productId);
    // try {
    //   service.dbRef.child("comments").child(jsonModel.values.first).set({
    //     "productId":productId,
    //   });
    // } catch (e) {
    //   print(e.toString());
    // }

    // var brandName= await service.fillBrandInfoInComment(brandId);
    // try {
    //   service.dbRef.child("comments").child(jsonModel.values.first).child("brands").set({
    //     "brandId":brandId,
    //     "brandName":brandName,

    //   });
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  // Future getFoodIds(String categoryId) async {
  //   List<Place> tempList = [];
  //   List<PlaceFood> gosterilecekYemekler = [];
  //   List<dynamic> kategori = [];
  //   final response = await http.get(firebaseFood);
  //   try {
  //     _foodIdList = [];
  //     final jsonModel = json.decode(response.body) as Map<String, dynamic>;
  //     jsonModel.forEach((k, v) {
  //       kategori = v['category'];
  //       if (kategori.contains(categoryId)) {
  //         _foodIdList.add(k);
  //       }
  //     });
  //   } catch (e) {
  //     Future.error(e);
  //   }

  //   tempList = await getPlaces();
  //   tempList.forEach((place) {
  //     place.menu.forEach((k,v){
  //       PlaceFood food= PlaceFood();
  //       if(foodIdList.contains(k)){
  //         food.foodId =k;
  //         food.foodRating = v['foodRat'];
  //         food.foodName=v["foodName"];
  //         food.placeId = place.id;
  //         food.placeTitle=place.title;
  //         gosterilecekYemekler.add(food);
  //       }
  //     });
  //   });
  //   return gosterilecekYemekler;
  // }
  List<User> _items = [];
  List<User> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }

    return [..._items];
  }
  // Future getPlaces() async {
  //   final response = await http.get(firebasePlaces);
  //   try {
  //     _placeList = [];
  //     final jsonModel = json.decode(response.body) as Map<String, dynamic>;
  //     jsonModel.forEach((k, v) {
  //       Place place = Place();
  //       place.id = k;
  //       place.title = v['title'];
  //       place.lat = v['lat'];
  //       place.lng = v['lng'];
  //       place.imageUrl = v['imageUrl'];
  //       place.menu = v['menu'];
  //       _placeList.add(place);
  //     });
  //     return places;
  //   } catch (e) {
  //     Future.error(response.statusCode);
  //   }
  // }

  // Future addPlace(Place place) async {
  //   try {
  //     await http.post(
  //       firebasePlaces,
  //       body: json.encode({
  //         'title': place.title,
  //         'imageUrl': place.imageUrl,
  //         'lat': place.lat,
  //         'lng': place.lng,
  //         'menu': place.menu
  //       }),
  //     );
  //   } catch (error) {
  //     print(error);
  //     throw error;
  //   }
  // }

  // Future getCategories() async {
  //   final response = await http.get(firebaseCategories);
  //   try {
  //     _categoryList = [];
  //     final jsonModel = json.decode(response.body) as Map<String, dynamic>;
  //     jsonModel.forEach((k, v) {
  //       final Category newCategory = Category();
  //       newCategory.catId = k;
  //       newCategory.catName = v['catName'];
  //       _categoryList.add(newCategory);
  //     });
  //     return categories;
  //   } catch (e) {
  //     Future.error(response.statusCode);
  //   }
  // }

  // List<f.Food> allFoods = [];
  // Future getFoods() async {
  //   final response = await http.get(firebaseFood);
  //   List<dynamic> category = [];
  //   try {
  //     allFoods = [];
  //     final jsonModel = json.decode(response.body) as Map<String, dynamic>;
  //     jsonModel.forEach((k, v) {
  //       final f.Food newFood = f.Food();
  //       newFood.id = k;
  //       newFood.title = v['title'];
  //       category = v['category'];
  //       newFood.category = [];
  //       for (var i = 0; i < category.length; i++) {
  //         newFood.category.add(category[i].toString());
  //       }

  //       allFoods.add(newFood);
  //     });
  //     return allFoods;
  //   } catch (e) {
  //     Future.error(e);
  //   }
  // }
  
  
    User getUser(String uid) {
    User user = User();
    _firebaseUsers.child("users/$uid").once().then((DataSnapshot snapshot) {
      user.name = snapshot.value["name"];
      user.lastname=snapshot.value["lastname"];
    });
    return user;
  }
Future userInfo
()async{
 User user = User();
  var  userr = await _auth.user.first;
  String uid=userr.uId;
        
    dbRef.child("users/$uid").once().then((DataSnapshot snapshot) {
      user.name = snapshot.value["name"];
      user.lastname=snapshot.value["lastname"];
    });

   return user;
}

 //   service.dbRef.child("comments").child(jsonModel.values.first).child("brands").set({
    //     "brandId":brandId,
    //     "brandName":brandName,

  Future addCategory(String catName) async {
    await http.post(firebaseCategory, body: json.encode({'catName': catName}));
  }
Future addTartisma(String tartisma,String yorum) async {
    await http.post(firebaseTartisma, body: json.encode({'konu': tartisma,'yorum':yorum}));
    
    //await http.post(_firebase.child('tartisma').child('yorumlar'), body: json.encode({yorum}));
  }
  Future baslikTartisma(String tartisma) async {
    await http.post(firebaseTartismabaslik, body: json.encode({'konu': tartisma}));
    
    //await http.post(_firebase.child('tartisma').child('yorumlar'), body: json.encode({yorum}));
  }
  // Future Tartisma(String tartisma,String yorum) async {
  //   await http.post(firebaseTartisma, body: json.encode({'konu': tartisma,'yorum':yorum}));
    
  //   //await http.post(_firebase.child('tartisma').child('yorumlar'), body: json.encode({yorum}));
  // }
  // Future addTartismaYorum(String tartisma,String yorum) async {
  // _firebase.child('tartisma').orderByChild('konu').equalTo(value)
  // }
Future addStore(Store place) async {
    try {
      await http.post(
        firebaseStores,
        body: json.encode({
          'name': place.name,
          'lat': place.lat,
          'lng': place.lng,
        }),
      );
    } catch (error) {
      print(error);
      throw error;
    }
  }
  Future addFavorites(String userId, String productId) async {
    await http.post(firebaseFavorites,
        body: json.encode({'userId': userId, 'productId': productId}));
  }

  Future<Product> findById(String id) async {
    Product pl = Product();
    final response = await http.get(firebaseProducts);
    try {
      final jsonModel = json.decode(response.body) as Map<String, dynamic>;
      jsonModel.forEach((k, v) {
        Product product = Product();
        product.id = k;
        product.name = v['name'];
        product.description = v['description'];
        product.price = v['price'];
        product.imageUrl = v['imageUrl'];
        _productList.add(product);
        if (k == id) {
          pl = product;
        }
      });
    } catch (e) {
      Future.error(response.statusCode);
    }
    return pl;
  }
}
