



 import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Settings/controllers/settings_controller.dart';
import 'package:gic_client/Features/Settings/presentation/view/update_view.dart';
import 'package:gic_client/core/resources/color_manager.dart';
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/Custom_button.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {

SettingsController controller=Get.put(SettingsController());
 
  @override
  void initState() {
    controller.getUserData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder<SettingsController>(
          builder: (_) {
            if(controller.userData.isEmpty){
    return const Center(
                child: CircularProgressIndicator(),
              );
            }else{

                   return Column(
              children: [
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custom_Text(text: 'My Profile',
                  color:ColorManager.textColorDark,
                    fontSize: 22,
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Container(
                      decoration: BoxDecoration(
                            border: Border.all(
                                color:Colors.grey[100]!)
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 82,
                              child:Image.asset('assets/images/profile.png'),
                            ),
                          ),
                          const SizedBox(width: 15,),
                          Column(
                            children: [
                              Custom_Text(text: controller.userData['first_name'],fontSize: 20,
                                color: ColorManager.textColorDark,
                              ),
                              const SizedBox(height: 5,),
                              Custom_Text(text: controller.userData['email'],fontSize: 20,
                                color: ColorManager.textColorDark,
                              ),
                            ],
                          ),
                          const SizedBox(width: 6,),
                          CircleAvatar(
                            backgroundColor: Colors.grey[200]!,
                            child: IconButton(onPressed: (){
                              Get.to(UpdateView(
                                data: controller.userData,
                              ));
                            }, icon:
                            const Icon(Icons.edit,color:Colors.blue,)),
                          )
                        ],
                      ),
                    ),
                  ),
                  onTap:(){
                    Get.to(UpdateView(
                      data: controller.userData,
                    ));
                   //
                  },
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:ColorManager.helpColor,
                    child:  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.monetization_on_rounded,
                            size: 35,color: ColorManager.primary,
                          ),
                        ),
                        const SizedBox(width: 21,),
                        Custom_Text(text: 'Payment Methods',fontSize: 20,
                          color: ColorManager.textColorDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custom_Text(text: 'Sitting and Proforsa',
                  fontSize: 18,color:ColorManager.textColorDark,
                  ),
                ),
                const SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:ColorManager.helpColor,
                    child:  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.contact_mail,
                            size: 35,color: ColorManager.primary,
                          ),
                        ),
                        const SizedBox(width: 21,),
                        Custom_Text(text: 'Contact Information',fontSize: 20,
                          color: ColorManager.textColorDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:ColorManager.helpColor,
                    child:  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.history,
                            size: 35,color: ColorManager.primary,
                          ),
                        ),
                        const SizedBox(width: 21,),
                        Custom_Text(text: 'History',fontSize: 20,
                          color: ColorManager.textColorDark,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Custom_Text(text: 'Help',
                    fontSize: 18,color:ColorManager.textColorDark,
                  ),
                ),
                const SizedBox(height: 1,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color:ColorManager.helpColor,
                    child:  Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.help,
                            size: 35,color: ColorManager.primary,
                          ),
                        ),
                        const SizedBox(width: 21,),
                        Custom_Text(text: 'Did U Have A Problem ?',fontSize: 20,
                          color: ColorManager.textColorDark,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                CustomButton(text: 'Logout',
                    onPressed: (){
                    }, color1: ColorManager.primary,
                    color2: ColorManager.textColorLight)
              ],
            );
             
            }

       
          }
        ),
      ),
    );
  }
}
