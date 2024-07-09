
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gic_client/Features/Order/presentation/view/user_order.dart';
import 'package:gic_client/Features/Settings/presentation/view/settings_view.dart';
import 'package:gic_client/Features/msgs/views/msgs_view.dart';
import '../../core/resources/color_manager.dart';
import '../Home/presentation/view/home_view.dart';



class MainHome extends StatelessWidget {

  const MainHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> fragmentScreens = [
      const HomeView(),
      const MsgsView(),
      const UserOrdersView(),
      //const LoginView(),
      const SettingsView()
    ];

    List navigationButtonProperties = [
      {
        "active_icon": (Icons.home),
        "non_active_icon": (Icons.home_outlined),
        "label": "Home "
      },
      {
        "active_icon": (Icons.messenger),
        "non_active_icon": (Icons.messenger_outlined),
        "label": "Messages"
      },
      {
        "active_icon": (Icons.local_activity),
        "non_active_icon": (Icons.local_activity_outlined),
        "label": " orders "
      },
      {
        "active_icon": (Icons.person),
        "non_active_icon": (Icons.person_2_outlined),
        "label": "Profile"
      },
    ];

    RxInt indexNumber = 0.obs;
    return Scaffold(
        backgroundColor: ColorManager.backColor,
        appBar: AppBar(
          toolbarHeight: 1,
          backgroundColor: ColorManager.backColor,
        ),
        body: SafeArea(child: Obx(() => fragmentScreens[indexNumber.value])),
        bottomNavigationBar: Obx(() => Container(
              padding: const EdgeInsets.all(1.0),
              child: BottomNavigationBar(
                currentIndex: indexNumber.value,
                onTap: (value) {
                  indexNumber.value = value;
                },
                showSelectedLabels: true,
                backgroundColor: ColorManager.backColor,
                showUnselectedLabels: true,
                selectedItemColor: ColorManager.primary,
                unselectedItemColor: Colors.grey,
                items: List.generate(4, (index) {
                  // ignore: non_constant_identifier_names
                  var BtnProp = navigationButtonProperties[index];
                  return BottomNavigationBarItem(
                      backgroundColor: ColorManager.backColor,
                      icon: Icon(BtnProp["non_active_icon"]),
                      activeIcon: Icon(BtnProp["active_icon"]),
                      label: BtnProp["label"]);
                }),
              ),
            )));
  }
}
