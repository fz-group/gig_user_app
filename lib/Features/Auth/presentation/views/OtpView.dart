


// ignore_for_file: unused_local_variable, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Auth/presentation/Manager/authController.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';


// ignore: must_be_immutable
class OtpView extends StatefulWidget {
  
  String phone_number;
 
  OtpView({super.key,required this.phone_number});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {

  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;

  AuthController authController=Get.put(AuthController());


  @override
  void initState() {
    super.initState();
    _initInteractor();
    controller = OTPTextEditController(
      codeLength: 6,
      //ignore: avoid_print
      onCodeReceive: (code) => print('Your Application receive code - $code'),
      otpInteractor: _otpInteractor,
    )..startListenUserConsent(
          (code) {
        final exp = RegExp(r'(\d{6})');
        return exp.stringMatch(code ?? '') ?? '';
      },
      // strategies: [
      //   SampleStrategy(),
      // ],
    );
  }

  Future<void> _initInteractor() async {
    _otpInteractor = OTPInteractor();

    // You can receive your app signature by using this method.
    final appSignature = await _otpInteractor.getAppSignature();
  }

  @override
  void dispose() {
    controller.stopListen();
    super.dispose();
  }
String otpCode='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:

      Column(
        children: [
          const SizedBox(height: 74,),
          const Custom_Text(text: 'Verification Code Sent to Your device',
          fontSize: 19,alignment: Alignment.center,
          ),
          const SizedBox(height: 66,),
          Center(
            child: OTPTextField(
               // controller:aut otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 33,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: const TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {

                otpCode=pin;
                  print("Completed: " + pin);
                }),
          ),
           SizedBox(height:
          MediaQuery.of(context).size.height*0.50,),
          Row(
            children: [
              const SizedBox(width: 40,),
              Custom_Text(text: 'didnt recieve the code ? ',
              fontSize: 18,color:ColorManager.primary,
              ),
              const SizedBox(width: 15,),
              InkWell(
                child: Custom_Text(text: 'Resend Code ',
                  fontSize: 16,color:ColorManager.textColorDark,
                ),
                onTap:(){

                },
              ),
            ],
          ),
          const SizedBox(height: 10,),
          SizedBox(
            width: 321,
            child: CustomButton(text: 'Confirm'
                , onPressed: (){

                authController.checkOtp(widget.phone_number,otpCode);
                
                }, color1:ColorManager.primary,
                color2: ColorManager.textColorLight),
          )
        ],
      ),
    );
  }
}
