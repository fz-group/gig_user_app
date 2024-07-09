

import 'dart:convert';
import 'dart:io';
import 'package:gic_client/Features/Order/dateTimeView.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/view/home_view.dart';
import 'package:gic_client/Features/Order/presentation/Manager/order_controller.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../Home/presentation/Manager/home_controller.dart';

// ignore: must_be_immutable
class ConfirmOrder extends GetView<OrderController> {

  Map<String,dynamic>addressData;

   ConfirmOrder({super.key,required this.addressData});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(OrderController());
    return  Scaffold(
      backgroundColor:Colors.grey[100],
      appBar: CustomAppBar('Order', true, 55),
      body:GetBuilder<OrderController>(
        builder: (_) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Container(
                  decoration:BoxDecoration(
                      color:ColorManager.backColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Column(
                    children: [
                      const SizedBox(height: 10,),
                      Custom_Text(
                        text: 'Please Select Images ',
                        color:ColorManager.textColorDark,
                        fontSize: 32,alignment:Alignment.center,
                      ),
                      const SizedBox(height: 2,),
                      (controller.pickedImageXFiles != null &&
                          controller
                              .pickedImageXFiles!.isNotEmpty)
                          ? Column(children: [
                        const SizedBox(
                          height: 10,
                        ),
                        for (int i = 0;
                        i <
                            controller
                                .pickedImageXFiles!.length;
                        i++)
                          Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: ColorManager.primary,
                                      width: 2),
                                  borderRadius:
                                  BorderRadius.circular(15)),
                              child: Padding(
                                padding:
                                const EdgeInsets.all(6.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: InkWell(
                                        child: Container(
                                          height:
                                          MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.41,
                                          width:
                                          MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.6,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: FileImage(
                                                      File(controller
                                                 .pickedImageXFiles![i].path)),
                                                  fit:
                                                  BoxFit.fill)),
                                        ),
                                        onTap: () {
                                          controller.pickMultiImage();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ])
                          : InkWell(
                        child: Column(
                          children: [
                            Custom_Text(
                              text: 'addImage'.tr,
                              color: ColorManager.textColorLight,
                              fontSize: 21,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const CircleAvatar(
                                radius: 100,
                                child: Icon(
                                  Icons.image,
                                  size: 60,
                                )),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        onTap: () {
                          controller.pickMultiImage();
                          //  cubit.showDialogBox(context);
                        },
                      ),
                      const SizedBox(height: 10,),
                      CustomButton(text: 'Next',
                          onPressed: (){

    // controller. uploadImageToServerWithImgUr();
     controller.uploadImageToImgur
     (controller.pickedImageXFiles!.first.path).then((value) {

        print("addressData==="+addressData.toString());
        
        Get.to(DataTimeView(
                             addressData: addressData,
                             images:  [
                              controller.imageLink
                             ],
                           ));
     });
                          
                          }, color1: ColorManager.primary
                          , color2: ColorManager.textColorLight),
                      const SizedBox(height: 1000,),
                    ],
                  )
                ) ),
              ]);
        }
      ));
  }

  sendNotificationNow
      ({required String token}) async

  {
    var responseNotification;
    Map<String, String> headerNotification =
    {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAAWHG8Sps:APA91bGQmUYtZDTPbg5ZmgwjPlpsSHFGItJ_PPu8dj1rGdz_AyHdDYV3IJiKxr6p7xMVDXah1b1qJDriSy6SjKehQtjDtgk1HbWTSX5SarDeQ3I2LhzyJCdBD3QOtVrmofHb5rptn0mV'
      // 'key=AAAAppETApU:APA91bEqhmHIiv1RdM9-Ozw66PL7u9JBR0bOq7GlUA7wcnn6rsDoXz7AKqje96Z8ph0t9k0xXh4ghdN3XYjTOEkbCllJka88HTSiZhyeyHJbmoBvdh2jCv1DeOfVs6dU6IouS4XD5Ebl'
    };
    Map bodyNotification =
    {
      "body":" طلب جديد علي متجرك  ",
      "title":" عرض الطلب الان   "
    };
    Map dataMap =
    {
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
      "id": "1",
      "status": "done",
      //   "rideRequestId": docId
    };


    Map officialNotificationFormat =
    {
      "notification": bodyNotification,
      "data": dataMap,
      "priority": "high",
      "to": token,
    };

    try{
      print('try send notification');
      responseNotification = http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: headerNotification,
        body: jsonEncode(officialNotificationFormat),
      ).then((value) {
        print('NOTIFICATION SENT ==$value');
      });
    }
    catch(e){
      print("NOTIFICATION ERROR===$e");
    }
    return   responseNotification;

  }


// void onCameraMove(CameraPosition position) {
  //   print("move");
  // latLng = position.target;
  //   print('////////////////');
  //   update();
  // }
}
