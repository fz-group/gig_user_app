import 'dart:convert';
import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {


 TextEditingController dateController=TextEditingController();
 dynamic dateTime='';
 Time time = Time(hour: 11, minute: 30, second: 20);


  void onTimeChanged(Time newTime) {
   
      time = newTime;
      update();
    
  }
  String placeNamex='';
  LatLng currentLatLng = const LatLng(37.422004313390126,
      -122.08400756120682);
  double zoom = 13.0;
  double latx=37.422004313390126;
  double lngx=-122.08400756120682;

TextEditingController searchController=TextEditingController();

  GoogleMapController? mapController;

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
    update();
  }


  selectDate(var value){
    dateTime=value;
    update();
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    print("PERMISSION=="+permission.toString());
    // permission = await Geolocator.requestPermission();
    getCurrentLocation();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        permission = await Geolocator.requestPermission();
        print("DENIED");
        return;
      }
      getCurrentLocation();
    }
    else{
      permission = await Geolocator.checkPermission();
      permission = await Geolocator.requestPermission();
      getCurrentLocation();
    }
  }

  Future<Map<String, dynamic>> getLatLng(String placeName) async {

    print("MAAAAAAPPPPP");
    String apiKey = 'AIzaSyDA-D-AYyDPASQgA2p98xxzZHXMusGcblk';
    //'AIzaSyBo94cx-aOPjxB9wyZjUqSf5v58qE4cQ3I';
    //'AIzaSyCKckCh7RP4ezDtY4F2m5CEV0Y8tfntDFk';
    
    //'AIzaSyBCRjQbAjjWsve_mxS2qcO2moflRSffGoo';
    String encodedPlaceName = Uri.encodeQueryComponent(placeName);
    String url = 
    'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedPlaceName&key=$apiKey';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("///");
      print(response.body);
       print("///");
      print("200wwwweeeee");
      final decodedResponse = json.decode(response.body);
      final results = decodedResponse['results'];

      if (results.isNotEmpty) {
        print("not empty");
        final location = results[0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        print(lat);
        print(lng);

        latx=lat;
        lngx=lng;

        currentLatLng=LatLng(latx, lngx);

        placeNamex=placeName;
        
        update();

        updateCameraPosition(latx,lngx);
        return {'lat': lat, 'lng': lng};

      }else{
        print("empty");
      }
    }
    
    else{
      print("xxxx0000000");
     
    }
     return {'lat': 0.0, 'lng': 0.0};
    //return null;
  }

  void onCameraMove(CameraPosition position) {
    print("move");
    currentLatLng = position.target;
    latx=currentLatLng.latitude;
    lngx=currentLatLng.longitude;

    print("xxxxxxccc");
    print(latx);
    print(lngx);
    print('////////////////');
    update();
  }


  Future<void> getCurrentLocation() async {
    print("Current");
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    latx = position.latitude;
    lngx = position.longitude;
    print('Latitude: $latx, Longitude: $lngx');
    updateCameraPosition(latx,lngx);
  }





  void updateCameraPosition(double lat, double lng) {
    print("UPDATE");
    print(lat);
    print(lng);
    print("UPDATE");

    currentLatLng = LatLng(lat, lng);
    zoom = 13.0; // You can set a different zoom level if needed
    latx=currentLatLng.latitude;
    lngx=currentLatLng.longitude;
    mapController
        ?.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, zoom));

    update();
  }
}
