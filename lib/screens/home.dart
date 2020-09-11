import 'package:flutter/material.dart';
import 'package:final_project/services/auth.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/models/user.dart';
import 'products_overview_screen.dart';
import 'UserProfileScreen.dart';
//TO DO NAVİGASYON DÜZELT

class Home extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
 var _isInit = true;  var _isLoading = false;
  DatabaseService dbService = DatabaseService();
      int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
 @override
  void initState() {
    // Provider.of<ProductsProvider<>(context).fetcAndSetProducts(); çalışmaz
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
    final productsData = Provider.of<ProductsProvider>(context);
    final products = productsData.items;
    final user = Provider.of<User>(context, listen: false);
final List<Widget> _children = [
      ProductDetailScreen(),
      ProductsOverviewScreen(),
      UserProfileScreen(),
    ];

    dbService.getUser(user.name);
    return MaterialApp(
      home: Scaffold(
         appBar: AppBar(
            backgroundColor: getColorFromHex('#3a3c5e'), title: Text("app")),
        drawer: DrawerAll(context),
          body: 
          SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  height: 45,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 8,
                          ),
                          color: getColorFromHex('#F2F4F6'),
                        ),
                        child: Text("MEN",
                            style:
                                TextStyle(color: getColorFromHex('#3a3c5e'))),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 3,
                        margin: const EdgeInsets.only(right: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: getColorFromHex('9ea0c3'),
                        ),
                        child: Text("KADIN"),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                        ),
                        child: Text("ÇOCUK"),
                      ),
                    ],
                  ),
                ),
                      SizedBox(height: 7.5),
                      // CarouselProductsList(
                      //   productsList: H,
                      //   type: CarouselTypes.home,
                      // ),
                SizedBox(height: 7.5),
                Text(
                  "Çok Satanlar",
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductDetailScreen.routeName,
                              arguments: products[i].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9.0),
                              child: Image.network(
                                "${products[i].imageUrl}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Text(
                  "En Çok Favorilenenler",
                  style: Theme.of(context).textTheme.title,
                ),
                Container(
                  height: 150,
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => ProductDetailScreen(),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 9.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9.0),
                              child: Image.network("${products[i].imageUrl}"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
         
           
          ),
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
