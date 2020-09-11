import 'package:final_project/models/user.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:final_project/screens/favorites_screen.dart';
import 'package:final_project/services/service.dart';

AuthService _auth = AuthService();
Service service = Service();
User userr = User();
List lists = [];
final dbRef = FirebaseDatabase.instance.reference().child("users");

@override
Widget DrawerAll(context) {
  showUser();
  return Drawer(
      child: ListView(children: <Widget>[
    Container(
      color: Color.fromARGB(255, 66, 68, 107),
      padding: EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
      // color: HexColor("#31343E"),
      //  color: Colors.white,
      child: Column(mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              userr.imageUrl,
              width: 120,
              height: 120,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: userr.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      color: Colors.white,fontSize: 20)),
              // TextSpan(
              //     text: "@username",
              //     style: TextStyle(
              //         fontFamily: 'Montserrat', color: Colors.black54)),
            ]),
          ),
          // FutureBuilder(
          //           future: dbRef.once(),
          //           builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          //             if (snapshot.hasData) {
          //               lists.clear();
          //               Map<dynamic, dynamic> values = snapshot.data.value;
          //               values.forEach((key, values) {
          //                 lists.add(values);
          //               });
          //               // return FavoritesGrid();
          //               return new ListView.builder(
          //                   scrollDirection: Axis.horizontal,
          //                   shrinkWrap: true,
          //                   itemCount: lists.length,
          //                   itemBuilder: (BuildContext context, int index) {
          //                     return GestureDetector(
          //                       onTap: () {
          //                         // Navigator.of(context).pushNamed(
          //                         //     ProductDetailScreen.routeName,
          //                         //     arguments: lists[index]["id"]);
          //                       },
          //                       child: Padding(
          //                         padding: const EdgeInsets.symmetric(
          //                             horizontal: 9.0),
          //                         child: Container(
          //                           child:Text(   lists[index]["name"])
          //                           // decoration: BoxDecoration(
          //                           //   borderRadius: BorderRadius.circular(9.0),
          //                           //   color: Colors.white,
          //                           // ),
          //                           // child: ClipRRect(
          //                           //   borderRadius: BorderRadius.circular(9.0),
          //                           //   child: Image.network(
          //                           //       lists[index]["imageUrl"],
          //                           //       fit: BoxFit.cover),
          //                           // ),
          //                         ),
          //                       ),
          //                     );
          //                   });
          //             }
          //             return CircularProgressIndicator();
          //           }),
        ],
      ),
    ),
    Divider(height: 1, thickness: 1, color: Colors.blueGrey[900]),
    Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10),

          Container(
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
                  color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.toc,
                color: Color.fromARGB(255, 66, 68, 107),
              ),
              title: Text('Kategoriler'),
              onTap: () {
                Navigator.pushNamed(context, "/categories");
                // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
              },
            ),
          ),
          SizedBox(height: 10),
          Container(
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
                  color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: Color.fromARGB(255, 66, 68, 107),
              ),
              title: Text('Profil'),
              onTap: () {
                Navigator.pushNamed(context, "/n");
                // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
              },
            ),
          ),
          Container(
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
                  color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.subject,
                color: Color.fromARGB(255, 66, 68, 107),
              ),
              title: Text('Başlıklar'),
              onTap: () {
                Navigator.pushNamed(context, "/tartis");
                // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
              },
            ),
          ),
          // SizedBox(height: 10),
          // Container(
          //   decoration: new BoxDecoration(
          //     border: Border.all(
          //       color: Color.fromARGB(60, 58, 60, 94)
          //           .withOpacity(.1), //                   <--- border color
          //       width: 5.0,
          //     ),
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(5.0) //         <--- border radius here
          //         ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
          //         blurRadius: 20.0, // soften the shadow
          //         spreadRadius: 0.0, //extend the shadow
          //         offset: Offset(
          //           5.0, // Move to right 10  horizontally
          //           5.0, // Move to bottom 10 Vertically
          //         ),
          //       )
          //     ],
          //   ),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.message,
          //       color: Color.fromARGB(255, 66, 68, 107),
          //     ),
          //     title: Text('Hakkımızda'),
          //     onTap: () {
          //       Navigator.pushNamed(context, "/n");
          //       // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
          //     },
          //   ),
          // ),
          // SizedBox(height: 10),
          // Container(
          //   decoration: new BoxDecoration(
          //     border: Border.all(
          //       color: Color.fromARGB(60, 58, 60, 94)
          //           .withOpacity(.1), //                   <--- border color
          //       width: 5.0,
          //     ),
          //     borderRadius: BorderRadius.all(
          //         Radius.circular(5.0) //         <--- border radius here
          //         ),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
          //         blurRadius: 20.0, // soften the shadow
          //         spreadRadius: 0.0, //extend the shadow
          //         offset: Offset(
          //           5.0, // Move to right 10  horizontally
          //           5.0, // Move to bottom 10 Vertically
          //         ),
          //       )
          //     ],
          //   ),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.message,
          //       color: Color.fromARGB(255, 66, 68, 107),
          //     ),
          //     title: Text('İletişim'),
          //     onTap: () {
          //       Navigator.pushNamed(context, "/product-overview");
          //       // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
          //     },
          //   ),
          // ),
          // SizedBox(height: 10),
          // ListTile(
          //   leading: Icon(Icons.message, color: Color(0xff2446a6)),
          //   title: Text('İndirimler'),
          //   onTap: () {
          //     Navigator.pushNamed(context, "/product-overview");
          //     // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
          //   },
          // ),
          SizedBox(height: 10),
          Container(
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
                  color: Color.fromARGB(70, 58, 60, 94).withOpacity(.1),
                  blurRadius: 20.0, // soften the shadow
                  spreadRadius: 0.0, //extend the shadow
                  offset: Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ],
            ),
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Color.fromARGB(255, 66, 68, 107),
              ),
              title: Text('Çıkış yap'),
              onTap: () {
                _auth.signOut();
                Navigator.pushNamed(context, "/login");

                // Navigator.of(context).pushNamed(ProductDetailScreen.routeName);
              },
            ),
          ),

          // List items goes here...
        ],
      ),
    ),
  ]));
}

Future showUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();

  if (user.displayName != null) {
    userr.name = user.displayName;
  } else {
    userr.name = 'user';
  }
  if (user.photoUrl != null) {
    userr.imageUrl = user.photoUrl;
  } else {
    userr.imageUrl =
        'https://cdn0.iconfinder.com/data/icons/set-ui-app-android/32/8-512.png';
  }

  return userr;
}
