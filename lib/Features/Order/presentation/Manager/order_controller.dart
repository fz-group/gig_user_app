

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/Features/finsh_order/order_finishing.dart';
import 'package:gic_client/core/widgets/msg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/widgets/Custom_Text.dart';

class OrderController extends GetxController{


TextEditingController areaSpaceController=TextEditingController();

double price=1.0;
bool cardView=false;
 int selectedMachineType=0;
GoogleMapController? mapController;
LatLng currentLatLng = const LatLng(37.422004313390126,
    -122.08400756120682);
double zoom = 13.0;
double latx=37.422004313390126;
double lngx=-122.08400756120682;


List<XFile>? pickedImageXFiles;

XFile? pickedImageXFile;

final ImagePicker _picker = ImagePicker();




uploadImageToServer()async {
   
    try {
      var requestImgurApi = http.MultipartRequest(
          "POST",
          Uri.parse("https://api.imgur.com/3/image")
      );

      String imageName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();
      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] =
          "Client-ID " + "fb8a505f4086bd5";
      //"6ca0d6456311e4d";

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFile!.path,
        filename: imageName,
      );

      requestImgurApi.files.add(imageFile);
      var responseFromImgurApi = await requestImgurApi.send();

      var responseDataFromImgurApi = await responseFromImgurApi.stream
          .toBytes();
      var resultFromImgurApi = String.fromCharCodes(responseDataFromImgurApi);

      print("RESULT= = = $resultFromImgurApi");

      Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
      imageLink = (jsonRes["data"]["link"]).toString();
     // String deleteHash = (jsonRes["data"]["deletehash"]).toString();

    
    } catch (e) {
      print(e);
    }
  }

List<String> downloadUrls = [];

captureImage() async {
  pickedImageXFile = await _picker.pickImage(source: ImageSource.camera);
  Get.back();
  //pickedImageXFile;
  update();
}

pickImage() async {
  pickedImageXFile = await _picker.pickImage(source: ImageSource.gallery);
  Get.back();
  update();
  //   uploadImageToFirebaseStorage(pickedImageXFile!);
}

pickMultiImage() async {
  pickedImageXFiles = await _picker.pickMultiImage(
    imageQuality: 100,
  );
  update();
}

showIdDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          backgroundColor: Colors.white,
          title: Custom_Text(
            text: 'camera'.tr,
            alignment: Alignment.center,
            fontSize: 19,
            color: Colors.black,
          ),
          children: [
            SimpleDialogOption(
              child: Custom_Text(
                text: 'gallery'.tr,
                alignment: Alignment.center,
                fontSize: 14,
                color: Colors.black,
              ),
              onPressed: () {
                captureImage();
              },
            ),
            SimpleDialogOption(
                child: Custom_Text(
                  text: 'selectImage'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.black,
                ),
                onPressed: () {
                  pickImage();
                }),
            SimpleDialogOption(
                child: Custom_Text(
                  text: 'cancel'.tr,
                  alignment: Alignment.center,
                  fontSize: 14,
                  color: Colors.red,
                ),
                onPressed: () {
                  Get.back();
                })
          ],
        );
      });
}

void onMapCreated(GoogleMapController controller) {
  mapController = controller;
  update();
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

getPriceUsingAreaSpace(){

  cardView=true;
  price=double.parse(areaSpaceController.text.toString())*50;

update();

}

changeMachineType(int val){
  selectedMachineType=val;
  update();
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


List userBookingData=[];
getUserBooking(String limit,String skip) async{
  userBookingData=[];
  final box=GetStorage();
  String token=box.read('token')??"x";
  print("TOKEN==="+token);
  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $token'
  };
  var request = await
  http.get( Uri.parse
    ('http://172.30.102.67:8000/bookings/?limit=$limit&skip=$skip'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
  );
  var responseBody =jsonDecode(request.body);
  print("STATUS CODE=========="+request.statusCode.toString());
  print("ORDERdata=========="+request.body.toString());
  userBookingData=responseBody;
  print("userbooking====="+userBookingData.toString());
  if(request.statusCode==201){
   print("DONE BOOKINGS DATA......");

  }
  update();

}


 List imageLinks=[];
 String imageLink='';


Future<String> uploadImageToImgur(String imagePath) async {

  print("imagepath==="+imagePath);
  try {
    // Read image file as bytes
    File imageFile = File(imagePath);
    List<int> imageBytes = await imageFile.readAsBytes();
    
    // Encode image bytes to base64
    String base64Image = base64Encode(imageBytes);
    
    // Prepare POST request body
    Map<String, String> requestBody = {
      'image': base64Image,
    };
    // Send POST request to Imgur API
    final response = await http.post(
      Uri.parse('https://api.imgur.com/3/image'),
      headers: {
        'Authorization': "Client-ID " + "fb8a505f4086bd5",
        //'Client-ID $clientId',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );
    // Check if the request was successful
    if (response.statusCode == 200) {
      print("IMAGE200");
      // Parse response JSON
      Map<String, dynamic> responseData = jsonDecode(response.body);
      // Check if upload was successful
      if (responseData.containsKey('data') &&
          responseData['data'].containsKey('link')) {
            print(responseData['data']['link']);
            imageLink=responseData['data']['link'];
        // Image uploaded successfully
        return responseData['data']['link'];
      } else {
        print("ELSEEE IMAGE");
        // Image upload failed
        throw ('Image upload failed: ${response.body}');
      }
    } else {
      // Request failed
        print("ELSEEE 2222 IMAGE");
      throw ('Failed to upload image: ${response.statusCode}');
    }
  } catch (e) {
    // Handle errors
    print('Error uploading image: $e');
    return 'eee';
  }
}

    uploadImageToServerWithImgUr()async {
   
    print("IMAGEEEEEEE..................");
    try {
      var requestImgurApi = http.MultipartRequest(
          "POST",
          Uri.parse("https://api.imgur.com/3/image")
      );
      String imageName = DateTime
          .now()
          .millisecondsSinceEpoch
          .toString();

      requestImgurApi.fields['title'] = imageName;
      requestImgurApi.headers['Authorization'] =
          "Client-ID " + "fb8a505f4086bd5";
      //"6ca0d6456311e4d";

      var imageFile = await http.MultipartFile.fromPath(
        'image',
        pickedImageXFile!.path,
        filename: imageName,
      );

      requestImgurApi.files.add(imageFile);
      var responseFromImgurApi = await requestImgurApi.send();

      var responseDataFromImgurApi = await responseFromImgurApi.stream
          .toBytes();
      var resultFromImgurApi =
       String.fromCharCodes(responseDataFromImgurApi);

      print("RESULT= = = $resultFromImgurApi");
      Map<String, dynamic> jsonRes = json.decode(resultFromImgurApi);
      imageLink = (jsonRes["data"]["link"]).toString();
     // String deleteHash = (jsonRes["data"]["deletehash"]).toString();
     
    } catch (e) {

      print("CATCH.....");
      print(e); 
    }


    print("immmm==="+imageLink.toString());
  }


  addNewBooking(int addressId,String dateTime) async {

   print("ADDRESSID===="+addressId.toString());

    final box=GetStorage();
    String token=box.read('token')??"x";
    print("TOKEN==="+token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = await http.post( Uri.parse('http://172.30.102.67:8000/bookings/'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: json.encode({
          "service_id": 1,
          "address_id": 1,
          "booking_datetime": "2024-04-29T17:09:47.180Z",
          "notes": ".......",
          "photos":[]
          // "service_id": 0,
          // "address_id": addressId,
          // "booking_datetime": "2024-04-29T17:09:47.180Z",
          // //dateTime,
          // "notes": "......."
        })
    );
    var responseBody =jsonDecode(request.body);
    print("STATUS CODE=========="+request.statusCode.toString());
    print("data=========="+request.body.toString());

    if(request.statusCode==201){
      appMessage(text: 'Order Done');
      Get.offAll(const OrderFinishing());
      //Get.offAll(const MainHome());
    }
     Get.offAll(const OrderFinishing());
  }

   List<Map<String,dynamic>>userBookings=[];

  getUserBookings(String limit,String skip)async{
    final box=GetStorage();
    String token=box.read('token')??"x";
    print("TOKEN==="+token);
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = await http.get(Uri.parse
      ('http://172.30.102.67:8000/bookings/?limit=$limit&skip=$skip'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
    );
    var responseBody =jsonDecode(request.body);
    userBookings=responseBody;
    print("STATUS CODE=========="+request.statusCode.toString());
    update();
  }

}