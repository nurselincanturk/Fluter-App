import 'package:final_project/models/favorites.dart';
import 'package:final_project/models/product.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/service.dart';
import 'package:final_project/models/user.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;
  // ProductItem(this.id, this.title, this.imageUrl);
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context,
        listen: false); //final user = Provider.of<User>(context);
    //  final favorites=Provider.of<Favorites>(context,listen: false);
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(decoration: new BoxDecoration(
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
                child: GridTile(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                    arguments: product.id);
              },
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: Consumer<Product>(
                builder: (ctx, product, child) => IconButton(
                    icon: Icon(product.isFavorite
                        ? Icons.favorite
                        : Icons.favorite_border),
                    color: Theme.of(context).accentColor,
                    onPressed: () {
//                  service.addFavorite(product.id, product.name, product.description, product.imageUrl);
                      product.toggleFavoriteStatus();
                      service.updateFavCount(product.id, product.fave);
                      //  print(user.uId);
                      // favorites.addItem(product.id,product.name,product.imageUrl );
                    }),
              ),
              title: Text(
                product.name,
                textAlign: TextAlign.center,
              ),
              // trailing: IconButton(icon: Icon(Icons.favorite), onPressed: (){ favorites.addItem(product.id,product.imageUrl,product.name );}),
            ),
          ),
        ),
      ),
    );
  }
}
