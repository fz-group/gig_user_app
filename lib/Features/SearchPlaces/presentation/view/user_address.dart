

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/SearchPlaces/controllers/search_places_controller.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';

class UserAddressView extends StatefulWidget {
  const UserAddressView({super.key});

  @override
  State<UserAddressView> createState() => _UserAddressViewState();
}

class _UserAddressViewState extends State<UserAddressView> {


 SearchPlacesController controller=Get.put(SearchPlacesController());
  @override
  void initState() {
    controller.getUserAddress('10', '0');
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SearchPlacesController>(
          builder: (_) {
            return ListView(children: [
              const SizedBox(height: 20,),
              const Custom_Text(text: 'Select Address',
              fontSize: 22,fontWeight:FontWeight.w600,
              ),
            Container(
              decoration:BoxDecoration(
                borderRadius:BorderRadius.circular(12),
                  color:Colors.grey[200],
              ),
      
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                    Text("Id : "+controller.userAddress[0]['id'].toString(),
                  style:TextStyle(color:ColorManager.textColorDark,
                  fontSize: 21
                  ),
                  ),
                
                  Text("Address : "+controller.userAddress[0]['street_address'].toString(),
                  style:TextStyle(color:ColorManager.textColorDark),
                  ),
                  Text("City : "+controller.userAddress[0]['city'].toString()),
                
                ],
              ),
           const SizedBox(width: 20,),
           Checkbox(value: controller.checkBox, onChanged: (v){

   controller.changeAddress(v!);
         
           })
           
            ],
          ),
        ),
      )
              
            ],);
          }
        ),
      ),
    );
  }

 
}