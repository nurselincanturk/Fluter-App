import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:final_project/services/products_provider.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  final bool showFaves;
  ProductsGrid(this.showFaves);

  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final products =
        showFaves ? productsData.favoriteItems : productsData.items;
    return GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: products.length,
      
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              //create: (c) => products[i],
              value: products[i],
              child: ProductItem(
                  //products[i].id, products[i].name, products[i].imageUrl
                  ),
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: .95,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
            );
  }
}
