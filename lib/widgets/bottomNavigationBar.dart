import 'package:flutter/material.dart';
import 'package:final_project/screens/products_overview_screen.dart';

@override
Widget BottomNav(context) {    double screenHeight = MediaQuery.of(context).size.width;

  return BottomAppBar(
    color: Colors.white,
    shape: const CircularNotchedRectangle(),
    child: Container(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(width: screenHeight*0.30,
            decoration: new BoxDecoration(
             
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
            child: FloatingActionButton(
              focusColor: Color.fromARGB(150, 58, 60, 94),
              hoverColor: Color.fromARGB(200, 58, 60, 94),
              backgroundColor: Color.fromARGB(230, 58, 60, 94),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/home2", (r) => false);
              },
              child: Icon(Icons.home),
              heroTag: null,
            ),
          ),
          Container(width: screenHeight*0.30,
            decoration: new BoxDecoration(
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
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(230, 58, 60, 94),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/product-overview", (r) => false);
              },
              child: Icon(Icons.view_carousel),
              heroTag: null,
            ),
          ),
          Container(width: screenHeight*0.30,
            decoration: new BoxDecoration(
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
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(230, 58, 60, 94),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, "/favoriler", (r) => false);
              },
              child: Icon(Icons.favorite),
              heroTag: null,
            ),
          ),
        ],
      ),
    ),

    // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
  );
}
