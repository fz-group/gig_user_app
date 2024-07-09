import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/Features/Home/presentation/view/home_view.dart';
import 'package:gic_client/Features/Order/presentation/Manager/order_controller.dart';
import 'package:gic_client/Features/Order/presentation/view/finsh_order_view.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


 class DataTimeView extends StatefulWidget {

  Map<String,dynamic>addressData;
  List<String>images;

  DataTimeView({super.key,required this.addressData,
  required this.images
  });
  @override
  State<DataTimeView> createState() => _DataTimeViewState();
}

class _DataTimeViewState extends State<DataTimeView> {


   LatLng latLng=const LatLng(0.0, 0.0);

   @override
  void initState() {
   latLng=LatLng
     (double.parse(widget.addressData['latitude'].toString()),
     double.parse(
         widget.addressData['longitude'].toString()));
   print("LLLL======="+latLng.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(HomeController());
    final orderController=Get.put(OrderController());
    return  Scaffold(
      appBar:CustomAppBar('',true, 55),
      body:

              Stack(
                 children: [

                   GetBuilder<HomeController>(
                       builder: (_) {
                         return SizedBox(
                           height: MediaQuery.of(context).size.height*0.99,
                           child: GoogleMap(
                             myLocationEnabled: true,
                             onCameraMove: controller.onCameraMove,
                             initialCameraPosition: CameraPosition(
                               target: latLng,
                               //controller.currentLatLng,
                               zoom: controller.zoom,
                             ),
                             onMapCreated: controller.onMapCreated,
                             mapType: MapType.normal,
                           ),
                         );
                       }
                   ),
                   // SizedBox(
                   //      height: MediaQuery.of(context).size.height,
                   //      child: GoogleMap(
                   //        myLocationEnabled: true,
                   //        onCameraMove: controller.onCameraMove,
                   //        initialCameraPosition: CameraPosition(
                   //          target:latLng
                   //          //controller.currentLatLng,
                   //          //  zoom: controller.zoom,
                   //        ),
                   //        polygons: {
                   //          Polygon(
                   //            polygonId: const PolygonId('rectangle'),
                   //            points: rectangleCoords,
                   //            fillColor: Colors.blue.withOpacity(0.3),
                   //            strokeColor: Colors.blue,
                   //            strokeWidth: 2,
                   //          )
                   //        },
                   //        circles: {
                   //          Circle(
                   //            circleId: const CircleId('1'),
                   //            center: controller.currentLatLng,
                   //            radius: 430,
                   //            strokeWidth: 2
                   //          )
                   //        },
                   //        markers: {
                   //          Marker(
                   //              markerId: const MarkerId('1'),
                   //              position: controller.currentLatLng,
                   //              icon: BitmapDescriptor.defaultMarker
                   //          ),
                   //        },
                   //        onMapCreated: controller.onMapCreated,
                   //        mapType: MapType.normal,
                   //      ),
                   //    ),

              Positioned(
                bottom: 1,
                child: Container(
                  height: 240,
                  width: MediaQuery.of(context).size.width,
                      decoration:BoxDecoration(
                        color:ColorManager.textColorLight,
                        borderRadius: BorderRadius.circular(12)
                      ),
                      child:Column(children: [

                          const SizedBox(height: 5,),
                          const Custom_Text(text: 'Date',
                          fontSize: 24,
                          alignment: Alignment.center,),
                          InkWell(
                            child:Container(

                              decoration:BoxDecoration(
                                color:Colors.grey[300],
                                borderRadius:BorderRadius.circular(7)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GetBuilder<HomeController>(
                                  builder: (con) {
                                    return Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                                      children: [
                                        //  const SizedBox(width: 24,),
                                        Icon(Icons.date_range,
                                        color:ColorManager.primary,
                                        size: 26,
                                        ),

                                        const Custom_Text(text: 'Enter Date',
                                        fontSize: 19,alignment:Alignment.center,
                                        ),

                                       (controller.dateTime!='')?
                                       Custom_Text(text: controller.dateTime.toString()
                                       .replaceAll('00:00:00.000', '')
                                       ,
                                        fontSize: 14,alignment:Alignment.center,
                                        color:Colors.grey,
                                        ): const Custom_Text(text: '12/1/2023',

                                        fontSize: 14,alignment:Alignment.center,
                                        color:Colors.grey,
                                        )

                                      ],
                                    );
                                  }
                                ),
                              ),
                            ),
                            onTap:() async {
                               var datePicked = await DatePicker.showSimpleDatePicker(
                    context,
                    initialDate: DateTime(2024, 1, 1),
                    firstDate: DateTime(2024,1,1),
                    lastDate: DateTime(2033, 12, 31),
                    dateFormat: "dd-MMMM-yyyy",
                    locale: DateTimePickerLocale.en_us,
                    looping:false,
                  );
                  print(datePicked);
                  controller.selectDate(datePicked);
                            },
                          ),

                     const SizedBox(height: 5,),

                          const Custom_Text(text: ' Time',
                          fontSize: 24,
                          alignment: Alignment.center,),
                          InkWell(
                            child:Container(

                              decoration:BoxDecoration(
                                color:Colors.grey[300],
                                borderRadius:BorderRadius.circular(7)
                              ),
                              child:Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GetBuilder<HomeController>(
                                  builder: (con) {
                                    return Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                                      children: [

                                        Icon(Icons.timelapse,
                                        color:ColorManager.primary,
                                        size: 26,
                                        ),

                                        const Custom_Text(text: 'Enter Time',
                                        fontSize: 19,alignment:Alignment.center,
                                        ),


                                       Custom_Text(text: controller.time.toString()
                                       .replaceAll('TimeOfDay', '')
                                       ,
                                        fontSize: 19,alignment:Alignment.center,
                                        color:Colors.grey,
                                        ),

                                      ],
                                    );
                                  }
                                ),
                              ),
                            ),
                            onTap:() async {
                              Navigator.of(context).push(
            showPicker(
                context: context,
                value: controller.time,
                sunrise: const TimeOfDay(hour: 6, minute: 0), // optional
                sunset: const TimeOfDay(hour: 18, minute: 0), // optional
                duskSpanInMinutes: 120, // optional
                onChange:(val){
                  controller.onTimeChanged(val);
                }
            ),
        );
          },
                          ),
                          const SizedBox(height: 12,),
                          CustomButton(text: 'Confirm',
                          onPressed: (){
                            
                            print("addressDATA===="+widget.addressData.toString());
                            print("addressDATA===="+widget.addressData['id'].toString());
                            //1994-01-01 00:00:00.000-TimeOfDay(21:30)
                            orderController.addNewBooking
                              (widget.addressData['id']??0
                                ,controller.dateTime.toString()+
                                    " TimeOfDay"+"("+controller.time.toString()+")" );
                           // Get.to(FinishOrderView(
                           //  time: '7 pm ',
                           //  date: '12/6/2024',
                           //  price: '350',
                           //  area: '99 M2',
                           //  type:"Car Machine"
                           // ));

                          }, color1: ColorManager.primary, color2:
                           ColorManager.textColorLight)

                      ]),
                    ),
              )

                 ],
               ),

    );

  }
}



