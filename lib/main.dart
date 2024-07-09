import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/Features/payment/pay_view.dart';
import 'package:gic_client/core/binding/binding.dart';
import 'Features/Auth/presentation/views/login_view.dart';
import 'core/resources/color_manager.dart';

void main() async{
  
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MainApp());

}

class MainApp extends StatefulWidget {

  const MainApp({super.key});
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final box=GetStorage();
  @override
  void initState() {

String token=box.read('token')??"x";
Future.delayed(const Duration(seconds: 2)).then((value) {
if(token!='x'){
//Get.offAll(const MainHome());

  Get.offAll(PaymentView ());  
  
  //Get.offAll(PaymentView ());
} 

 else{
  Get.offAll(PaymentView ());
// ignore: prefer_const_constructors
// Get.offAll(LoginView());
  }
    });
 super.initState();
}

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding:MyBinding(),
        debugShowCheckedModeBanner: false,
        title: '',
        color:ColorManager.primary,
        theme: ThemeData(
            primarySwatch: Colors.red,
            appBarTheme:AppBarTheme(color:ColorManager.primary)
        ),
        home://FavProductsView()
       const MainHome()
    );
  }
}
