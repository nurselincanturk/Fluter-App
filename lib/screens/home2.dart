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
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:final_project/models/favorites.dart';
//TO DO NAVİGASYON DÜZELT

class Home2 extends StatefulWidget {
  static const routeName = '/home2';

  @override
  _Home2State createState() => _Home2State();
}

class _Home2State extends State<Home2> {
  List lists = [];

  final AuthService _auth = AuthService();
  var _isInit = true;
  var _isLoading = false;
  DatabaseService dbService = DatabaseService();
  int _currentIndex = 0;

  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }

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
       Provider.of<Favorites>(context).fetcAndSetFav().then((_) {
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
      final productsData2 = Provider.of<Favorites>(context);
    final products2 =
         productsData2.items;
    final user = Provider.of<User>(context, listen: false);
    final List<Widget> _children = [
      ProductDetailScreen(),
      ProductsOverviewScreen(),
      UserProfileScreen(),
    ];
    final dbRef = FirebaseDatabase.instance.reference().child('products');
    final dbRef2 = FirebaseDatabase.instance.reference().child("products");
 // var  userr = await _auth.user.first;
    dbService.getUser(user.name);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
            backgroundColor: getColorFromHex('#3a3c5e'), title: Text("")),
        drawer: DrawerAll(context),
        body: SingleChildScrollView(
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
                          color: getColorFromHex('#4E517F'),
                          width: 8,
                        ),
                        color: getColorFromHex('#4E517F'),
                      ),
                      child: Text("Cilt Bakımı",
                          style: TextStyle(color: getColorFromHex('#C1C2D9'))),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: getColorFromHex('#4E517F'),
                      ),
                      child: Text("Makyaj",
                          style: TextStyle(color: getColorFromHex('#C1C2D9'))),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: getColorFromHex('#4A4D79'),
                      ),
                      child: Text("Kişisel Bakım",
                          style: TextStyle(color: getColorFromHex('#C1C2D9'))),
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
                "En Çok Yorumlananlar",
                style: Theme.of(context).textTheme.title,
              ),
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: getColorFromHex('#3a3c5e').withOpacity(.5),
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 15),
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments:products[i].id);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
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

              Text(
                "En Çok Favorilenenler",
                style: Theme.of(context).textTheme.title,
              ),
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: getColorFromHex('#3a3c5e').withOpacity(.5),
                      blurRadius: 20.0, // soften the shadow
                      spreadRadius: 0.0, //extend the shadow
                      offset: Offset(
                        5.0, // Move to right 10  horizontally
                        5.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ],
                ),
                height: 150,
                margin: const EdgeInsets.symmetric(vertical: 15),
               child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: products2.length,
                    itemBuilder: (ctx, i) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments:products[i].id);
                        },
                       child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9.0),
                              color: Colors.white,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(9.0),
                              child: Image.network("${products2[i].imageUrl}"),
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
        bottomNavigationBar: BottomNav(context),
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
