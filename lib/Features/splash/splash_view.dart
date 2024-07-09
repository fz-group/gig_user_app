

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}



class _SplashViewState extends State<SplashView> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', false, 50),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children:  [
            
            const SizedBox(height: 20,),
            Center(
              child: Image.asset('assets/images/green_area.jpeg'),
            ),
          ],
        ),
      ),
    );
  }
}