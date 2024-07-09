

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../resources/color_manager.dart';


 appMessage ({required String text}){
  Get.snackbar ("   $text ", '',colorText:Colors.white,
      backgroundColor:ColorManager.primary.withOpacity(0.4),
      icon:const Icon(Icons.app_shortcut,color:Colors.white,size:33,)
  );
 }