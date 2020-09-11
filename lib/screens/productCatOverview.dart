import 'package:flutter/material.dart';
import 'package:final_project/widgets/products_grid.dart';
import 'package:final_project/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/screens/product_detail_screen.dart';

import 'package:final_project/models/favorites.dart';
import 'package:final_project/screens/favorites_screen.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/widgets/product_item.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:final_project/widgets/drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsCatOverview extends StatefulWidget {
static const routeName = '/product-overview2';
  

  @override
  _ProductsCatOverviewState createState() => _ProductsCatOverviewState();
}

class _ProductsCatOverviewState extends State<ProductsCatOverview > {
  var _showOnlyFavorites = false;

  var _isInit = true;

  var _isLoading = false;

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

      Provider.of<ProductsProvider>(context).fetcAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) { //final product = Provider.of<Product>(context,listen: false);  
  final productCat = ModalRoute.of(context).settings.arguments as String;
    final productsData = Provider.of<ProductsProvider>(context).findByCat(productCat);
    // final products =
    //     productsData.items;
    return Scaffold(
      backgroundColor: getColorFromHex('faf9f9'),
        appBar: AppBar(
            backgroundColor: getColorFromHex('#3a3c5e'), title: Text("")),
        drawer: DrawerAll(context),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: productsData.length,
      
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              //create: (c) => products[i],
              value: productsData[i],
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
            ),        bottomNavigationBar: BottomNav(context),

    );
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
