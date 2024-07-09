

 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/Features/finsh_order/order_sorry.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';

import '../../core/widgets/Custom_Text.dart';

class OrderFinishing extends StatefulWidget {
  const OrderFinishing({super.key});

  @override
  State<OrderFinishing> createState() => _OrderFinishingState();
}

class _OrderFinishingState extends State<OrderFinishing> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar:CustomAppBar('', false, 50),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomButton(
          color1:ColorManager.buttonColor,
          color2: ColorManager.buttonColor2,
          text: 'Return Home', onPressed:() {

            Get.offAll (const MainHome());
          
        }),
      ),
      body:Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(children: [
          const SizedBox(height: 10,),
          Column(
            mainAxisAlignment:MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 100,
                child: Image.asset('assets/images/done.png')),
                  Row(
                  mainAxisAlignment:MainAxisAlignment.center,
                   children: [
                     const Custom_Text(text: 'Order Done',
                                 fontSize: 20,color:Colors.green,
                                 ),
  
                        const SizedBox(width: 66,),
                                
                                 InkWell(
                                   child: const Text("TEST FAIL",
                                   style:TextStyle(color:Colors.red,
                                   fontSize: 16
                                   ),
                                   ),
                                   onTap:(){

                                    Get.to(const OrderFailed());

                                   },
                                 )
                   ],
                 ),
            ],
          ),
           
            const SizedBox(height: 10,),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(12),
                color:Colors.grey[200]
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(children: [
                      SizedBox(
                        width: 188,
                        child: Custom_Text(text:'service Name',
                        fontSize: 19,
                        ),
                      ),
                  
                       SizedBox(height: 10,),
                       SizedBox(
                        width: 188,
                         child: Custom_Text(text:'12-12-2024',
                         //controller.userBookingData[index]
                                              // ['booking_datetime'],
                         color:Colors.blue,fontSize: 15,
                         ),
                       ), SizedBox(height: 10,),
                       SizedBox(

                        width: 188,
                         child: Custom_Text(text:
                         
                         "TOTAL = "+"1200 \$",
                                               //  controller.userBookingData[index]
                                               // ['total_price'].toString().substring(0,6)
                                               //  +"  "  +"\$",
                         fontWeight: FontWeight.bold,
                         color:Colors.black,fontSize: 15,
                         ),
                       ),
                    //status: Awaiting Payment, total_price: 3318.89955
                    ],),
                    Container(
                      decoration:BoxDecoration(
                        color:Colors.blue,
                        borderRadius:BorderRadius.circular(15)
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Custom_Text(
                          fontSize: 14,color:Colors.white,
                           text: "AWAITING PAYMENT",
                          //  controller.userBookingData[index]
                          //  ['status'],
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),

            )
          ),



        ],),
      ),
    );
  }
}
