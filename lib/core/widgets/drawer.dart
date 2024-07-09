import 'package:flutter/material.dart';
import '../resources/color_manager.dart';


class MainDrawer extends StatefulWidget {
  const MainDrawer({Key ? key}) : super(key: key);

  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {

  bool show=false;


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
        child: SafeArea(
            child: SingleChildScrollView(
                child: Column(
                    children: <Widget>[

                      Container(
                        height: 20,
                        color: ColorManager.primary,
                      ),
                    ]))));
  }



}






