import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:final_project/models/store.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:final_project/models/locations.dart';
 Set<Marker> markers = {};
  Set<Marker> markerssonuc = {};

  var clients = [];
  List <LatLng> client;

class MapShowStore extends StatefulWidget {
   

    final PlaceLocation initialLocation;
  
  MapShowStore({
    this.initialLocation =
        const PlaceLocation(latitude:37.758579038115, longitude: 29.090099036693),

  });
  @override
  _MapShowStoreState createState() => _MapShowStoreState();
}
addMarker(){

  Marker startMarker = Marker(
          markerId: MarkerId('Gratis'),
          position: LatLng(
           37.75857903811508,
            29.090099036693573,
          ),
          infoWindow: InfoWindow(
            title: 'Start',
           
          ),
          icon: BitmapDescriptor.defaultMarker,
        );

        // Destination Location Marker
        Marker destinationMarker = Marker(
          markerId: MarkerId('Rossman'),
          position: LatLng(
            37.774730,
            29.086083,
          ),
          infoWindow: InfoWindow(
            title: 'Rossman',
           
          ),
          icon: BitmapDescriptor.defaultMarker,
        );
           Marker mark = Marker(
          markerId: MarkerId('Watsons'),
          position: LatLng(
            37.774781,
            29.087338,
          ),
          infoWindow: InfoWindow(
            title: 'Watsons',
            
          ),
          icon: BitmapDescriptor.defaultMarker,
        );
        markers.add(startMarker);
        markers.add(destinationMarker);
        markers.add(mark);
         for(int i=0; i<markers.length;++i){
      Geolocator().distanceBetween(37.758579038115, 29.090099036693, markers.elementAt(i).position.latitude,markers.elementAt(i).position.longitude).then((calDist) {
          if(calDist/1000<double.parse('3')){
          mark=  Marker(
          markerId: MarkerId(i.toString()),
          position: LatLng(markers.elementAt(i).position.latitude, markers.elementAt(i).position.longitude),
         
          icon: BitmapDescriptor.defaultMarker,
        );
          }

      });
      markerssonuc.add(mark);
      //print(markerssonuc.elementAt(i).markerId);

    }
}
class _MapShowStoreState extends State<MapShowStore> {
  
  @override
  Widget build(BuildContext context) {
    // client.add(LatLng(
    //         37.774730,
    //         29.086083,
    //       ),);
    //       client.add(LatLng(
    //         37.774781,
    //         29.087338,
    //       ),); client.add(LatLng(
    //        37.75857903811508,
    //         29.090099036693573,
    //       ),);
     Marker startMarker = Marker(
          markerId: MarkerId('kisi'),
          position: LatLng(
           37.75857903811508,
            29.090099036693573,
          ),
          infoWindow: InfoWindow(
            title: 'Burdayım',
           
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
        );
    markerssonuc.add(startMarker);
    addMarker();
    
   // print(markers.elementAt(1).markerId);
    //filterMarkers();
    return Scaffold(

      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 16,
        ),
        markers: markerssonuc != null ? Set<Marker>.from(markerssonuc) : null,
         
      ),
   
    );
  }
  Marker mark;
  // filterMarkers(){
  //   for(int i=0; i<markers.length;++i){
  //     Geolocator().distanceBetween(37.758579038115, 29.090099036693, markers.elementAt(i).position.latitude,markers.elementAt(i).position.longitude).then((calDist) {
  //         if(calDist/1000<double.parse('5')){
  //         mark=  Marker(
  //         markerId: MarkerId('Gratis'),
  //         position: LatLng(markers.elementAt(i).position.latitude, longitude),
  //         infoWindow: InfoWindow(
  //           title: 'burasi',
           
  //         ),
  //         icon: BitmapDescriptor.defaultMarker,
  //       );
  //         }

  //     });
  //     markers.add(mark);
  //   }
  // }
//   placeFilterMarker(){
//  Marker(
//           markerId: MarkerId('Gratis'),
//           position: client,
//           infoWindow: InfoWindow(
//             title: 'Start',
           
//           ),
//           icon: BitmapDescriptor.defaultMarker,
//         );


//   }
 }