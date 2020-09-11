import 'package:flutter/material.dart';
import 'package:final_project/widgets/products_grid.dart';
import 'package:final_project/widgets/badge.dart';
import 'package:provider/provider.dart';
import 'package:final_project/models/favorites.dart';
import 'package:final_project/screens/favorites_screen.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:final_project/widgets/drawer.dart';

enum FilterOptions {
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  static const routeName = '/product-overview';
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
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
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(
            backgroundColor: getColorFromHex('#3a3c5e'), title: Text("")),
        drawer: DrawerAll(context),
      backgroundColor: getColorFromHex('faf9f9'),
      // appBar: AppBar(
      //   backgroundColor:getColorFromHex('#3a3c5e'),
      //   brightness: Brightness.dark,
      //   title: const Text('Home'),
      //   actions: <Widget>[
         
      //     PopupMenuButton(
      //       onSelected: (FilterOptions selectedValue) {
      //         setState(() {
      //           if (selectedValue == FilterOptions.Favorites) {
      //             _showOnlyFavorites = true;
      //           } else {
      //             _showOnlyFavorites = false;
      //           }
      //         });
      //       },
      //       icon: Icon(
      //         Icons.more_vert,
      //       ),
      //       itemBuilder: (_) => [
      //         PopupMenuItem(
      //             child: Text('Favoriler'), value: FilterOptions.Favorites),
      //         PopupMenuItem(
      //             child: Text('Tümünü göster'), value: FilterOptions.All),
      //       ],
      //     ),
      //     Consumer<Favorites>(
      //       builder: (_, favorites, ch) => Badge(
      //         child: ch,
      //         value: favorites.itemCount.toString(),
      //       ),
      //       child: IconButton(
      //         icon: Icon(Icons.favorite),
      //         onPressed: () {
      //           Navigator.of(context).pushNamed(FavoritesScreen.routeName);
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
                  bottomNavigationBar: BottomNav(context),

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
