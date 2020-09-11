import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/screens/product_detail_screen.dart';
import 'package:final_project/screens/productCatOverview.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatelessWidget {
  static const routeName = "/categories";

  final dbRef = FirebaseDatabase.instance.reference().child('categories');
  List lists = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: getColorFromHex('#3a3c5e'),
          title: Text("Kategoriler")),
      drawer: DrawerAll(context),
      body: Container(
        decoration: new BoxDecoration(
          border: Border.all(
            color: Color.fromARGB(60, 58, 60, 94)
                .withOpacity(.1), //                   <--- border color
            width: 5.0,
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(5.0) //         <--- border radius here
              ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(60, 58, 60, 94).withOpacity(.1),
              blurRadius: 20.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                lists.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  lists.add(values);
                });
                // return FavoritesGrid();
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: lists.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              ProductsCatOverview.routeName,
                              arguments: lists[index]["catName"]);
                        },
                        child: Container(
                          // width: 50,height: 75,
                          decoration: new BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(60, 58, 60, 94).withOpacity(
                                  .1), //                   <--- border color
                              width: 5.0,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(
                                    5.0) //         <--- border radius here
                                ),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(90, 58, 60, 94)
                                    .withOpacity(.1),
                                blurRadius: 20.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 10  horizontally
                                  5.0, // Move to bottom 10 Vertically
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.only(right: 20.0, left: 15.0),
                          child: Card(
                            shadowColor: getColorFromHex('#3a3c5e'),
                            child: Container(
                                alignment: Alignment.center,
                                width: 80,
                                height: 75,
                                child: Text(lists[index]["catName"],
                                    style: TextStyle(
                                        color: getColorFromHex('#4E517F'),
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 9.0),
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(9.0),
                        //       color: Colors.white,
                        //     ),
                        //     child: ClipRRect(
                        //       borderRadius: BorderRadius.circular(9.0),
                        //       child: Text(
                        //         lists[index]["catName"], style: TextStyle(color: getColorFromHex('#4E517F'))
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      );
                    });
              }
              return CircularProgressIndicator();
            }),
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
