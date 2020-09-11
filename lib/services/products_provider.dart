import 'dart:math';

import 'package:firebase_database/ui/firebase_sorted_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:final_project/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:final_project/services/auth.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

//var _showFavoritesOnly=false;
  AuthService _auth = AuthService();

  List<Product> get items {
    // if(_showFavoritesOnly){
    //   return _items.where((prodItem)=>prodItem.isFavorite).toList();
    // }

    return [..._items];
  }

  int uzunluk() {
    return _items.length;
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }
 List<Product> get faveItems {
    return _items.where((element) => false);
  }
  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }
List<Product> findByCat(String cat) {
    return _items.where((prod) => prod.category == cat).toList();
  }

// void showFavoritesOnly(){
//   _showFavoritesOnly=true;

// }
// void showAll(){
//   _showFavoritesOnly=false;
//   notifyListeners();
// }

  Future<void> fetcAndSetProducts() async {
    const url = 'https://finalproject-cd0fe.firebaseio.com/products.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodId,
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          rate: prodData['rate'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],
         
          comment: prodData['comment'],
          fave: prodData['fave'],
         category:prodData['category']  
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      
    }
  }

  Future<void> fetcAndSetFav() async {
     var user = await _auth.user.first;
     String userId=user.uId;
    Product product=Product();
    String id=product.id;
        final url = 
        'https://finalproject-cd0fe.firebaseio.com/favorites/$userId.json';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
          id: prodData['productId'],
          name: prodData['name'],
          description: prodData['description'],
          price: prodData['price'],
          rate: prodData['rate'],
          isFavorite: prodData['isFavorite'],
          imageUrl: prodData['imageUrl'],   comment: prodData['comment'],
          fave: prodData['fave'],
         category:prodData['category']  
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      
    }
    
  }

  Future<void> addProduct(Product product) async {
    const url = 'https://finalproject-cd0fe.firebaseio.com/products.json';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'name': product.name,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
          'category':product.category
        }),
      );
      final newProduct = Product(
        name: product.name,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        category: product.category,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://finalproject-cd0fe.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'name': newProduct.name,
            'despriction': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price,
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
