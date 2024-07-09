//
//
//
//  import 'package:fg_app/core/resources/color_manager.dart';
// import 'package:fg_app/core/widgets/Custom_Text.dart';
// import 'package:fg_app/core/widgets/Custom_button.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../core/widgets/rounded_button.dart';
//
// class IntroView extends StatelessWidget {
//   const IntroView({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       appBar:AppBar(
//         elevation: 0.0,
//         backgroundColor:ColorManager.primary,
//         toolbarHeight: 1,
//
//       ),
//       body:ListView(
//         children: [
//           SizedBox(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: Stack(
//               children: [
//
//                 SizedBox(
//                   width: MediaQuery.of(context).size.width,
//
//                   child: Image.asset('assets/images/back.png',
//                   fit: BoxFit.fill,
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 133,
//                   left: 120,
//                   child: Column(
//
//                     children: [
//                       Custom_Text(
//                         fontWeight:FontWeight.w700,
//                         text: 'Bringing pa;pa;',
//                       fontSize: 21,color:ColorManager.textColorLight,alignment:Alignment.center,
//                       ),
//                       Custom_Text(
//                         fontWeight:FontWeight.w700,
//                         text: 'Members the best',
//                         fontSize: 21,color:ColorManager.textColorLight,alignment:Alignment.center,
//                       ),
//                       Custom_Text(
//                         fontWeight:FontWeight.w700,
//                         text: 'product, inspiration',
//                         fontSize: 21,color:ColorManager.textColorLight,alignment:Alignment.center,
//                       ), Custom_Text(
//                         fontWeight:FontWeight.w700,
//                         text: 'and stories in live.',
//                         fontSize: 21,color:ColorManager.textColorLight,alignment:Alignment.center,
//                       ),
//                       const SizedBox(height: 12,),
//
//                       RoundButton(text: 'Join Us', onPressed:(){}, color1:ColorManager.buttonColor2
//                           , color2: ColorManager.textColorDark)
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
