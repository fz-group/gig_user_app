


 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Auth/presentation/Manager/authController.dart';
import 'package:gic_client/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_textformfield.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

  AuthController controller=Get.put(AuthController());
     
    return Scaffold(
    body:Padding(
      padding: const EdgeInsets.all(28.0),
      child: ListView(
        children: [
          const SizedBox(height: 21,),
          Row(
            children: [

              const SizedBox(width: 21,),
              Custom_Text(text: 'Welcome Back!',fontSize: 22
                ,color: ColorManager.textColorDark,fontWeight:FontWeight.w700,),
              const SizedBox(width: 21,),
              Image.asset('assets/images/hand.png')
            ],
          ),
          const SizedBox(height: 21,),
          Custom_Text(text: 'Enter Your Phone Number ',fontSize: 22
            ,color: ColorManager.textColorDark,fontWeight:FontWeight.w700,),
          const SizedBox(height: 15,),
          CustomTextFormField(hint: 'Phone Number', obx: false
              , ontap: (){}, type: TextInputType.emailAddress
              , obs: false
              , color: ColorManager.textColorDark, controller: controller.phoneController),
          const SizedBox(height: 17,),
          // CustomTextFormField(hint: 'Password', obx: false
          //     , ontap: (){}, type: TextInputType.emailAddress
          //     , obs: false
          //     , color: ColorManager.textColorDark, controller: controller.passController),
    
          CustomButton(text: 'Continue', onPressed: (){
          
            print("lllllogin");

            controller.userLogin();


          }, color1: ColorManager.primary, color2: ColorManager.textColorLight),
          const SizedBox(height: 22,),
          Divider(
            color:Colors.grey[400],
          ),
          const SizedBox(height: 15,),
          Custom_Text(text: 'Or Continue With',color:ColorManager.helpColor,
          fontSize:15,fontWeight:FontWeight.w700,alignment:Alignment.topLeft,
          ),
          const SizedBox(height: 15,),
          InkWell(
            child: Card(
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const SizedBox(width: 51,),
                    Image.asset('assets/images/google.png'),
                    const SizedBox(width: 21,),
                    Custom_Text(text: 'Countinue With Google',color:ColorManager.textColorDark,
                    fontSize: 18,fontWeight:FontWeight.w700,
                    )
                  ],
                ),
              ),
            ),
            onTap: (){
              Get.to(const SignUpView());

            },
          )
        ],
      ),
    ),
    );

  }
}
