


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Auth/presentation/Manager/authController.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:gic_client/core/widgets/custom_textformfield.dart';

class SignUpView extends StatelessWidget {
  const SignUpView ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   AuthController controller=Get.put(AuthController());

    return Scaffold(
      appBar:CustomAppBar('Sign Up', true, 50),
      body:Padding(
        padding: const EdgeInsets.all(28.0),
        child: ListView(
          children: [
            const SizedBox(height: 21,),
            Custom_Text(text: 'Fill Your Profile',fontSize: 22
              ,color: ColorManager.textColorDark,alignment:Alignment.center
              ,fontWeight:FontWeight.w700,),

            const SizedBox(height: 21,),

            SizedBox(
              height: 92,
              child: Image.asset('assets/images/addImg.png'),
            ),
            const SizedBox(height: 21,),
            Custom_Text(text: 'Enter Your Phone Number ',fontSize: 22
              ,color: ColorManager.textColorDark,
              fontWeight:FontWeight.w500,),
            const SizedBox(height: 15,),
            CustomTextFormField(hint: 'Phone Number', obx: false
                , ontap: (){}, type: TextInputType.emailAddress
                , obs: false
                , color: ColorManager.textColorDark, 
                controller: controller.phoneController,),
            const SizedBox(height: 21,),
            Custom_Text(text: 'Enter Your Email ',fontSize: 22
              ,color: ColorManager.textColorDark,
              fontWeight:FontWeight.w500,),
            const SizedBox(height: 15,),
            CustomTextFormField(hint: 'Email', obx: false
                , ontap: (){}, type: TextInputType.emailAddress
                , obs: false
                , color: ColorManager.textColorDark, controller: controller.emailController),
            const SizedBox(height: 21,),
            Custom_Text(text: 'Enter Your Name ',fontSize: 22
              ,color: ColorManager.textColorDark,
              fontWeight:FontWeight.w500,),
            const SizedBox(height: 15,),
          
            CustomTextFormField(hint: 'Name', obx: false
                , ontap: (){}, type: TextInputType.emailAddress
                , obs: false
                , color: ColorManager.textColorDark, controller:controller.nameController),
            
            const SizedBox(height: 31,),

            CustomButton(text: 'Signup', onPressed: (){

              controller.userRegister();

            }, color1: ColorManager.primary, color2: ColorManager.textColorLight),
            const SizedBox(height: 22,),
           
          ],
        ),
      ),
    );

  }
}
