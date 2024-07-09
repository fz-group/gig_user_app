

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/BottomBar/main_home.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/Features/Home/presentation/view/home_view.dart';
import 'package:gic_client/Features/Order/presentation/Manager/order_controller.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:gic_client/core/widgets/msg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class FinishOrderView extends StatelessWidget {
  String date,time,type,area,price;
  FinishOrderView({super.key,
  required this.date,required this.price,required this.area,
  required this.time,required this.type
  });

  @override
  Widget build(BuildContext context) {

    final controller=Get.put(HomeController());

   OrderController orderController=Get.put(OrderController());

    return  Scaffold(
      appBar:CustomAppBar('',true, 55),
      body:
              Stack(
              children: [
                   SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: GoogleMap(
                          myLocationEnabled: true,
                          onCameraMove: controller.onCameraMove,
                          initialCameraPosition: CameraPosition(
                            target: controller.currentLatLng,
                            //  zoom: controller.zoom,
                          ),
                          polygons: {
                            Polygon(
                              polygonId: const PolygonId('rectangle'),
                              points: rectangleCoords,
                              fillColor: Colors.blue.withOpacity(0.3),
                              strokeColor: Colors.blue,
                              strokeWidth: 2,
                            )
                          },
                          circles: {
                            Circle(
                              circleId: const CircleId('1'),
                              center: controller.currentLatLng,
                              radius: 430,
                              strokeWidth: 2
                            )
                          },
                          markers: {
                            Marker(
                                markerId: const MarkerId('1'),
                                position: controller.currentLatLng,
                                icon: BitmapDescriptor.defaultMarker
                            ),
                          },
                          onMapCreated: controller.onMapCreated,
                          mapType: MapType.normal,
                        ),
                      ),
               
              Positioned(
                bottom: 1,
                child: Container(
                  height: 320,
                  
                  width: MediaQuery.of(context).size.width,
                      decoration:BoxDecoration(
                        border:Border.all(color:Colors.black),
                        color:ColorManager.textColorLight,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child:
                      
                      ListView(children: 
                      [

const SizedBox(height: 11,),

              //time
                      Row(
                        mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                            //const SizedBox(height: 5,),
                            const Custom_Text(text: 'Time',
                          fontSize: 24,
                          alignment: Alignment.center,),
                         
                         Custom_Text(text: time,
                          fontSize: 17,
                          color:Colors.grey,
                          alignment: Alignment.center,),

                            ],
                          ),

                          const SizedBox(height: 11,),
         const Divider(),
                        // date
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                           // const SizedBox(height: 5,),
                            const Custom_Text(text: 'Date',
                          fontSize: 24,
                          alignment: Alignment.center,),
                         // const SizedBox(height: 11,),
                         Custom_Text(text: date,
                          fontSize: 18,
                           color:Colors.grey,
                          alignment: Alignment.center,),
                            ],
                          ),
                         

 const SizedBox(
                            height: 11,
                          ),

                            const Divider(),
                           Row(
                            mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                           
                            const Custom_Text(text: 'Area',
                          fontSize: 24,
                          alignment: Alignment.center,),
                         
                         Custom_Text(text: area,
                          fontSize: 18,
                           color:Colors.grey,
                          alignment: Alignment.center,),
                            ],
                          ),

                          const SizedBox(
                            height: 11,
                          ),
                            const Divider(),
                         Row(
                          mainAxisAlignment:MainAxisAlignment.spaceAround,
                            children: [
                          //  const SizedBox(height: 5,),
                            const Custom_Text(text: 'Service Cost',
                          fontSize: 24,
                          alignment: Alignment.center,),
                          //const SizedBox(height: 11,),
                         Custom_Text(text: price,
                          fontSize: 18,
                           color:Colors.grey,
                          alignment: Alignment.center,),

                            ],
                          ),

 
                          const SizedBox(height: 12,),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(text: 'Confirm Order', 
                            onPressed: (){


                              // appMessage(text: 'Order Done');

                              // Get.offAll(const MainHome ());
                            }, color1: ColorManager.primary, color2:
                             ColorManager.textColorLight),
                          ),
                           const SizedBox(height: 11,),
              
                      ]),
                    ),
              )
                 ],
               ),
    );


  }


}