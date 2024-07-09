



 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Settings/controllers/settings_controller.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:gic_client/core/widgets/custom_textformfield.dart';

class UpdateView extends StatelessWidget {
  Map<String,dynamic>data;

  UpdateView({super.key,required this.data});

   @override
   Widget build(BuildContext context) {

     SettingsController controller=Get.put(SettingsController());
     return Scaffold(
       appBar:CustomAppBar('',true, 50),
       body: Padding(
         padding: const EdgeInsets.all(8.0),
         child: ListView(children: [
           const SizedBox(height: 15,),
           CustomTextFormField(hint: data['first_name'],
               obx: false, ontap: (){
               }, type: TextInputType.text
               , obs:false, color: Colors.black
               , controller: controller.nameController),
           const SizedBox(height: 31,),
           CustomTextFormField(hint: data['email'],
           //'email'.tr,
               obx: false, ontap: (){
               }, type: TextInputType.text
               , obs:false, color: Colors.black
               , controller: controller.emailController),
           const SizedBox(height: 30,),

           CustomButton(text: 'update', onPressed:(){

             controller.updateData();
           }, color1: Colors.blue
               , color2: Colors.white)


         ],),
       ),
     );
   }
 }
