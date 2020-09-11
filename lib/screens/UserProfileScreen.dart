import 'package:flutter/material.dart';
import 'package:final_project/models/user.dart';
import 'package:final_project/services/service.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/services/database.dart';
import 'package:final_project/shared/Loading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:final_project/widgets/drawer.dart';
import 'package:final_project/widgets/bottomNavigationBar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:provider/provider.dart';
import 'package:final_project/services/auth.dart';
import 'package:final_project/models/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:final_project/screens/user_profile_edit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:final_project/screens/product_detail_screen.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/n';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

List lists = [];
List lists2 = [];

User userr = User();

class _UserProfileScreenState extends State<UserProfileScreen>
    with SingleTickerProviderStateMixin {
  Service service = Service();
  List<Comment> userComments = List<Comment>();
  DatabaseService dbService = DatabaseService();
  String userId;
  TabController _nestedTabController;
  @override
  void initState() {
    super.initState();
    //lists= new List();

    _nestedTabController = new TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<User>(context).fetcAndSetUser().then((_) {});
    _nestedTabController.dispose();
  }
// @override
//   void didChangeDependencies() {
//     // TODO: implement didChangeDependencies

//       Provider.of<User>(context).fetcAndSetUser().then((_) {

//       });
//     }

//     super.didChangeDependencies();
//   }
  AuthService _auth = AuthService();
  var user;

  // Future<void> toggleFavoriteStatus() async {
  //   // final oldStatus = isFavorite;
  //   // isFavorite = !isFavorite;
  //   //service.addFavorite(productId, name, description, imageUrl);

  //   // service.addFavorite(productId);
  //   // notifyListeners();
  //   user = await _auth.user.first;
  //   userId = user.uId;
  // }

  // @override
  Widget build(BuildContext context) {
    // showUser();

    final user = Provider.of<User>(context);

    String userId = user.uId;
    print(userId);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    final TextStyle display1 = Theme.of(context).textTheme.headline4;
    var productsReference =
        FirebaseDatabase.instance.reference().child("comments");
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: screenHeight * 0.38,
                width: screenWidth,
                color: Color.fromARGB(255, 66, 68, 107),
                padding: EdgeInsets.only(top: 50, left: 8, right: 8, bottom: 8),
                // color: HexColor("#31343E"),
                //  color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        user.imageUrl,
                        width: 130,
                        height: 130,
                        fit: BoxFit.fill,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: user.name,
                            style: GoogleFonts.oswald(
                                textStyle: display1,
                                fontSize: 15,
                                color: Colors.white)
                            // TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontFamily: 'Montserrat',
                            //     color: Colors.black87)
                            ),
                        // TextSpan(
                        //     text: userr.email,
                        //     style: TextStyle(
                        //         fontFamily: 'Montserrat',
                        //         color: Colors.black54)),
                      ]),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  TabBar(
                    controller: _nestedTabController,
                    indicatorColor: Colors.teal,
                    labelColor: Colors.teal,
                    unselectedLabelColor: Colors.black54,
                    isScrollable: true,
                    tabs: <Widget>[
                      Tab(
                        text: "Profil düzenle    ",
                      ),
                      Tab(
                        text: "puanlar      ",
                      ),
                      Tab(
                        text: "Yorumlar      ",
                      ),
                    ],
                  ),
                  Container(
                    height: screenHeight * 0.62,
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: TabBarView(
                      controller: _nestedTabController,
                      children: <Widget>[
                        Container(
                          child: UserProfileEdit(),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(children: <Widget>[
                              FutureBuilder(
                                  future: productsReference
                                      .orderByChild("userId")
                                      .equalTo(userId)
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
                                            return GestureDetector(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: Icon(
                                                          Icons.add_comment),
                                                      title: Text(
                                                          lists[index]["rate"]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    ProductDetailScreen
                                                        .routeName,
                                                    arguments: lists[index]
                                                        ["productId"]);
                                              },
                                            );
                                          });
                                    } else {
                                      Text("Daha önce bir puan vermemişsiniz.");
                                    }
                                    return CircularProgressIndicator();
                                  })
                            ]),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(children: <Widget>[
                              FutureBuilder(
                                  future: productsReference
                                      .orderByChild("userId")
                                      .equalTo(userId)
                                      .once(),
                                  builder: (context,
                                      AsyncSnapshot<DataSnapshot> snapshot) {
                                    if (snapshot.hasData) {
                                      lists2.clear();
                                      Map<dynamic, dynamic> values =
                                          snapshot.data.value;
                                      values.forEach((key, values) {
                                        lists2.add(values);
                                      });
                                      return new ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: lists2.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return GestureDetector(
                                              child: Card(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.0),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: <Widget>[
                                                    ListTile(
                                                      leading: Icon(
                                                          Icons.add_comment),
                                                      title: Text(
                                                          lists2[i]["comment"]),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                    ProductDetailScreen
                                                        .routeName,
                                                    arguments: lists2[i]
                                                        ["productId"]);
                                              },
                                            );
                                          });
                                    } else {
                                      Text(
                                          "Daha önce bir yorum Yapmamışsınız.");
                                    }
                                    return CircularProgressIndicator();
                                  })
                            ]),
                          ),
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

  Future showUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    userr.name = user.displayName;
    userr.imageUrl = user.photoUrl;
    userr.email = user.email;
    print(user.uid);
    return userr;
  }
}
