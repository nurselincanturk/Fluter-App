import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:final_project/services/service.dart';

class TartismaList extends StatefulWidget {
  static const routeName = '/tarList';

  @override
  _TartismaListState createState() => _TartismaListState();
}

final dbRef = FirebaseDatabase.instance.reference().child('tartisma');

class _TartismaListState extends State<TartismaList> {
  List lists = [];
  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final konu = ModalRoute.of(context).settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 66, 68, 107), title: Text(konu)),
      drawer: DrawerAll(context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(
              left: screenWidth * 0.05, right: screenWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: screenWidth * 0.90,
                child: Card(
                  elevation: 5,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                              labelText: "Yorum",
                              labelStyle: TextStyle(color: Colors.black54),
                              border: OutlineInputBorder()),
                        ),
                        RaisedButton(
                          onPressed: () {
                            service.addTartisma(konu, commentController.text);
                            Navigator.of(context).pushNamed(
                                TartismaList.routeName,
                                arguments: konu);
                            //  Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                            //     arguments: loadedProduct.id);
                            //  .pushNamed(context, "/product-overview");
                          },
                          child: Text("Yorumu Gönder"),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SingleChildScrollView(
            
                  //     decoration: new BoxDecoration(
                  //   border: Border.all(
                  //     color: Color.fromARGB(150, 58, 60, 94).withOpacity(
                  //         .1), //                   <--- border color
                  //     width: 5.0,
                  //   ),
                  //   borderRadius: BorderRadius.all(Radius.circular(
                  //           5.0) //         <--- border radius here
                  //       ),
                  //   boxShadow: [
                  //     BoxShadow(
                  //       color: Color.fromARGB(90, 58, 60, 94)
                  //           .withOpacity(.1),
                  //       blurRadius: 20.0, // soften the shadow
                  //       spreadRadius: 0.0, //extend the shadow
                  //       offset: Offset(
                  //         5.0, // Move to right 10  horizontally
                  //         5.0, // Move to bottom 10 Vertically
                  //       ),
                  //     )
                  //   ],
                  // ),
                  child: Card(
                    child: FutureBuilder(
                        future: dbRef.orderByChild("konu").equalTo(konu).once(),
                        builder:
                            (context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            lists.clear();
                            Map<dynamic, dynamic> values = snapshot.data.value;
                            values.forEach((key, values) {
                              lists.add(values);
                            });
                            return SingleChildScrollView(
                              child: new ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: lists.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(padding: EdgeInsets.only(bottom:0.9),
                                      width: screenWidth * 0.90,
                                      decoration: new BoxDecoration(
                                        border: Border.all(
                                          color: Color.fromARGB(150, 58, 60, 94)
                                              .withOpacity(
                                                  .4), //                   <--- border color
                                          width: 5.0,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                5.0) //         <--- border radius here
                                            ),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Color.fromARGB(90, 58, 60, 94)
                                                    .withOpacity(.1),
                                            blurRadius:
                                                20.0, // soften the shadow
                                            spreadRadius:
                                                0.0, //extend the shadow
                                            offset: Offset(
                                              5.0, // Move to right 10  horizontally
                                              5.0, // Move to bottom 10 Vertically
                                            ),
                                          )
                                        ],
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            ListTile(
                                              title: Text(
                                                lists[index]["yorum"],
                                                style: TextStyle(
                                                  color: Color.fromARGB(
                                                      250, 58, 60, 94),
                                                  fontSize: 14,
                                                  //fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            );
                          }
                          return CircularProgressIndicator();
                        }),
                  ),
               
              ),
            ],
          ),
        ),
      ),
    );
  }
}
