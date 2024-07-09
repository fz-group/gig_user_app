
import 'package:flutter/material.dart';

import '../../core/widgets/Custom_Text.dart';
import '../../core/widgets/custom_appbar.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:CustomAppBar('', true, 50),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(children: const [
          SizedBox(height: 6,),
          Custom_Text(text: 'Payment Method',fontSize: 22),
          SizedBox(height: 6,),
          

          

        ],),
      ),
    );
  }
}