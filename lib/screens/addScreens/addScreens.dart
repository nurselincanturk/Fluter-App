import 'package:final_project/screens/addScreens/AddCategoryScreen.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/service.dart';
import 'addStoreScreen.dart';
import 'package:final_project/screens/edit_product_screen.dart';
class AddScreens extends StatefulWidget {
  @override
  _AddScreensState createState() => _AddScreensState();
}

class _AddScreensState extends State<AddScreens> {
  Service service = Service();
  String cat;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(backgroundColor: Color.fromARGB(255, 66, 68, 107),
            bottom: TabBar(
              tabs: [
                Tab(text: 'Kategori ekle',),
                Tab(text: 'Mağaza ekle'),
                Tab(text: 'Ürün ekle'),
                // Tab(icon: Icon(Icons.directions_bike)),
                // Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            
          ),
          body: TabBarView(
           children: <Widget>[
            Center(
              child:AddCategoryScreen()
            ),
            Center(
            child:AddPlaceScreen()
            ),
            Center(
             child: EditProductScreen()

            ),
            // Center(
            //   child: Column(

            //     children: <Widget>[
            //     SizedBox(height: 20.0),
            //     TextFormField(
            //       validator: (val) => val.isEmpty ? 'Kategori girin' : null,
            //       onChanged: (val) {
            //         setState(() {
            //           cat = val;
            //         });
            //       },
            //     ),
            //     SizedBox(height: 20.0),
            //      RaisedButton(
            //     color: Colors.blueAccent,
            //     child: Text(
            //       'Ekle',style:TextStyle(color: Colors.white),
            //     ),
            //     onPressed: ()  {
            //      service.addCategory(cat);
            //     }),SizedBox(height: 12.0),
            //   ]
            //   )
            // ),
            // Center(
            //   child: Text('Text with style'),
            // )
          ],
          ),
        ),
      ),
    );
  }
}
