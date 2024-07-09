

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Order/presentation/Manager/order_controller.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Manager/map_controller.dart';

class UserOrdersView extends StatefulWidget {
  const UserOrdersView({super.key});

  @override
  State<UserOrdersView> createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends State<UserOrdersView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  OrderController controller=Get.put(OrderController());
  MapController mapController=Get.put(MapController());

  @override
  void initState() {
    controller.getUserBooking('10', '0');
    super.initState();
    _controller = AnimationController(vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body:Padding(
        padding:  const EdgeInsets.all(8.0),
        child: GetBuilder<OrderController>(
          builder: (_) {
            return ListView(children: [
              const SizedBox(height: 6,),
              OrdersWidget()
            ],);
          }
        ),
      ),
    );
  }
  Widget OrdersWidget(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
        itemCount: controller.userBookingData.length,
        itemBuilder: (context,index){
          return Padding(
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
                    Column(children: [
                      Custom_Text(text:controller.userBookingData[index]
                      ['service']['name'],
                      ),
                  
                       const SizedBox(height: 10,),
                       Custom_Text(text:controller.userBookingData[index]
                      ['booking_datetime'],
                       color:Colors.blue,fontSize: 15,
                       ), const SizedBox(height: 10,),
                       Custom_Text(text:

                       "TOTAL = "+controller.userBookingData[index]
                      ['total_price'].toString().substring(0,6)
                       +"  "  +"\$",
                       fontWeight: FontWeight.bold,
                       color:Colors.black,fontSize: 15,
                       ),
                    //status: Awaiting Payment, total_price: 3318.89955
                    ],),
                    Container(
                      decoration:BoxDecoration(
                        color:Colors.blue,
                        borderRadius:BorderRadius.circular(15)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Custom_Text(
                          fontSize: 14,color:Colors.white,
                           text: controller.userBookingData[index]
                           ['status'],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );

    });
  }
}