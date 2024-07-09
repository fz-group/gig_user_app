
// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, unused_import


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Home/presentation/Manager/home_controller.dart';
import 'package:gic_client/Features/Order/presentation/view/confirm_order.dart';
import 'package:gic_client/Features/SearchPlaces/controllers/search_places_controller.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../../core/resources/color_manager.dart';
import '../../../SearchPlaces/presentation/view/place_details.dart';
import '../../../SearchPlaces/presentation/view/search_places.dart';


class HomeView extends StatefulWidget
{
  const HomeView({super.key});
  @override
  _SearchPlacesScreenState createState() => _SearchPlacesScreenState();
}

TextEditingController searchController=TextEditingController();
String placeNamex='';
final List<LatLng> rectangleCoords = [
  LatLng(30.1126, 31.3989), // Top left
  LatLng(30.1126, 31.4139), // Top right
  LatLng(30.1111, 31.4139), // Bottom right
  LatLng(30.1111, 31.3989), // Bottom left
];



class _SearchPlacesScreenState extends State<HomeView>
{
  String mapKey=
   'AIzaSyCdLsB9Sjir6fW0ZjJ1mksJvxMrRIZR7d4';
  //'AIzaSyCdLsB9Sjir6fW0ZjJ1mksJvxMrRIZR7d4';
  //'AIzaSyCT5ti5wz4HUsPW38wSzMI0_snJFQmqdag';
  final controller=Get.put(HomeController());

  bool loadx=false;

  SearchPlacesController searchPlacesController=Get.put(SearchPlacesController());

  @override
 
  void initState() {
    searchPlacesController.getUserAddress('1', '1');
    controller.checkLocationPermission();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        loadx = true;
      });
      controller.getCurrentLocation();
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
     backgroundColor: ColorManager.backColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GetBuilder<HomeController>(
                builder: (_) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height*0.51,
                    child: GoogleMap(
                      myLocationEnabled: true,
                      onCameraMove: controller.onCameraMove,
                      initialCameraPosition: CameraPosition(
                        target: controller.currentLatLng,
                          zoom: controller.zoom,
                      ),
                      
                      onMapCreated: controller.onMapCreated,
                      mapType: MapType.normal,
                    ),
                  );
                }
            ),

            Column(
              children: [
                InkWell(
                  child: Container(
                    decoration:BoxDecoration(
                      color:ColorManager.backColor,
                      borderRadius:BorderRadius.circular(31)
                    ),
                    height: 175,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            children: [
                              SizedBox(
                                height: 11,
                                child: Image.asset('assets/images/rec.png'),
                              ),
                              const SizedBox(height: 11,),
                              Row(
                                children: [
                                  const Custom_Text(text: 'Nice to see you ',fontSize: 22,
                                  fontWeight:FontWeight.w500,
                                  ),
                                  const SizedBox(width: 21,),
                                  Image.asset('assets/images/hand.png')
                                ],
                              ),
                              const SizedBox(height: 11,),
                              InkWell(
                                child: Container(
                                  height: 70,
                                  decoration:BoxDecoration(
                                    color:ColorManager.textColorGreyMode,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child:Row(
                                    children: [
                                      SizedBox(width: 20,),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Custom_Text(
                                          fontSize: 19,
                                          alignment:Alignment.center,
                                          color:ColorManager.textColorLight,
                                          text: 'Where Is Your Home ?',
                                        ),
                                      ),
                                      SizedBox(width:65,),
                                      Icon(Icons.search,
                                      size:30,color:ColorManager.textColorDark,
                                      )
                                    ],
                                  ),
                                ),
                                onTap:(){
                                  Get.to(SearchPlacesView());
                                },
                              )
                            ],
                        ),
                    ),
                  ),
                  onTap:(){
                    // Get.to(OrderView(
                    //   latLng: controller.currentLatLng,
                    // ));
                 //   Get.to(SearchPlacesView());
                   // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPlacesView()));
                  },
                ),
                userListAddressWidget(),

              ],
            ),

            SizedBox(height: 11,),


            (loadx==false)?
            Positioned(
              left: 160,
              top:300,
              child: Container(
                height: 90,
                width: 80,
                decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:ColorManager.primary
                ),
                child: Center(
                  child: LoadingAnimationWidget.fourRotatingDots(
                    color: ColorManager.backColor,
                    size: 60,
                  ),
                ),
              ),
            ):const SizedBox()
          ],
        ),
      ),
    );
  }

  Widget userListAddressWidget() {
    return GetBuilder<SearchPlacesController>(
      builder: (_) {
        return SizedBox(
                        height:130,
                        child: ListView.builder(
                          scrollDirection:Axis.horizontal,
                          itemCount:searchPlacesController.userAddress.length,
                          itemBuilder:(context,index){ 

                            
                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 166,
                              child: InkWell(
                                  child:
                                  Container(
                                    height: 110,
                                    width: MediaQuery.of(context).size.width*1.1,
                                    decoration:BoxDecoration(
                                      borderRadius:BorderRadius.circular(22),
                                      color:Colors.grey[200]
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Row(
                                      //  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Center(
                                            child: Column(
                                              mainAxisAlignment:MainAxisAlignment.center,
                                              children: [

                                                Text(""+searchPlacesController.userAddress[index]
                                                ['street_address'].toString(),
                                                  style:TextStyle(color:ColorManager.primary),
                                                ),
                                                Text(" "+
                                                searchPlacesController.userAddress[index]['city'].toString()),

                                             Text(" "+
                                                searchPlacesController.userAddress[index]['zip_code'].toString()),

                                             Text(" "+
                                                searchPlacesController.userAddress[index]['country'].toString()),

                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  onTap:(){
                                     Get.to(ConfirmOrder(
                                          addressData: searchPlacesController.userAddress[0],
                                        //  latLng:latlng ,
                                        ));
                                    // Get.to(PlacesDetails(
                                    //   userAddress: searchPlacesController.userAddress,
                                    // ));
                                  },
                                ),
                            ),
                          );
                        
                          }),
                      );
      }
    );
  }

}






