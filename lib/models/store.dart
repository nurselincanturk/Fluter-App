import 'package:firebase_database/firebase_database.dart';

class Store {
  String id;
  String name;
  String lat;
  String lng;
  Store({this.id, this.name, this.lat, this.lng});

  Store.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.lat = obj['lat'];
    this.lng = obj['lng'];
  }

  Store.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    name = snapshot.value['name'];
    lat = snapshot.value['lat'];
    lng = snapshot.value['lng'];
  }
}
