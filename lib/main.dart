import 'package:final_project/models/favorites.dart';
import 'package:final_project/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/products_provider.dart';
import 'models/favorites.dart';
import 'screens/wrapper.dart';
import 'models/user.dart';
import 'services/database.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(value: AuthService().user,
          child: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: ProductsProvider(),
          ),
          ChangeNotifierProvider.value(
            value: Favorites(),
          ),
           ChangeNotifierProvider.value(
            value: DatabaseService(),
          ),
        ],
        child: MaterialApp(
          home: Wrapper(),
          // routes: {
          //   "/profil": (context) => ProductDetailScreen(),
          //   ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          //   ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          //   UserProfile.routeName: (ctx) => UserProfile(),
          //   SignIn.routeName: (ctx) => SignIn(),
          //   Register.routeName: (ctx) => Register(),
          //   FavoritesScreen.routeName: (ctx) => FavoritesScreen(),
          //   EditProductScreen.routeName: (ctx) => EditProductScreen(),
          //   Home.routeName: (ctx) => Home(),
          // },
        ),
      ),
    );
  }
}
