import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Location{

  late double longitude;
  late double latitude;
  final String apikey = 'bc4172f84b1c95b7d2281286f70c8e2b';
  late Future<String> error;

  Future<void> getLocation() async{
    // list of variables and their types
     LocationPermission permission;
     Position userposition;

    try{
      permission = await Geolocator.checkPermission();
    }
    catch(e){
      print('this app has no permission to access location');
      return;
    }
    // request for permission from the user
    try{
      permission = await Geolocator.requestPermission();
    }
    catch(e){
      print('the user did not give us permission to access location ');
      return;
    }
    try{
      userposition =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
         // this gets the location of the user based on the level of accuracy stated, in this case it is low.
         longitude = userposition.longitude;
         latitude = userposition.latitude;
    }
    catch(e){
      print('Please make sure the app has access to your location');
      return;
    }
  }
}









// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
//
// class Location {
//
//   late double longitude;
//   late double latitude;
//
//   Future<void> getLocation() async {
//     // list of variables and their types
//     bool serviceEnabled;
//     LocationPermission permission;
//     Position userposition;
//
//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (serviceEnabled == false) {
//       // Location services are not enabled
//       return Future.error('Location services are disabled.');
//     }
//     // Check if the user has given permission to access location
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       // App does not have permission to access location
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
//         // User denied permission
//         //checker = 'Location permissions are sexxxxxyyxyxy';
//         //print(checker);
//         return Future.error('Location permissions are denied');
//       }
//       else{
//         userposition =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//         // this gets the location of the user based on the level of accuracy stated, in this case it is low.
//         longitude = userposition.longitude;
//         latitude = userposition.latitude;
//         print(userposition);
//       }
//     }
//     else{
//       userposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
//       // this gets the location of the user based on the level of accuracy stated to save battery and time, in this case it is low.
//       longitude = userposition.longitude;
//       latitude = userposition.latitude;
//       print(userposition);
//
//     }
//   }
//
// }