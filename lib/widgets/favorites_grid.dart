import 'package:final_project/widgets/favorites_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/user.dart';

import 'package:final_project/services/products_provider.dart';
import './product_item.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/favorites.dart';
import 'package:final_project/services/service.dart';
import 'package:final_project/models/product.dart';

class FavoritesGrid extends StatelessWidget {
  // @override
  // final bool showFaves;
  // FavoritesGrid(this.showFaves);
  

    Widget build(BuildContext context) {
    final productsData = Provider.of<Favorites>(context);
    final products =
         productsData.items;
    return ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
      
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              //create: (c) => products[i],
              value: products[i],
              child: FavoritesItem(
                  //products[i].id, products[i].name, products[i].imageUrl
                  ),
            ),
          //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // crossAxisCount: 1,
          // childAspectRatio: .95,
          // crossAxisSpacing: 15,
          // mainAxisSpacing: 15,
      //  ),
            );
  }

}
