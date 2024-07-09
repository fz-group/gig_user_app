

// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';

PreferredSizeWidget CustomAppBar(String text,bool leading,double height){

  return AppBar(
      toolbarHeight: height,
      elevation:0.0,
      backgroundColor:ColorManager.appBarColor,
      title:Custom_Text(text: text,
        fontSize: 21,color:ColorManager.textColorLight,
        alignment:Alignment.center,
      ),
      leading:(leading==true)?
      IconButton(onPressed: (){
        Get.back();
      }, icon: Icon(Icons.arrow_back_ios,size: 28,
        color:ColorManager.iconColor,
      ))
          :const SizedBox()
  );
}