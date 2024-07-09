


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Order/presentation/view/confirm_order.dart';
import 'package:gic_client/Features/SearchPlaces/controllers/search_places_controller.dart';
import 'package:gic_client/Features/SearchPlaces/data/models/pred.dart';
import 'package:gic_client/Features/SearchPlaces/data/models/pred.dart';
import 'package:gic_client/Features/SearchPlaces/presentation/view/place_details.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SelectArea extends StatelessWidget {

  PredictedPlaces place;
      double lat;
      double lng;
      String zipCode;
      dynamic id;


 
  SelectArea({super.key,required this.place,required this.id,
  required this.zipCode,required this.lat,required this.lng
  });

  @override
  Widget build(BuildContext context) {
    SearchPlacesController controller=Get.put(SearchPlacesController());
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SearchPlacesController>(
          builder: (_) {
            return ListView(children:  [
              const SizedBox(height: 14,),
            
              const Custom_Text(text: 'Select Area',
              fontSize: 22,fontWeight:FontWeight.w700,
              ),
            
              const SizedBox(height: 14,),
            
              Column(
                children: [
                  InkWell(
                    child:Card(
                      color:controller.cardColor,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Custom_Text(text: '50 M TO 100 M',
                        color:Colors.white,
                        ),
                      )
                    ),
                    onTap:(){
                      controller.changeColor();
                    },
                  ),
            
                  const SizedBox(height:10 ),
            
            
                   InkWell(
                    child:Card(
                      color:controller.cardColor2,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Custom_Text(text: '100 M TO 200 M',
                        color:Colors.white,
                        ),
                      )
                    ),
                    onTap:(){
                      controller.changeColor2();
                    },
                  ),
            
            
                   const SizedBox(height:10 ),
            
            
                   InkWell(
                    child:Card(
                      color:controller.cardColor3,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:  Custom_Text(text: '200 M TO 500 M',
                        color:Colors.white,
                        ),
                      )
                    ),
                    onTap:(){
                      controller.changeColor3();
                    },
                  )
                ],
              )
            , 
 const SizedBox(height: 22,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(text: 'Next',
               onPressed: (){


                 String area='';
                 if(controller.cardColor==Colors.blue){
                   area='50 M TO 100 M';
                 }
                 if(controller.cardColor2==Colors.blue){
                   area='100 M TO 200 M';
                 }
                 if(controller.cardColor3==Colors.blue){
                   area='200 M TO 500 M';
                 }
              Map<String,dynamic>data={
                'area':area,
                'id':id,
                'city':'',
              'latitude':lat,
              'longitude':lng,
                'street_address':place.main_text
              };

            Get.to(ConfirmOrder(
              addressData: data
            ));
               }, color1: ColorManager.buttonColor
               , color2: Colors.white),
            )
          
            ],);
          }
        ),
      ),
    );
  }
}