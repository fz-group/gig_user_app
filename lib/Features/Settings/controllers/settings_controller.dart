

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/core/widgets/msg.dart';
import 'package:http/http.dart' as http;

class SettingsController extends GetxController{


Map<String,dynamic>userData={};
TextEditingController nameController=TextEditingController();
TextEditingController emailController=TextEditingController();

getUserData()
   async{
final box=GetStorage();
String token=box.read('token')??"x";
print("TOKEN==="+token);


var request = await http.get( Uri.parse('http://172.30.102.67:8000/users/'),
headers: {
  'Content-Type': 'application/json',
  'Authorization': 'Bearer $token'
},
);
 var responseBody =jsonDecode(request.body);
  print('responseBody==='+responseBody.toString());
userData=responseBody;
update();
}


updateUserData()

async{

  print(userData);
  String fName='';
  String email='';

  if(nameController.text.length>2){
    fName=nameController.text;
  }else{
    fName=userData['first_name'];
  }
  if(emailController.text.length>2){
    print('eee');
    email=emailController.text;
  }else{
    email=userData['email'];
  }




  final box=GetStorage();
  String token=box.read('token')??"x";
  print("TOKEN==="+token);

  var request = await http.post
    (Uri.parse('http://172.30.102.67:8000/users/'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
    body: json.encode({
  "first_name": fName,
  "last_name": userData['last_name'],
  "phone_number":userData['phone'],
  "email": email
    })
  );
  var responseBody =jsonDecode(request.body);
  print('responseBody==='+responseBody.toString());
  print('responseBody==='+request.statusCode.toString());
  //userData=responseBody;
  update();
}



updateData()async{
  print(userData);
  String fName='';
  String email='';

  if(nameController.text.length>2){
    fName=nameController.text;
  }else{
    fName=userData['first_name'];
  }
  if(emailController.text.length>2){
    print('eee');
    email=emailController.text;
  }else{
    email=userData['email'];
  }




  final box=GetStorage();
  String token=box.read('token')??"x";
  print("TOKEN==="+token);

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer '+token,
  };
  var request = http.Request('GET',
      Uri.parse('http://172.30.102.67:8000/users/'));
  request.body = json.encode({
    "first_name": fName,
    "last_name": userData['last_name'],
    "phone_number": userData['phone_number'],
    "email": email,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    print(await response.stream.bytesToString());
    appMessage(text: 'Updated');
    Get.offAll(const MainHome());
  }
  else {
    print(response.reasonPhrase);
  }
}

}