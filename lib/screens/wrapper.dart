import 'package:final_project/screens/addScreens/AddCategoryScreen.dart';
import 'package:final_project/screens/addScreens/addStoreScreen.dart';
import 'package:final_project/widgets/add_comment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'addScreens/addScreens.dart';
import 'package:final_project/screens/tartismaList.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/screens/tartismalar.dart';
import 'package:final_project/screens/favorites_screen.dart';
import 'package:final_project/screens/products_overview_screen.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/screens/home.dart';
import 'package:final_project/screens/edit_product_screen.dart';
import 'authenticate/LoginScreen.dart';
import 'package:final_project/screens/UserProfileScreen.dart';
import 'package:final_project/screens/productCatOverview.dart';
import 'package:final_project/widgets/mapWidget.dart';
import 'package:final_project/screens/home2.dart';
import 'package:final_project/screens/categories.dart';
import 'package:final_project/widgets/mapShowStore.dart';
import 'package:final_project/screens/tartismaEkle.dart';
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseService dbService = DatabaseService();
    final user = Provider.of<User>(context);
    return MaterialApp(
        title: 'app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          // accentColor: Colors.orange,
          cursorColor: Color.fromARGB(255, 66, 68, 107),

          //   fontFamily: 'OpenSans',
        ),
        home: user == null //kullanıcı auth değilse login'e
            ? AddScreens()
            : AddScreens(),
        // : (userMap["name"] == " " //burda servis çapırıp kullanıcı adı var mı yok mu kontrol etmek gerek
        //     ? GetUserInfoScreen()
        //     : NavigationScreen()), //InitialRoute tanımlanırsa Home tanımlanmaz.
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
     
         FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
          Home.routeName: (ctx) => Home(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          AddComment.routeName: (ctx) => AddComment(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          ProductsCatOverview.routeName: (ctx) => ProductsCatOverview(),
          Categories.routeName:(ctx)=>Categories(),
          //DrawerAll.routeName:(ctx)=>DrawerAll(),
       //   BottomNavigation.routeName:(ctx)=>BottomNavigation(),
          Home2.routeName:(ctx)=>Home2(),
          Tartismalar.routeName:(ctx)=>Tartismalar(),
          TartismaEkle.routeName:(ctx)=>TartismaEkle(),
          TartismaList.routeName:(ctx)=>TartismaList()
        //"/favoriler": (context) => FavoritesScreen(),

        });

// if(user == null){
//     return Authenticate();
// }else{
//   return Home();
// }
  }

  // Color getColorFromHex(String hexColor) {
  //   hexColor = hexColor.replaceAll("#", "");
  //   if (hexColor.length == 6) {
  //     hexColor = "FF" + hexColor;
  //   }
  //   if (hexColor.length == 8) {
  //     return Color(int.parse("0x$hexColor"));
  //   }
  // }
}
