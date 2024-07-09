import 'package:flutter/material.dart';

import 'Custom_Text.dart';



  class CustomButton extends StatelessWidget {

  final String  text;
  final Function  onPressed;
  final Color  color1,color2;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.color1,
    required this.color2,
  });


  @override
  Widget build(BuildContext context) {
    return
      SizedBox(
        width:175,
        height:52,
        child:InkWell(
          child: Container(
            decoration:  const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
            ),

            child: Card(
              color:color1,
              child:Center(
                child:Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Custom_Text(
                    text: text,
                    fontSize: 17,
                    alignment: Alignment.center,
                    color: color2,
                  ),
                ),
              ),
            ),
          ),
          onTap:(){
            onPressed();
          }
        )


        // RaisedButton(
        //
        //   elevation: 10,
        //   onPressed: onPressed(),
        //   color: color1,
        //   // shape: RoundedRectangleBorder(
        //   //     borderRadius: BorderRadius.circular(30)),
        //   child: Padding(
        //     padding: EdgeInsets.all(10),
        //     child: Text(
        //       text,
        //       style: getRegularStyle(color: color2,fontSize:20)
        //     ),
        //   ),
        // ),
      );



    }
}