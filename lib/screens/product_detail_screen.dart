import 'package:final_project/models/product.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/products_provider.dart';
import 'package:final_project/widgets/add_comment.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/models/comment.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/widgets/mapShowStore.dart';

class ProductDetailScreen extends StatefulWidget {
//   final String title;
//   final String price;
// ProductDetailScreen(this.title,this.price);
  static const routeName = '/product-detail';

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

final productsReference =
    FirebaseDatabase.instance.reference().child('products');
final dbRef = FirebaseDatabase.instance.reference().child('comments');

class _ProductDetailScreenState extends State<ProductDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _nestedTabController;
  List<Product> items;
  // List<Comment> lists=new List<Comment>();
  List lists = [];
  Service service = Service();
// var editedProduct = Product(
//     id: null,
//     name: items.,
//     price: 0,
//     description: '',
//     imageUrl: '',
//   );
  @override
  void initState() {
    super.initState();
    items = new List();
    //lists= new List();

    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    final productId = ModalRoute.of(context).settings.arguments as String;
    final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
        .findById(productId);
    // final commentId = ModalRoute.of(context).settings.arguments as String;
    //   final loadedComment= Provider.of<DatabaseService>(context, listen: false)
    //       .findById(commentId);
    final favorites = Provider.of<DatabaseService>(context, listen: false);
    final TextStyle display1 = Theme.of(context).textTheme.headline4;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: getColorFromHex('#3a3c5e'),
          title: Text(loadedProduct.name)),
      drawer: DrawerAll(context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(100, 58, 60, 94).withOpacity(
                            .6), //                   <--- border color
                        width: 0.4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                              2.0) //         <--- border radius here
                          ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(150, 58, 60, 94).withOpacity(.5),
                          blurRadius: 20.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    height: 209,
                    width: screenWidth * 0.45,
                    child: Card(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            SizedBox(height: 7),
                            Container(
                                width: 190,
                                child: Row(children: <Widget>[
                                  SizedBox(width: 1),
                                  Container(
                                    width: 150,
                                    child: Text(
                                      loadedProduct.name,
                                      style: GoogleFonts.oswald(
                                          textStyle: display1, fontSize: 15),
                                    ),
                                  ),
                                ])),
                            SizedBox(height: 7),
                            Container(
                              child: Text(
                                'Puan: ' + loadedProduct.rate,
                                style: GoogleFonts.oswald(
                                    textStyle: display1, fontSize: 15),
                              ),
                            ),
                            SizedBox(height: 7),
                            Container(
                              child: IconButton(
                                icon: const Icon(Icons.favorite),
                                tooltip: 'Show Snackbar',
                                onPressed: () {
                                  // Navigator.pushNamed(context, "/user-profile");
                                },
                              ),
                            ),
                            Container(),
                          ]),
                    ),
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(100, 58, 60, 94).withOpacity(
                            .6), //                   <--- border color
                        width: 0.4,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(
                              2.0) //         <--- border radius here
                          ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(150, 58, 60, 94).withOpacity(.5),
                          blurRadius: 20.0, // soften the shadow
                          spreadRadius: 0.0, //extend the shadow
                          offset: Offset(
                            5.0, // Move to right 10  horizontally
                            5.0, // Move to bottom 10 Vertically
                          ),
                        )
                      ],
                    ),
                    width: screenWidth * 0.52,
                    child: Card(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                          Container(
                              // alignment: Alignment.topRight,
                              // padding: EdgeInsets.only(left: 80),
                              height: 200,
                              width: 200,
                              child: Image.network(loadedProduct.imageUrl,
                                  fit: BoxFit.cover)),
                        ])),
                  ),
                ],
              )),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TabBar(
                    controller: _nestedTabController,
                    indicatorColor:
                        Color.fromARGB(100, 58, 60, 94).withOpacity(.6),
                    labelColor: Color.fromARGB(100, 58, 60, 94).withOpacity(.6),
                    unselectedLabelColor: Colors.black54,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        text: "Ürün Bilgisi      ",
                      ),
                      Tab(
                        text: "Yorumlar      ",
                      ),
                      Tab(
                        text: "Mağazalar",
                      ),
                    ],
                  ),
                  Container(
                    height: screenHeight * 0.70,
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TabBarView(
                      controller: _nestedTabController,
                      children: <Widget>[
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            
                            ),
                            child: Column(children: <Widget>[
                              Card(
                                child: Text(loadedProduct.description),
                              )
                            ]),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(children: <Widget>[
                              Card(
                                child: AddComment(),
                              ),
                              SizedBox(height: 10),
                              FutureBuilder(
                                  future: dbRef
                                      .orderByChild("productId")
                                      .equalTo(loadedProduct.id)
                                      .once(),
                                  builder: (context,
                                      AsyncSnapshot<DataSnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      lists.clear();
                                      Map<dynamic, dynamic> values =
                                          snapshot.data.value;
                                      values.forEach((key, values) {
                                        lists.add(values);
                                      });
                                      return new ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: lists.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15.0),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  ListTile(
                                                    leading:
                                                        Icon(Icons.add_comment),
                                                    title: Text(lists[index]
                                                        ["comment"]),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    }
                                    return CircularProgressIndicator();
                                  })
                            ]),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: MapShowStore(),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
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

//   @override
//   Widget build(BuildContext context) {
//     final productId = ModalRoute.of(context).settings.arguments as String;
//     final loadedProduct = Provider.of<ProductsProvider>(context, listen: false)
//         .findById(productId);

//     return Scaffold(
//       appBar: AppBar(title: Text(loadedProduct.name)),
//       body: SingleChildScrollView(
//         child: Column(
//           children: <Widget>[
//             Container(
//                 height: 300,
//                 child:
//                     Image.network(loadedProduct.imageUrl, fit: BoxFit.cover)),
//             SizedBox(height: 10),
//             Text(
//               '\$${loadedProduct.price}',
//               style: TextStyle(color: Colors.grey, fontSize: 20),
//             ),
//             SizedBox(height: 10),
//             Container(
//               padding: EdgeInsets.symmetric(horizontal:10),
//               width: double.infinity,
//               child: Text(
//                 loadedProduct.description,
//                 textAlign:TextAlign.center,
//                 softWrap:true,
//               ),
//             ),
//             // SliverList(
//             //     delegate: SliverChildBuilderDelegate((context, index) {
//             //       return GestureDetector(
//             //         onTap: () {},
//             //         child: Card(
//             //           child: ListTile(
//             //             title: Text(list[index].rat),
//             //             leading: Text(list[index].name),
//             //             trailing: IconButton(
//             //               icon: Icon(Icons.rate_review,
//             //                   color: Theme.of(context).primaryColor),
//             //               onPressed: () {
//             //                 _addComment(
//             //                     context,
//             //                     list[index].id,
//             //                     snapshot.data.id);
//             //               },
//             //             ),
//             //           ),
//             //           elevation: 3,
//             //         ),
//             //       );
//             //     }, childCount: snapshot.data.menu.length),
//             //   ),
//           ],
//         ),
//       ),
//     );
//   }
// }
