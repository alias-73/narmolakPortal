// import 'package:flutter/material.dart';
//
// class SingInAnimation extends StatelessWidget {
//   final Animation<double> controller;
//   final Animation<double> buttonSqueezeAnimation;
//   final Animation<double> buttonZoomOut;
//
//   SingInAnimation({ required this.controller }) :
//
//       buttonSqueezeAnimation = Tween(
//         begin: 280.0,
//         end: 60.0
//       ).animate(
//         CurvedAnimation(
//             parent: controller,
//             curve: Interval(0.0, 0.150)
//         )
//       ),
//
//       buttonZoomOut = Tween(
//           begin: 70.0,
//           end: 1000.0
//       ).animate(
//           CurvedAnimation(
//               parent: controller,
//               curve: Interval(0.550, 0.999 , curve: Curves.bounceOut)
//           )
//       );
//
//   Widget _animationBuilder(BuildContext context , Widget child) {
//     return Container(
//               margin: const EdgeInsets.only(bottom: 30),
//               width: 100,
//               height: 50,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                   color: Color(0xff075E54),
//                   borderRadius: BorderRadius.all(const Radius.circular(30))
//               ),
//               child: buttonSqueezeAnimation.value > 75
//                   ? Text(
//                       "ورود",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 20,
//                           fontWeight: FontWeight.w300,
//                           letterSpacing: .3
//                       ),
//                     )
//                   : buttonZoomOut.value < 300.0
//                     ? CircularProgressIndicator(
//                         valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
//                       )
//                     : null
//                   ,
//             );
//
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return AnimatedBuilder(
//         animation: controller ,
//         builder: _animationBuilder
//     );
//   }
//
// }