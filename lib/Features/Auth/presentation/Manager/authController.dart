


// ignore_for_file: avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gic_client/Features/Auth/presentation/views/OtpView.dart';
import 'package:gic_client/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/core/widgets/msg.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class AuthController extends GetxController{

TextEditingController emailController=TextEditingController();
TextEditingController passController=TextEditingController();
TextEditingController nameController=TextEditingController();
TextEditingController phoneController=TextEditingController();
TextEditingController lastNameController=TextEditingController();
TextEditingController otpController=TextEditingController();
  

   userRegister()async{
    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://172.30.102.67:8000/users/'));
request.body = json.encode({
  "first_name": nameController.text,
  "last_name": lastNameController.text,
  "phone_number": phoneController.text,
  "email": emailController.text
});
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200 || response.statusCode == 201) {
  print("DONE");
  print(await response.stream.bytesToString());
  Get.to(OtpView(phone_number: phoneController.text,));

}
else {
  print(response.reasonPhrase);
}
   }


userLogin()async{
     print("HERE LOGIN");
    var headers = {
  'Content-Type': 'application/json'
};
var request = http.Request('POST', Uri.parse('http://172.30.102.67:8000/otp'));
request.body = json.encode({
"phone_number": phoneController.text,
});

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();


 print('resssssss==='+response.statusCode.toString());

 if (response.statusCode == 200 || response.statusCode == 201) {
  print("DONE");
  Get.to(OtpView(phone_number: phoneController.text));
  //Get.offAll(const MainHome());
  print("responseeee===="+await response.stream.bytesToString());
}

else {
  appMessage(text: 'Fill Your Profile');
  Get.to(const SignUpView());
  print(response.reasonPhrase);
}
   }


   checkOtp(String phone_number,String otp)async{
 final box=GetStorage();
    var headers = {
  'Content-Type': 'application/json'
};
var request = await http.post( Uri.parse('http://172.30.102.67:8000/oauth'),
headers: {
  'Content-Type': 'application/json'
},
body: json.encode({
"phone_number": phone_number,
  "otp": otp
})
);
 var responseBody =jsonDecode(request.body);
 print("res505050======"+responseBody.toString());//access_token
 print('res===='+responseBody['access_token'].toString());
box.write('token', responseBody['access_token'].toString());
 Get.offAll(const MainHome());
// request.body = json.encode({

// "phone_number": phone_number,
//   "otp": otp
// });

//request.headers.addAll(headers);

//http.StreamedResponse response = await request.send();

// if (response.statusCode == 200 || response.statusCode == 201) {
//   print("DONE");
//   print(await response.stream.bytesToString());
//   print("...");
//   stringToMapFuture(response.stream.bytesToString());

//   Future.delayed(const Duration(seconds: 2)).then((value) {
//     String token=dataMap['access_token'];
//     print("TOKENNNNN=="+token);
//     box.write('token', token);
//     Get.offAll(const MainHome());
//   });
   // print(await response.stream.toString());
  

  // box.write('token', response.stream.bytesToString());
  // Map<String,dynamic>data=response.stream.bytesToString();
   // Map<String, dynamic> dataMap = json.decode(response.stream.toString());
  
}


//else {
  // print(response.statusCode);
  // print(response.reasonPhrase);
//}
 //  }
 

  
  
  
  
 

 


  
}