import 'package:final_project/models/product.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/widgets/favorites_item.dart';
import 'package:flutter/material.dart';
import 'package:final_project/models/favorites.dart';
import 'package:provider/provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/widgets/favorites_grid.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:final_project/widgets/drawer.dart';
class FavoritesScreen extends StatefulWidget {
  static const routeName = '/favoriler';

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  var _isInit = true;
  Favoriteproduct faves = Favoriteproduct();

  var _isLoading = false;

  List lists = [];

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Favorites>(context).fetcAndSetFav();
  }

  @override
  void initState() {
    // Provider.of<ProductsProvider>(context).fetcAndSetProducts(); çalışmaz
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Favorites>(context).fetcAndSetFav().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  String id;
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    String userId = user.uId;
    final dbRef =
        FirebaseDatabase.instance.reference().child('favorites/$userId');

    //final favorites = Provider.of<Favorites>(context, listen: false);
    // final product = Provider.of<Product>(context,listen: false);
    return Scaffold(
        appBar: AppBar(
            backgroundColor: getColorFromHex('#3a3c5e'), title: Text("Favorilerim")),
        drawer: DrawerAll(context),
        //  body:
        body:  RefreshIndicator(
            onRefresh: () => _refreshProducts(context),
             child:_isLoading
          ? Center(child: CircularProgressIndicator())
          : FavoritesGrid(),
//             FutureBuilder(
//                 future: dbRef.once(),
//                 builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                   if (snapshot.hasData) {
//                     lists.clear();
//                     Map<dynamic, dynamic> values = snapshot.data.value;
//                     values.forEach((key, values) {
//                       lists.add(values);
//                     });
//                     // return FavoritesGrid();
//                     return new ListView.builder(
//                         shrinkWrap: true,
//                         itemCount: lists.length,
//                         itemBuilder: (BuildContext context, int index) {
//                           return //FavoritesItem(lists[index]["id"], lists[index]["productId"], lists[index]["productName"], lists[index]["imageUrl"]);

//                               Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15.0),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: <Widget>[
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(10),
//                                   child: GridTile(
//                                     child: GestureDetector(
//                                         onTap: () {
//                                           // FirebaseDatabase.instance
//                                           //     .reference()
//                                           //     .child('favorites')
//                                           //     .child(user.uId)
//                                           //     .child(lists[index]["productId"])
//                                           //     .remove()
//                                           //     .then((value) =>
//                                           //         Navigator.of(context).pop());
//                                           Navigator.of(context).pushNamed(
//                                               ProductDetailScreen.routeName,
//                                               arguments: lists[index]
//                                                   ["productId"]);
//                                           // service.deleteFavorite(user.uId, lists[index]["id"]);
//                                           // Navigator.of(context).pushNamed(
//                                           //     ProductDetailScreen.routeName,
//                                           //     arguments: lists[index]
//                                           //         ["productId"]);
//                                         },
//                                         child: Row(children: <Widget>[
//                                           Image.network(
//                                             lists[index]["imageUrl"],
//                                             height: 100.0, width: 100.0,
//                                             // fit: BoxFit.cover,
//                                           ),
//                                           IconButton(
//                                               icon: Icon(Icons.delete),
//                                               onPressed: () {
//                                                 FirebaseDatabase.instance
//                                                     .reference()
//                                                     .child('favorites')
//                                                     .child(user.uId)
//                                                     .child(lists[index]
//                                                         ["productId"])
//                                                     .remove()
//                                                     .then((value) =>
//                                                         Navigator.of(context)
//                                                             .pop());
//                                               })
//                                         ])
//                                         //

//                                         ),
// // // //
//                                   ),
//                                 )
//                                 //   Row(children: <Widget>[
//                                 //   Image.network(lists[index]["imageUrl"],fit: BoxFit.cover,),
//                                 //   Text(lists[index]["productName"]),
//                                 // ],)

//                                 // ListTile(
//                                 //   leading: Icon(Icons.add_comment),
//                                 //   title: Text(lists[index]["productName"]),
//                                 // )
//                               ],
//                             ),
//                           );
//                         });
//                   }
//                   return CircularProgressIndicator();
//                 })
        ),        bottomNavigationBar: BottomNav(context),

        );
  } Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceAll("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}
}
