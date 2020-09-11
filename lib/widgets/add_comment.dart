import 'package:flutter/material.dart';
import 'package:final_project/services/service.dart';
import 'package:final_project/models/product.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/screens/product_detail_screen.dart';

class AddComment extends StatefulWidget {
  static const routeName = '/comment';
  //final  productId;

  // final String brandId;
  // AddComment({this.productId});
  @override
  _AddCommentState createState() => _AddCommentState();
}

String rate;
String comment;
class _AddCommentState extends State<AddComment> {
  double rating = 7.0;
  int commentC = 0;

  Service service = Service();
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);

    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text("Puan"),
            Slider(
              onChanged: (newRating) {
                setState(() {
                  rating = newRating;
                });
              },
              value: rating,
              label: rating.toStringAsFixed(1),
              divisions: 100,
              max: 10,
              min: 0,
              activeColor: rating > 7
                  ? Colors.green[400]
                  : (rating > 5 ? Colors.orange[200] : Colors.red[400]),
            ),
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                  labelText: "Yorum(isteğe bağlı)",
                  labelStyle: TextStyle(color: Colors.black54),
                  border: OutlineInputBorder()),
            ),
            RaisedButton(
              onPressed: () {
                service.addComment(productId, commentController.text,
                    rating.toStringAsFixed(1));
                if (loadedProduct.rate == null) {
                  rate = rating.toStringAsFixed(1);
                } else {
                  rating = (((double.parse(loadedProduct.rate)) + rating) / 2);
                  rate = rating.toStringAsFixed(1);
                }

                service.updateRates(loadedProduct.id, rate);
                 if (loadedProduct.comment == null) {
                  comment = commentC.toString();
                } else {
                  commentC =((int.parse(loadedProduct.comment)) + 1);
                  comment = commentC.toString();
                }
                service.updateCommentCount(loadedProduct.id, comment);
               
               Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: loadedProduct.id);
              },
              child: Text("Yorumu Gönder"),
            )
          ],
        ),
      ),
    );
  }
}
