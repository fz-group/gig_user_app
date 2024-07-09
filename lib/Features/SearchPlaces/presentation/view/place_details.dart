
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/resources/color_manager.dart';
import '../../../Home/presentation/view/home_view.dart';
import '../../../Order/presentation/view/confirm_order.dart';

// ignore: must_be_immutable
class PlacesDetails extends StatelessWidget {
  Map<String, dynamic> userAddress;

  PlacesDetails({super.key,required this.userAddress});

  @override
  Widget build(BuildContext context) {
    HomeController controller=Get.put(HomeController());
    print("DATA========="+userAddress.toString());
    return Scaffold(
      appBar:CustomAppBar('', true,50),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: [

          GetBuilder<HomeController>(
              builder: (_) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height*0.5,
                  child: GoogleMap(
                    myLocationEnabled: true,
                    onCameraMove: controller.onCameraMove,
                    initialCameraPosition: CameraPosition(
                      target: controller.currentLatLng,
                      zoom: controller.zoom,
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
                );
              }
          ),
          Container(
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(12),
              color:Colors.grey[200],
            ),

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment:MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 6,),
                      Text("Address Information ",
                        style:TextStyle(color:ColorManager.textColorDark,
                            fontSize: 21
                        ),
                      ),

                      Text("Address : "+userAddress['street_address'].toString(),
                        style:TextStyle(color:ColorManager.textColorDark,
                        fontWeight:FontWeight.w700
                        ),
                      ),
                      Text("City : "+userAddress['city'].toString(),
                        style:TextStyle(color:ColorManager.textColorDark,
                            fontWeight:FontWeight.w700
                        ),
                      ),

                       Text("Area : "+userAddress['area'].toString(),
                        style:TextStyle(color:ColorManager.textColorDark,
                        fontSize: 20,
                            fontWeight:FontWeight.w700,
                        ),
                      ),

                    ],
                  ),
                  const SizedBox(width: 20,),


                ],
              ),
            ),
          ),
          const SizedBox(height: 14,),
          CustomButton(text: 'Next',
              onPressed: (){
                //
                LatLng latlng=LatLng(
                    double.parse(userAddress['latitude'] ),
                   double.parse( userAddress['longitude']));

            Get.to(ConfirmOrder(
              addressData: userAddress,
            //  latLng:latlng ,
            ));
              }, color1:Colors.blue, color2: Colors.white)


        ],),
      ),
    );
  }
}
