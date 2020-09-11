import 'package:final_project/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/favorites.dart';
import 'package:final_project/services/service.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/models/user.dart';
import 'package:firebase_database/firebase_database.dart';

class FavoritesItem extends StatelessWidget {
  // final String id;
  // final String productId;
  // final String productName;
  // final String imageUrl;FavoritesItem(this.id, this.productId, this.productName, this.imageUrl);
  //  FavoritesItem(this.id,
  // this.productId, this.productName, this.imageUrl
  //  );
  //Favoriteproduct product;
  Service service = Service();
  Favorites faves = Favorites();
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Favorites>(context).fetcAndSetFav();
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Favoriteproduct>(context);
    //final user = Provider.of<User>(context);

    return Dismissible(
      key: Key(product.id),
      background: Container(
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
          size: 50,
        ),
      ),
      onDismissed: (direction) {
        // FirebaseDatabase.instance
        //     .reference()
        //     .child('favorites')
        //     .child(user.uId)
        //     .child(product.id)
        //     .remove();
        service.deleteFavorite(product.id);
      },
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.routeName, arguments: product.id);
        },
        child: Container(
          decoration: new BoxDecoration(
            boxShadow: [
              BoxShadow(
              color: Color.fromARGB(150, 58, 60, 94).withOpacity(.5),
                blurRadius: 20.0, // soften the shadow
                spreadRadius: 0.0, //extend the shadow
                offset: Offset(
                  5.0, // Move to right 10  horizontally
                  5.0, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Card(
              shadowColor: getColorFromHex('#3a3c5e'),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      // padding: EdgeInsets.only(left: 80),
                      height: 180,
                      width: 160,
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      ),
                    ),
                    Container(
                        width: 120,
                        child: Text(
                          product.productName,
                        )),
                    // Container(color: getColorFromHex('#3a3c5e'),width: 100,height: 170,

                    //  child:IconButton(color: (Colors.white),
                    //       icon: Icon(Icons.delete),
                    //       onPressed: () {
                    //         // print(user.uId);
                    //         // print(product.id);
                    //        // service.deleteFavorite(user.uId, product.productId);
                    //         FirebaseDatabase.instance
                    //             .reference()
                    //             .child('favorites')
                    //             .child(user.uId)
                    //             .child(product.id)
                    //             .remove();
                    //            //.then((value) => Navigator.pushNamed(context, "/navigationMain")
                    //         //   );
                    //       }),)
                  ])),
        ),
      ),
    );
//         GridTile(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
//                   arguments: product.id);
//             },
//             child: Image.network(
//               product.imageUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//           footer: GridTileBar(
//             backgroundColor: Colors.black54,
// //             leading:Consumer<Product>(
// //       builder: (ctx, product, child) => IconButton(
// //                 icon: Icon(product.isFavorite
// //                     ? Icons.favorite
// //                     : Icons.favorite_border),
// //                 color: Theme.of(context).accentColor,
// //                 onPressed: () {
// // //                  service.addFavorite(product.id, product.name, product.description, product.imageUrl);
// //                   //product.toggleFavoriteStatus(user.uId);
// //                  // favorites.addItem(product.id,product.name,product.imageUrl );
// //                 }),),
//             title: Text(
//               product.productName,
//               textAlign: TextAlign.center,
//             ),
//            // trailing: IconButton(icon: Icon(Icons.favorite), onPressed: (){ favorites.addItem(product.id,product.imageUrl,product.name );}),
//           ),
//         ),
    //);
  }

  Color getColorFromHex(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
