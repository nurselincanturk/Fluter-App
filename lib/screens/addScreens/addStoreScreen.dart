import 'dart:io';
import 'package:final_project/models/locations.dart';
import 'package:final_project/models/category.dart';
import 'package:final_project/models/store.dart';
import 'package:path/path.dart' as p;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:final_project/services/Service.dart';
//import 'package:final_project/screens/LocationInput.dart';
import 'dart:io';

import 'package:final_project/screens/LocationInput.dart';

class AddPlaceScreen extends StatefulWidget {
  static const routeName = "/addPlaceScreen";

  @override
  _AddPlaceScreenState createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  String fileType = "";
  File file;
  String fileName = "";
  String operationText = "";
  bool isUploaded = true;
  String result = "";
  String imageUrl = "";
  final dBRef = FirebaseDatabase.instance.reference();
  List<Category> categories;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((_) {
      // service.getCategories().then((value) {
      //   categories = value;
      // });
    });
  }

  PlaceLocation _pickedLocation;
  TextEditingController titleController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lngController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey(debugLabel: "formKey");
  Service service = Service();
  Store place = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Form(
            autovalidate: true,
            key: formKey, //textinput action eklencek
            child: Column(
              children: <Widget>[
                _userInput("Mekan Adı", titleController),
                // _userInput("latitude", latController),
                // _userInput("longitude", lngController),
                LocationInput(_selectPlace)
                //showPickerNumber(context),
              ],
            ),
          ),
         
          SizedBox(
            height: 50,
          ),
          RaisedButton(
            onPressed: () {
              writeData();
              place.lat = _pickedLocation.latitude.toString();
              place.lng = _pickedLocation.longitude.toString();
              place.name = titleController.text;
              service.addStore(place);
            },
          ),
        ],
      ),
    );
  }

  void _selectPlace(double lat, double lng) {
    _pickedLocation = PlaceLocation(latitude: lat, longitude: lng);
  }

  Widget _userInput(String label, TextEditingController controller) {
    return TextFormField(
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Bu alan Boş Bırakılamaz';
        }
        return null;
      },
    );
  }


  void writeData() {
    // dBRef.child("places").set({
    //   'title': 'Benjamin Kafee  ',
    //   'adress': 'asdasd',
    //   'latitude': '123123',
    //   'longitude': '23132',
    //   'imgUrl': 'www.asdasd.com',
    //   'menu': {'foodId': '2132312', 'foodRating': '8.4'}
    // });

   // print(categories[0].catName);
    // dBRef.once().then((DataSnapshot dataSnapshot) {
    //   print(dataSnapshot.value);
    // });

    // dBRef.child("path").update({
    //   "data":"updated"
    // });

    // dBRef.child("path").remove();
  }
}
