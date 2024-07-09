
import 'package:gic_client/core/widgets/Custom_Text.dart';
import 'package:gic_client/core/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';

class OrderFailed extends StatelessWidget {
  const OrderFailed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          const SizedBox(height: 10,),
          SizedBox(height: 133,
          child: Image.asset('assets/images/fail.png')),

          const SizedBox(height: 6,),

          const Custom_Text(text: 'Sorry We Can\'t Support The Selected Address',
          fontSize: 24,fontWeight: FontWeight.w600,
          color:Colors.red,
          )


          

        
         
        ],),
      ),

    );
  }
}