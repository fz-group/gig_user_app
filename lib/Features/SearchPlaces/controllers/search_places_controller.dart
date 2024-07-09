

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gic_client/Features/SearchPlaces/data/models/pred.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../Order/presentation/view/confirm_order.dart';
import '../presentation/view/select_area.dart';

class SearchPlacesController extends GetxController{

 String placeZipCode='';


 getPlaceDetails(String query, String apiKey) async {
   try {
     // Make Place Search request
     final searchResponse = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$query&inputtype=textquery&fields=place_id&key=$apiKey'));

     // Check if search request was successful
     if (searchResponse.statusCode == 200) {
       // Parse search response JSON
       Map<String, dynamic> searchResponseData = jsonDecode(searchResponse.body);

       // Check if response contains place ID
       if (searchResponseData.containsKey('candidates') && searchResponseData['candidates'].isNotEmpty) {
         // Extract place ID
         String placeId = searchResponseData['candidates'][0]['place_id'];

         // Make Place Details request
         final detailsResponse = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=geometry,address_components&key=$apiKey'));

         // Check if details request was successful
         if (detailsResponse.statusCode == 200) {
           // Parse details response JSON
           Map<String, dynamic> detailsResponseData = jsonDecode(detailsResponse.body);

           // Check if response contains results
           if (detailsResponseData.containsKey('result')) {
             // Extract latitude and longitude from geometry
             Map<String, dynamic> geometry = detailsResponseData['result']['geometry'];
             Map<String, dynamic> location = geometry['location'];
             double lat = location['lat'];
             double lng = location['lng'];

             // Extract zip code and city from address components
             List<dynamic> addressComponents = detailsResponseData['result']['address_components'];
             String zipCode;
             String city;
             for (var component in addressComponents) {
               List<dynamic> types = component['types'];
               if (types.contains('postal_code')) {
                 zipCode = component['long_name'];
                 placeZipCode=zipCode;
               } else if (types.contains('locality')) {
                 city = component['long_name'];

               }
             }
             // Return place data

           }
         }
       }
     }

     // If place not found, return null
     return null;
   } catch (e) {
     // Handle errors
     print('Error fetching place details: $e');
     return null;
   }
 }


 getZipCode(double lat, double lng, String apiKey) async {

   print(".......CODEEE......");
   try {
     // Make Reverse Geocoding request
     final response = await http.get
       (Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'));

     // Check if request was successful
     if (response.statusCode == 200) {
       // Parse response JSON
       Map<String, dynamic> responseData = jsonDecode(response.body);

       // Check if response contains results
       if (responseData.containsKey('results') && responseData['results'].isNotEmpty) {
         // Extract address components
         List<dynamic> addressComponents = responseData['results'][0]['address_components'];

         // Find zip code in address components
         for (var component in addressComponents) {
           List<dynamic> types = component['types'];
           if (types.contains('postal_code')) {
             placeZipCode=component['long_name'];
             print("place zip code==="+placeZipCode);
            // return component['long_name'];
           }
         }
       }
     }

     // If zip code not found, return null
     //return null;
   } catch (e) {
     // Handle errors
     print('Error fetching zip code: $e');
    // return null;
   }
 }


  // Future<String> getPlaceZipCode(String placeId, String apiKey) async {
  //   print("POSTAL");
  //   print(placeId);
  //   // Make Place Details request
  //   final response = await http.get(
  //       Uri.parse('https://maps.googleapis.com/maps/api/place/details/json?place_id'
  //           '=$placeId&fields=address_components&key=$apiKey'));
  //   // Check if request was successful
  //   if (response.statusCode == 200) {
  //     print("200:");
  //     // Parse response JSON
  //     Map<String, dynamic> responseData = jsonDecode(response.body);
  //     // Check if response contains results
  //     if (responseData.containsKey('result')
  //         && responseData['result'].containsKey('address_components')) {
  //
  //       print('RESULT ZIP CODE');
  //       print(responseData['result'].toString());
  //       // Find postal code in address components
  //       List<dynamic> addressComponents = responseData['result']['address_components'];
  //       for (var component in addressComponents) {
  //         List<dynamic> types = component['types'];
  //         if (types.contains('postal_code')) {
  //           print("typesss==="+types.toString());
  //           print("ccccc=="+component.toString());
  //           placeZipCode=component['long_name'];
  //           //return component['long_name'];
  //         }
  //       }
  //     }
  //   }
  //
  //   // Return null if postal code not found
  //   return '';
  // }



  String newCity='';
  String newState='';



   getPlaceState(double lat, double lng, String apiKey) async {
    print("HERE STATE.....");
  try {
    // Make Reverse Geocoding request
    final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'));

    // Check if request was successful
    if (response.statusCode == 200) {
      print("200 STATE....");
      // Parse response JSON
      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Check if response contains results
      if (responseData.containsKey('results') && responseData['results'].isNotEmpty) {

        print("STATE RESULT...........");
        // Find state in address components
        List<dynamic> addressComponents = responseData['results'][0]['address_components'];
        for (var component in addressComponents) {
          List<dynamic> types = component['types'];
          if (types.contains('administrative_area_level_1')) {
         newState=component['long_name'];

            print("STATE=="+newState.toString());
             // 'administrative_area_level_1' represents the state
            return component['long_name'];
          }
        }
      }
    }

    // If no state found, return null
   // return null;
  } catch (e) {
    // Handle errors
    print('Error fetching state: $e');
    //return null;
  }
}


double newLat=0.0;
double newLng=0.0;

 getPlaceCoordinates(String mainText, String apiKey) async {
   print("PLACE API....");

   try {
     // Make Place Search request
     final response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=$mainText&inputtype=textquery&fields=geometry&key=$apiKey'));

     // Check if request was successful
     if (response.statusCode == 200) {
       // Parse response JSON
       Map<String, dynamic> responseData = jsonDecode(response.body);

       // Check if response contains results
       if (responseData.containsKey('candidates') && responseData['candidates'].isNotEmpty) {
         // Extract latitude and longitude from geometry
         Map<String, dynamic> geometry = responseData['candidates'][0]['geometry'];
         Map<String, dynamic> location = geometry['location'];
         double lat = location['lat'];
         double lng = location['lng'];

         newLat =lat;
         newLng=lng;

         print("nnn==="+newLng.toString());
         print("nnn==="+newLat.toString());
         // Return latitude and longitude
        // return {'lat': lat, 'lng': lng};
       }
     }

     // If place not found, return null
    // return null;
   } catch (e) {
     // Handle errors
     print('Error fetching place coordinates: $e');
    // return null;
   }
 }


 // getLatLng(String placeName) async {
 //
 //   print("MAAAAAAPPPPP");
 //   String apiKey = 'AIzaSyDA-D-AYyDPASQgA2p98xxzZHXMusGcblk';
 //   //'AIzaSyBo94cx-aOPjxB9wyZjUqSf5v58qE4cQ3I';
 //   //'AIzaSyCKckCh7RP4ezDtY4F2m5CEV0Y8tfntDFk';
 //
 //   //'AIzaSyBCRjQbAjjWsve_mxS2qcO2moflRSffGoo';
 //   String encodedPlaceName = Uri.encodeQueryComponent(placeName);
 //   String url =
 //       'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedPlaceName&key=$apiKey';
 //
 //   final response = await http.get(Uri.parse(url));
 //   if (response.statusCode == 200) {
 //     print("///");
 //     print(response.body);
 //     print("///");
 //     print("200wwwweeeee");
 //     final decodedResponse = json.decode(response.body);
 //     final results = decodedResponse['results'];
 //
 //     if (results.isNotEmpty) {
 //       print("not empty");
 //       final location = results[0]['geometry']['location'];
 //       final lat = location['lat'];
 //       final lng = location['lng'];
 //       print(lat);
 //       print(lng);
 //
 //       newLat=lat;
 //       newLng=lng;
 //
 //
 //
 //       update();
 //
 //
 //
 //     }else{
 //       print("empty");
 //     }
 //   }
 //
 //   else{
 //     print("xxxx0000000");
 //
 //   }
 // //  return {'lat': 0.0, 'lng': 0.0};
 //   //return null;
 // }

 getCity(double lat, double lng, String apiKey) async {
   // Make Reverse Geocoding request
  try {
    final response = await http.get(Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$apiKey'));

    // Check if request was successful
    if (response.statusCode == 200) {
      print("CITY20000");
      // Parse response JSON
      Map<String, dynamic> responseData = jsonDecode(response.body);

      // Check if response contains results
      if (responseData.containsKey('results') &&
          responseData['results'].isNotEmpty) {
        print("new ressss========="+responseData['results'].toString());
        // Find city in address components
        List<
            dynamic> addressComponents = responseData['results'][0]['address_components'];
        for (var component in addressComponents) {
          List<dynamic> types = component['types'];
          if (types.contains('locality') || types.contains(
              'administrative_area_level_1')) {
            newCity=component['long_name'];
            print("cccityyyy2222===="+newCity);
            // Look for locality or administrative_area_level_1 (in case locality is not available)
            return component['long_name'];
          }
        }
      }
    }
  }catch(e){
    return null;
  }
   // If no city found, return null
   }

 addAdress(PredictedPlaces place,double lat
    , String city,String state
     ,double lng,String zipCode,
 PredictedPlaces predValue)
 async{
print("PL==="+place.toString());
print("LAT LNG HERE.........");
print(place.address);
print(lat);
print(lng);
print("...............");
final box=GetStorage();
String token=box.read('token')??"x";
print("TOKEN==="+token);
  var headers = {
  'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
};
var request = await http.post(
   Uri.parse('http://172.30.102.67:8000/addresses/'),
headers: {
  'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
},
body: json.encode({
  "street_address": place.main_text,
  //"4620 Trailwood Dr",
  "city": city,
  //"San Antonio",
  "state": state,
  "zip_code":int.parse(zipCode.toString()),
  "latitude": lat.toString(),
  "longitude":lng.toString()
})
);
 var responseBody =jsonDecode(request.body);
 print("add address api.....");
 print(responseBody);
 print(responseBody['area']);
  print(responseBody['id']);
 if(responseBody['area']==null){

   Get.to(SelectArea(
     id:responseBody['id'],
     place: predValue,
     lat: lat,
     lng:  lng,
     zipCode: zipCode
   ));
 }
 else{
   Map<String,dynamic>data={
     'area':responseBody['area'],
      'id':responseBody['id'],
     'city':city,
     'latitude':lat,
     'longitude':lng,
     'street_address':place.main_text
   };

   Get.to(ConfirmOrder(
       addressData: data
   ));
 }
 print("STATUS CODE=======API==="+request.statusCode.toString());
 getUserAddress('1', '0');
}

bool checkBox=false;
Color cardColor=Colors.grey;
Color cardColor2=Colors.grey;
Color cardColor3=Colors.grey;

changeColor(){
  cardColor=Colors.blue;
  cardColor2=Colors.grey;
    cardColor3=Colors.grey;
  update();
}
changeColor2(){
  cardColor2=Colors.blue;
  cardColor=Colors.grey;
  cardColor3=Colors.grey;
  update();
}
changeColor3(){
  cardColor3=Colors.blue;
  cardColor=Colors.grey;
  cardColor2=Colors.grey;
  update();
}



changeAddress(bool value) {
  checkBox=value;
  update();
}


List userAddress=[];

getUserAddress(String limit,String skip) async{
print("GET USER ADDRESS......");
  final box=GetStorage();
  //http://172.30.102.67:8000/addresses/?address_id=1&limit=10&skip=0
String token=box.read('token')??"x";
print("TOKEN==="+token);
  var headers = {
  'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
};

var request = await http.get(
   Uri.parse
   ('http://172.30.102.67:8000/addresses/?limit=10&skip=0'),

headers: {
  'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
},
// body: json.encode({

// }),
// body: json.encode({
//   "street_address": "4620 Trailwood Dr",
//   "city": "San Antonioxxx",
//   "state": "TX",
//   "zip_code":78228,
//   "latitude": "-98.57536388023871",
//   "longitude": "29.48428421991041"
// })
);
 var responseBody =jsonDecode(request.body);
 print("Address===xxxx====="+responseBody.toString());
 userAddress=responseBody;
 print("STATUS CODE=====22====="+request.statusCode.toString());
 update();
}  
}