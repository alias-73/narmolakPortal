// import 'dart:async';
// import 'dart:math';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:date_format/date_format.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sima_portal/a_sima_app/info.dart';
// import 'package:sima_portal/a_sima_app/device/list_device.dart';
// import 'package:sima_portal/a_sima_app/jaygozini/list_edited.dart';
// import 'package:sima_portal/a_sima_app/Moaref/list_moaref.dart';
// import 'package:sima_portal/a_sima_app/list_riz.dart';
// import 'package:sima_portal/a_sima_app/profile/list_users.dart';
// import 'package:sima_portal/a_sima_app/models/agentModel.dart';
// import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis.dart';
// import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
// import 'package:sima_portal/a_sima_app/services/notification.dart';
// import 'package:sima_portal/a_sima_app/services/online_services.dart';
// import 'package:sima_portal/a_sima_app/Hesab/list_hesab.dart';
// import 'package:sima_portal/a_sima_app/upload.dart';
// import 'package:sima_portal/a_sima_app/video_services/list_products.dart';
// import 'package:sima_portal/a_sima_app/video_services/list_videos.dart';
// import 'package:sima_portal/a_sima_app/profile/wallet.dart';
// import 'package:fancy_dialog/fancy_dialog.dart';
// import 'Pazirade/list_pazirandeMaliyat.dart';
// import 'Terminal/list_terrr.dart';
// import 'components/ScaleRoute.dart';
// import 'EM/em_cartableI.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'EM/em_cartableP.dart';
// import 'models/PersonalMessageModel.dart';
// import 'models/messageModel.dart';
// 
// import 'models/notifyModel.dart';
// 
//
// // Future<void> sss() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await initializeService();
// //   ///runApp(const qqq());
// // }
//
// // Future<void> initializeService() async {
// //   final service = FlutterBackgroundService();
// //   await service.configure(
// //     androidConfiguration: AndroidConfiguration(
// //       // this will executed when app is in foreground or background in separated isolate
// //       onStart: onStart,
// //
// //       // auto start service
// //       autoStart: true,
// //       isForegroundMode: true,
// //     ),
// //     iosConfiguration: IosConfiguration(
// //       // auto start service
// //       autoStart: true,
// //
// //       // this will executed when app is in foreground in separated isolate
// //       onForeground: onStart,
// //
// //       // you have to enable background fetch capability on xcode project
// //       onBackground: onIosBackground,
// //     ),
// //   );
// //   service.startService();
// // }
// // bool onIosBackground(ServiceInstance service) {
// //   WidgetsFlutterBinding.ensureInitialized();
// //  // print('FLUTTER BACKGROUND FETCH');
// //
// //   return true;
// // }
// //
// // void onStart(ServiceInstance service) {
// //   if (service is AndroidServiceInstance) {
// //     service.on('setAsForeground').listen((event) {
// //       service.setAsForegroundService();
// //     });
// //
// //     service.on('setAsBackground').listen((event) {
// //       service.setAsBackgroundService();
// //     });
// //   }
// //
// //   service.on('stopService').listen((event) {
// //     service.stopSelf();
// //   });
// //
// //   // bring to foreground
// //   Timer.periodic(const Duration(seconds: 100), (timer) async {
// //     if (service is AndroidServiceInstance) {
// //       service.setForegroundNotificationInfo(
// //         title: "سرویس اطلاع رسانی پرتال دستگاه های کارتخوان",
// //         content: "",
// //       );
// //     }
// //
// //     /// you can see this log in logcat
// //     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
// //     checkNotify();
// //
// //     String device="";
// //
// //     service.invoke(
// //       'update',
// //       {
// //         "current_date": DateTime.now().toIso8601String(),
// //         "device": device,
// //       },
// //     );
// //   });
// // }
//
// Future checkNotify() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   var messaging = FirebaseMessaging.instance;
//   var token = await messaging.getToken();
//
//   var rng = Random();
//   List<NotifyModel> _data = [];
//   late Map response;
//   response = await OnlineServices.getNotify({
//     "token": token
//   });
//   // print("________________________");
//   // print(response);
//
//   if (response['data'] != "free" ) {
//     _data.clear();
//     _data.addAll(response['data']);
//
//     for(int i = 0 ; i<response.length ; i++)
//     {
//       // NotificationApi.showNotification(
//       //     payload: rng.nextInt(100).toString(),
//       //     body: _data[i].body,
//       //     title: _data[i].title,
//       //     id: rng.nextInt(100)
//       // );
//     }
//
//   }
//   //else print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
// }
//
//
// class sima_home1_page extends StatefulWidget {
//   List<AgentModel> _data = [];
//
//   sima_home1_page(this._data);
//
//   @override
//   State<StatefulWidget> createState() => sima_home1_pageState();
// }
//
// class sima_home1_pageState extends State<sima_home1_page>
//     with SingleTickerProviderStateMixin {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   int currentPageIndex = 2;
//   String text = "Stop Service";
//
//   List<PersonalMessageModel> _message = [];
//   String msg = " s";
//   List<MessageModel> _msg = [];
//   late String today = "";
  late String datetime = "";
//
//   bool isOpened = false;
//
//   late AnimationController _animationController;
//   late Animation<Color> _buttonColor;
//   late Animation<double> _animateIcon;
//   late Animation<double> _translateButton;
//   Curve _curve = Curves.easeOut;
//   double _fabHeight = 56.0;
//   Color bcf = Colors.black;
//
//   final colorList = <Color>[
//     Color(0xffcc0202),
//     Color(0xff02cc02),
//     Color(0xff1130f5),
//     Color(0xffffc00c),
//
//   ];
//
//   ChartType _chartType = ChartType.ring; ///$$$$$
//   double _ringStrokeWidth = 50; ///$$$$$
//   double _chartLegendSpacing = 0; ///$$$$$
//
//   LegendShape _legendShape = LegendShape.Circle;
//   LegendPosition _legendPosition = LegendPosition.left;
//   double PASARGAD = 0;
//   double IRANKISH = 0;
//   double BEHPARDAKHT = 0;
//   double SADAD = 0;
//   int key = 0;
//
//   @override
//   initState() {
//     getCountOfPSP();
//     Future.delayed(const Duration(milliseconds: 1000), () {
//       ///   _showMsg( "aaaaa" , "asdsadssss");
//     });
//     //
//     // sss();
//     // FlutterBackgroundService().invoke("setAsForeground");
//     
//     
//     
//     String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;
//     String datetime = h + ":" + m;
//     OnlineServices.sendLoginInfo({"tarikh": today,"saat": datetime, "agentcode": widget._data.last.agentCode, "usercode": widget._data.last.userCode });
//     _getMsg();
//
//     //menu = false;
//     // menu2 = false;
//     getInformation();
//     _animationController =
//     AnimationController(vsync: this, duration: Duration(milliseconds: 500))
//       ..addListener(() {
//         setState(() {});
//       });
//     _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
//     _buttonColor = ColorTween(
//       begin: Color(0x00000000),
//       end: Color(0x00000000),
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.00,
//         1.00,
//         curve: Curves.linear,
//       ),
//     )) as Animation<Color>;
//     _translateButton = Tween<double>(
//       begin: _fabHeight,
//       end: -14.0,
//     ).animate(CurvedAnimation(
//       parent: _animationController,
//       curve: Interval(
//         0.0,
//         0.75,
//         curve: _curve,
//       ),
//     ));
//     super.initState();
//   }
//
//   @override
//   dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }
//
//   animate() {
//     if (!isOpened) {
//       _animationController.forward();
//     } else {
//       _animationController.reverse();
//     }
//     isOpened = !isOpened;
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     var size = MediaQuery.of(context).size;
//     final dataMap = <String, double>{
//       "ایران کیش": IRANKISH,
//       "پاسارگاد": PASARGAD,
//       "سداد": SADAD,
//       "به پرداخت": BEHPARDAKHT,
//     };
//     final chart = PieChart(
//       key: ValueKey(key),
//       ///totalValue: 35,
//       dataMap: dataMap,
//       centerText: "PSP",
//       //legendLabels: {"a":"b" , "h":"s"},
//       animationDuration: Duration(milliseconds: 3000),
//       chartLegendSpacing: _chartLegendSpacing,
//       chartRadius: MediaQuery.of(context).size.width / 3.2 > 500
//           ? MediaQuery.of(context).size.width * .3
//           : MediaQuery.of(context).size.width * .3,
//       colorList: colorList,
//       initialAngleInDegree:  0,
//       chartType: _chartType,
//       legendOptions: LegendOptions(
//
//         showLegendsInRow: false,
//         legendPosition: _legendPosition,
//         showLegends: true,
//         legendShape: BoxShape.circle,
//         legendTextStyle: const TextStyle(
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       chartValuesOptions: const ChartValuesOptions(
//         showChartValueBackground: true,
//         showChartValues: true,
//         showChartValuesInPercentage: true,
//         showChartValuesOutside: true,
//       ),
//       ringStrokeWidth: 20,
//       emptyColor: Colors.grey,
//
//       //  gradientList: _showGradientColors ? gradientList : null,
//       emptyColorGradient: const [
//         Color(0xff6c5ce7),
//         Colors.blue,
//       ],
//     );
//
//
//     return Stack(
//       alignment: Alignment.bottomCenter,
//       children: [
//         WillPopScope(
//             child: SafeArea(
//               child: Scaffold(
//                 backgroundColor: Colors.white,
//                 body: SingleChildScrollView(
//                     child:
//                     Stack(
//                       children: [
//                         Visibility(child:
//                         Column(
//                           children: [
//                             // StreamBuilder<Map<String, dynamic>>(
//                             //   stream: FlutterBackgroundService().on('update'),
//                             //   builder: (context, snapshot) {
//                             //     if (!snapshot.hasData) {
//                             //       return const Center(
//                             //         child: Center(),
//                             //       );
//                             //     }
//                             //
//                             //     final data = snapshot.data!;
//                             //     String device = data["device"];
//                             //     DateTime date = DateTime.tryParse(data["current_date"]);
//                             //     return Column(
//                             //       children: [
//                             //         //  Text(date.toString()),
//                             //       ],
//                             //     );
//                             //   },
//                             // ),
//                             // ElevatedButton(
//                             //   child: const Text("Foreground Mode"),
//                             //   onPressed: () {
//                             //     FlutterBackgroundService().invoke("setAsForeground");
//                             //   },
//                             // ),
//                             // ElevatedButton(
//                             //   child: const Text("Background Mode"),
//                             //   onPressed: () {
//                             //     FlutterBackgroundService().invoke("setAsBackground");
//                             //   },
//                             // ),
//
//                           ],
//                         ),visible: true,),
//
//                         Shimmer(
//                           duration: Duration(seconds: 8), //Default value
//                           interval: Duration(seconds: 2), //Default value: Duration(seconds: 0)
//                           color: Colors.white, //Default value
//                           colorOpacity: 0, //Default value
//                           enabled: true, //Default value
//                           direction: ShimmerDirection.fromLTRB(),  //Default Value
//                           child: Container(
//                             //margin: EdgeInsets.only(top: 8,bottom: 5),
//                             // height: mainHeight * .2,
//                               color: Color(0xffffffff),
//                               child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: [
//                                   itemInfo1(BuildContext, 1),
//                                   SizedBox(height: 50,),
//                                   Container(
//                                     padding: EdgeInsets.zero,
//                                     alignment: Alignment.center,
//                                     height: size.height * .7 * .5,
//                                     width: size.width,
//                                     child: LayoutBuilder(
//                                       builder: (_, constraints) {
//                                         if (constraints.maxWidth >= 600) {
//                                           return chart;
//                                         } else {
//                                           return Container(
//                                             child: chart,
//                                             //  margin: EdgeInsets.symmetric(vertical: 32,),
//                                           );
//                                         }
//                                       },
//                                     ),
//                                   ),
//
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       items2(
//                                           BuildContext,
//                                           "پذیرنده",
//                                           "assets/images/pazirande.png",
//                                           Color(0xff9c1208),
//                                           poses_list_page(widget._data),
//                                           1),
//                                       items2(
//                                           BuildContext,
//                                           "معرف",
//                                           "assets/images/moaref.png",
//                                           Color(0xfffc9117),
//                                           list_moaref_page(widget._data),
//                                           6),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       items2(
//                                           BuildContext,
//                                           "حساب",
//                                           "assets/images/hesab.png",
//                                           Color(0xff7a0982),
//                                           sheba_registered_page(widget._data),
//                                           5),
//                                       items2(
//                                           BuildContext,
//                                           "دستگاه",
//                                           "assets/images/device.png",
//                                           Color(0xff595759),
//                                           device_list(widget._data),
//                                           0),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       items2(
//                                           BuildContext,
//                                           "جایگزینی",
//                                           "assets/images/replace.png",
//                                           Color(0xff04b6d1),
//                                           list_jaygozini_page(widget._data),
//                                           3),
//                                       items2(
//                                           BuildContext,
//                                           "تخصیص",
//                                           "assets/images/takhsis.png",
//                                           Color(0xff0453d1),
//                                           pos_registered3_page(widget._data),
//                                           2),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       items(
//                                           BuildContext,
//                                           "کارتابل EM",
//                                           "assets/images/support.png",
//                                           Color(0xffe60b0b),
//                                           em_cartableP_page(widget._data)),
//                                       items(
//                                           BuildContext,
//                                           "بارگذاری مدارک",
//                                           "assets/images/upload.png",
//                                           Color(0xff06a801),
//                                           upload_doc(widget._data)),
//                                     ],
//                                   ),
//                                   Row(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//                                       items2(
//                                           BuildContext,
//                                           "ترمینال ها",
//                                           "assets/images/Terminal.png",
//                                           Color(0xff5f5f00),
//                                           ter(widget._data),
//                                           4),
//                                       items(
//                                           BuildContext,
//                                           "محصولات",
//                                           "assets/images/Mahsolat.png",
//                                           Color(0xff662f00),
//                                           list_videos(widget._data)),
//                                     ],
//                                   ),
//                                 ],
//                               )),
//                         ),
//
//                         // Row(
//                         //   children: [
//                         //     ElevatedButton(
//                         //       child: const Text("Foreground Mode"),
//                         //       onPressed: () {
//                         //         FlutterBackgroundService().invoke("setAsForeground");
//                         //       },
//                         //     ),
//                         //
//                         //     ElevatedButton(
//                         //       child: Text(text),
//                         //       onPressed: () async {
//                         //         final service = FlutterBackgroundService();
//                         //         var isRunning = await service.isRunning();
//                         //         if (isRunning) {
//                         //           service.invoke("stopService");
//                         //         } else {
//                         //           service.startService();
//                         //         }
//                         //
//                         //         if (!isRunning) {
//                         //           text = 'Stop Service';
//                         //         } else {
//                         //           text = 'Start Service';
//                         //         }
//                         //         setState(() {});
//                         //       },
//                         //     ),
//                         //   ],
//                         // )
//                       ],
//                     )
//                 ),
//               ),
//             ),
//             onWillPop: () {
//               showDialog(
//                   context: context,
//                   builder: (BuildContext context) => FancyDialog(
//                     gifPath: "assets/images/exit.jpg",
//                     ok: "بله",
//                     okFun: () {
//                       SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//                     },
//                     cancel: "نه",
//                     title: 'آیا از برنامه خارج می شوید؟',
//                     descreption: " ",
//                   ));
//               // _showDialog(context);
//               return Future.value(false); // if true allow back else block it
//             }),
//         Padding(
//           padding: EdgeInsets.only(bottom: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               Transform(
//                 transform: Matrix4.translationValues(
//                   0,
//                   _translateButton.value * 4.0,
//                   0,
//                 ),
//                 child: widget._data.last.userCode == "0" ? USERS() : SizedBox(),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(
//                   0,
//                   _translateButton.value * 3.0,
//                   0,
//                 ),
//                 child: WALLET(),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(
//                   0,
//                   _translateButton.value * 2.0,
//                   0.0,
//                 ),
//                 child: TRANSACTION(),
//               ),
//               Transform(
//                 transform: Matrix4.translationValues(
//                   0,
//                   _translateButton.value,
//                   0.0,
//                 ),
//                 //  child:  inbox() ,
//                 child: INFO(),
//               ),
//               Column(
//                 children: [
//                   // FloatingActionButton(onPressed: (){
//                   //   menu2 = true;
//                   //   setState(() {});
//                   //
//                   // },
//                   //   heroTag: 6,
//                   //   child: Icon(Icons.warning,color: Colors.red,size: 30,), backgroundColor: Color(0xff000000),
//                   // ),
//                   // SizedBox(height: 25,),
//                   toggle()
//
//                 ],
//               ),
//             ],
//           ),
//         ),
//
//       ],
//     );
//   }
//
//   void _showDialog3( ) {
//     var size = MediaQuery.of(context).size;
//     showGeneralDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel: MaterialLocalizations.of(context)
//             .modalBarrierDismissLabel,
//         barrierColor: Colors.black45,
//         transitionDuration: const Duration(milliseconds: 200),
//         pageBuilder: (BuildContext buildContext,
//             Animation animation,
//             Animation secondaryAnimation) {
//           return Scaffold(backgroundColor: Color(0x69bcdeff), body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   child: Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(
//                         0xffffffff)),
//                     width:size.width * .75,
//                     height: size.height * .35,
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const Text("محصولات",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
//                         Image.asset("assets/images/devices.jpg"),
//                       ],
//                     ),
//                   ),onTap: (){ Navigator.pop(context);
//                   Navigator.push(context, ScaleRoute(page: Directionality(child: list_products(widget._data),textDirection: TextDirection.rtl,))); },
//                 ),
//                 SizedBox(height: 20,),
//             GestureDetector(
//               child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(0xffffffff)),
//                   width:size.width * .75,
//                   height: size.height * .35,
//                   padding: EdgeInsets.all(20),
//                   child: Column(
//                     children: [
//                       const Text("آموزش",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
//                       Image.asset("assets/images/learning.png"),
//                     ],
//                   ),
//                 ),onTap: (){
//               Navigator.pop(context);
//               Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl,child: list_videos(widget._data),)));
//             }),
//
//               ],
//             ),
//           ));
//         });
//
//
//
//
//
//   }
//
//   void _showEmMenu() {
//     var size = MediaQuery.of(context).size;
//     showGeneralDialog(
//         context: context,
//         barrierDismissible: true,
//         barrierLabel: MaterialLocalizations.of(context)
//             .modalBarrierDismissLabel,
//         barrierColor: Colors.black45,
//         transitionDuration: const Duration(milliseconds: 200),
//         pageBuilder: (BuildContext buildContext,
//             Animation animation,
//             Animation secondaryAnimation) {
//           return Scaffold(backgroundColor: Color(0x69bcdeff), body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 GestureDetector(
//                   child: Container(
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(
//                         0xffffffff)),
//                     width:size.width * .75,
//                     height: size.height * .4,
//                     padding: EdgeInsets.all(20),
//                     child: Column(
//                       children: [
//                         const Text("ایران کیش",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
//                         Image.asset("assets/images/irankish.png"),
//                       ],
//                     ),
//                   ),onTap: (){ Navigator.pop(context);
//                 Navigator.push(context, ScaleRoute(page: Directionality(child: em_cartableI_page(widget._data),textDirection: TextDirection.rtl,))); },
//                 ),
//                 SizedBox(height: 20,),
//                 GestureDetector(
//                     child: Container(
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(50)), color: Color(0xffffffff)),
//                       width:size.width * .75,
//                       height: size.height * .4,
//                       padding: EdgeInsets.all(20),
//                       child: Column(
//                         children: [
//                           const Text("پاسارگاد",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 19),),
//                           Image.asset("assets/images/pasargad.png"),
//                         ],
//                       ),
//                     ),onTap: (){
//                   Navigator.pop(context);
//                   Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl,child: em_cartableP_page(widget._data),)));
//                 }),
//
//               ],
//             ),
//           ));
//         });
//
//
//
//
//
//   }
//
//   Widget Menu2() {
//     var size = MediaQuery.of(context).size;
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset("assets/images/MaliyatLogo.jpg", height: (size.height * 0.5) * .6,),
//         space(),
//         ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: maliyat_list_page(widget._data,1))));}, child: Text("   نمایش لیست فوری   ",style: TextStyle(fontSize: 25,color: Colors.white))),
//         space(),
//         ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: maliyat_list_page(widget._data,2))));}, child: Text("  نمایش لیست خیلی فوری  ",style: TextStyle(fontSize: 25,color: Colors.white))
//         )
//
//
//       ],
//     );
//   }
//
//   Widget space(){return SizedBox(height: 28,);}
//
//   Widget items2(BuildContext, String title, String ic, Color c, Widget w, int di) {
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     double fontSize = 25;
//     double icSize = size.width * 0.15;
//     double icSize2 = size.width * 0.25;
//
//     Color bcItemColor1 = c;
//     return GestureDetector(
//       child: Container(
//         //  alignment: Alignment.center,
//         height: (size.height - statusBarHeight) * .2,
//         width: size.width * 0.5,
//         // padding: EdgeInsets.only(top: 10, bottom: 10),
//         decoration: BoxDecoration(
//           color: bcItemColor1,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
//                   alignment: Alignment.center,
//
//                   width: size.width * .5 * .6,
//
//                   margin: EdgeInsets.only(right: 8),
//                   color: c,
//                   // alignment: Alignment.center,
//                   child: ic == "assets/images/takhsis.png"
//                       ? Image.asset(
//                     ic,
//                     height: icSize2,
//                     width: icSize2,
//                   )
//                       : ic == "assets/images/replace.png"
//                       ? Image.asset(
//                     ic,
//                     height: icSize2,
//                     width: icSize2,
//                   )
//                       : Image.asset(
//                     ic,
//                     height: icSize,
//                     width: icSize,
//                   ),
//                 ),
//
//               ],
//             ),
//             // دستگاه پذیرنده تخصیص جایگزینی ای ام
//             Text(
//               title,
//               style: TextStyle(fontSize: fontSize, color: Colors.white),
//             ),
//             //Divider(height: 3, color: Colors.black,),
//           ],
//         ),
//       ),
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: w)));
//
//         setState(() {});
//       },
//     );
//   }
//
//   Widget items(BuildContext, String title, String ic, Color c, Widget w) {
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double statusBarHeight = MediaQuery.of(context).padding.top;
//     // dynamic w = list_moaref_page(widget._data);
//     double fontSize = 25;
//     double h = 0.2;
//     double icSize = size.width * 0.15;
//     double icSize2 = size.width * 0.25;
//
//     Color bcItemColor1 = c;
//     Color textColor = Color(0xbb000000);
//     Color color = Color(0xff321654);
//     return GestureDetector(
//       child: Container(
//         //  alignment: Alignment.center,
//         height: (size.height - statusBarHeight) * .2,
//         width: size.width * 0.5,
//         // padding: EdgeInsets.only(top: 10, bottom: 10),
//         decoration: BoxDecoration(
//           color: bcItemColor1,
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               color: c,
//               alignment: Alignment.center,
//               child: ic == "assets/images/takhsis.png"
//                   ? Image.asset(
//                 ic,
//                 height: icSize2,
//                 width: icSize2,
//               )
//                   : ic == "assets/images/replace.png"
//                   ? Image.asset(
//                 ic,
//                 height: icSize2,
//                 width: icSize2,
//               )
//                   : Image.asset(
//                 ic,
//                 height: icSize,
//                 width: icSize,
//               ),
//             ),
//             Text(
//               title,
//               style: TextStyle(
//                   fontSize: title.contains("مدارک") ? 22 : fontSize,
//                   color: Colors.white),
//             ),
//             //Divider(height: 3, color: Colors.black,),
//           ],
//         ),
//       ),
//       onTap: () {
//          title == "محصولات" ? _showDialog3() :
//          title.contains("EM") ? _showEmMenu() :
//          Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: w)));
//       },
//     );
//   }
//
//   Widget itemInfo1(BuildContext, int tag) {
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double fontSize3 = blockSize * 3;
//     double fontSize4 = blockSize * 4;
//     double fontSize5 = blockSize * 5;
//     double fontSize7 = blockSize * 7;
//     double appBarHeight = AppBar().preferredSize.height;
//     double mainHeight = size.height - appBarHeight - 80;
//     double itemHeight = mainHeight * .18;
//     double itemWidth = size.width * .56;
//     Color bcItemColor1 = Color(0xcf1760ff);
//     Color bcItemColor2 = Color(0xaad81b60);
//     Color bcItemColor3 = Color(0xaae53935);
//     Color textColor = Color(0xbb000000);
//     Color color = Color(0xff321654);
//
//       return SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: [
//             Container(
//               alignment: Alignment.center,
//               //padding: EdgeInsets.all(10),
//               margin: EdgeInsets.only(top: 8, right: 14, left: 14),
//               width: itemWidth,
//               height: itemHeight,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: [
//                       Color(0xff3d558d),
//                       Color(0xe00f82ff),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20), ),
//                   border: Border.all(color: color)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   headerItem("پذیرنده", Icons.person_outlined, itemHeight),
//                   Divider(
//                     color: Colors.white,
//                     indent: .5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       itm(itemWidth * .27, itemHeight * .5, getPazirandeAllCount, "تعداد کل"),
//                       itm(itemWidth * .27, itemHeight * .5, getPazirandeEslahCount, "اصلاح"),
//                       itm(itemWidth * .27, itemHeight * .5, getPazirandeLaghvCount, "لغو"),
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.only(top: 8, right: 14, left: 14),
//               width: itemWidth,
//               height: itemHeight,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: [
//                       Color(0xe000410a),
//                       Color(0xff028f35),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20), ),
//                   border: Border.all(color: color)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   headerItem("دستکاه", Icons.device_hub, itemHeight),
//                   Divider(
//                     color: Colors.white,
//                     indent: .5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       itm(itemWidth * .27, itemHeight * .5, getDeviceAllCount, "تعداد کل"),
//                       itm(itemWidth * .27, itemHeight * .5, getDeviceFreeCount, "آزاد"),
//                       itm(itemWidth * .27, itemHeight * .5, getDeviceNewCount, "جدید"),
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Container(
//               alignment: Alignment.center,
//               margin: EdgeInsets.only(top: 8, right: 14, left: 14),
//               width: itemWidth,
//               height: itemHeight,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topRight,
//                     end: Alignment.bottomLeft,
//                     colors: [
//                       Color(0xe08a0000),
//                       Color(0xfff3142f),
//                     ],
//                   ),
//                   borderRadius: BorderRadius.only(bottomRight: Radius.circular(20),topLeft: Radius.circular(20), ),
//                   border: Border.all(color: color)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   headerItem("دستکاه", Icons.device_hub, itemHeight),
//                   Divider(
//                     color: Colors.white,
//                     indent: .5,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       itm(itemWidth * .27, itemHeight * .5, getTakhsisAllCount, "تعداد کل"),
//                       itm(itemWidth * .27, itemHeight * .5, getTakhsisNasbCount, "نصب"),
//                       itm(itemWidth * .27, itemHeight * .5, getTakhsisReadyCount, "آماده"),
//
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//   }
//
//   Widget itm(double w , double h , Function f ,String title) {
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double fontSize3 = blockSize * 3;
//     double fontSize4 = blockSize * 4;
//     double fontSize5 = blockSize * 5;
//     return SizedBox(
//         height: h,
//       width: w,
//       child: FutureBuilder<String>(
//         future: f(),
//         builder: (context, AsyncSnapshot<String> snapshot) {
//           if (snapshot.hasData) {
//             return Column(
//               children: [
//                 Text(
//                   snapshot.data!,
//                   style: TextStyle(
//                       fontSize: fontSize5, color: Colors.white),
//                 ), Text(title ,
//                   style: TextStyle(
//                       fontSize: fontSize3, color: Colors.white),
//                 )
//               ],
//             );
//           } else if (snapshot.hasError) {
//             return Container();
//           } else
//             return Container();
//         },
//       ));
//   }
//
//   Widget headerItem(String title, IconData ic, double Hsize){
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double fontSize3 = blockSize * 3;
//     double fontSize4 = blockSize * 4;
//     double fontSize5 = blockSize * 5;
//     double fontSize7 = blockSize * 7;
//
//     return  Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         Container(
//           margin: EdgeInsets.only(right: 25),
//           alignment: Alignment.topRight,
//           height: Hsize * .2,
//           child: Text(
//             title,
//             style: TextStyle(fontSize: fontSize5, color: Colors.white),
//           ),
//         ),
//         Icon(
//           ic,
//           color: Colors.white,
//           size: fontSize7,
//         )
//       ],
//     );
//   }
//
//   void _getMsg() async {
//
//     Map response = await OnlineServices.getMessages(
//         {"agentcode": widget._data.last.agentCode});
//     if(response['data'] !="free"){
//       _msg.clear();
//       _msg.addAll(response['data']);
//       for (int i = 0; i < _msg.length; i++)
//         _showMsg( _msg[i].date, _msg[i].message);
//     }
//     else print("free");
//
//   }
//
//   removee() async {
//     Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
//     SharedPreferences preferences = await _prefs;
//     preferences.remove("mDateKey");
//   }
//
//   Future _deleteImageFromCache() async {
//     String url = "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg";
//     await CachedNetworkImage.evictFromCache(url);
//   }
//
//   void _showMsg( String date, String txt) {
//     var size = MediaQuery.of(context).size;
//     showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(18))),
//           child: AlertDialog(
//             title: Directionality(
//                 textDirection: TextDirection.rtl,
//                 child: Column(
//                   children: [
//                     Text("اطلاعیه ",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black87,
//                             fontSize: 20)),
//                     Divider(
//                       color: Colors.black87,
//                       thickness: 2,
//                     )
//                   ],
//                 )),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(bottom: 9),
//                     child:ClipRRect(borderRadius: BorderRadius.circular(10.0),
//                         child: CachedNetworkImage(
//                           imageUrl: "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg" ,
//                           placeholder: (context, url) =>
//                               Image.asset("assets/images/empty.png"),
//                           errorWidget: (context, url, error) =>
//                               Image.asset("assets/images/empty.png"),
//                         )),
//                   ),
//                   Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: Row(
//                         children: [
//                           Icon(Icons.date_range_sharp),
//                           SizedBox(
//                             width: 15,
//                           ),
//                           Text("تاریخ اطلاعیه: " + date),
//                         ],
//                       )),
//                   Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: Column(
//                         children: [
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Text(
//                             txt,
//                             textAlign: TextAlign.right,
//                           ),
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               ElevatedButton(
//                   onPressed: () {
//                     _deleteImageFromCache();
//                     Navigator.pop(context);
//                     // SystemNavigator.pop();
//                     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(widget._data))));
//                   },
//                   child: Text(
//                     "     مطالعه کردم      ",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 20),
//                   )),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget WALLET() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 1,
//         backgroundColor: bcf,
//         onPressed: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl,child: wallet_page(widget._data))));
//         },
//         tooltip: 'کیف پول',
//         child: SvgPicture.asset(
//           "assets/images/wallet.svg",
//           color: Colors.white,
//           width: 23,
//         ),
//         // child: Icon(
//         //   Icons.account_box_outlined,
//         //   size: 30,
//         // ),
//       ),
//     );
//   }
//
//   Widget TRANSACTION() {
//     return Container(
//       child: FloatingActionButton(
//         isExtended: true,
//         heroTag: 2,
//         backgroundColor: bcf,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: list_riz_page(widget._data))));
//         },
//         tooltip: 'ریزتراکنش',
//         child: Icon(Icons.bar_chart,size: 33,),
//       ),
//     );
//   }
//
//   Widget INFO() {
//     return Container(
//       child: FloatingActionButton(
//         heroTag: 3,
//         backgroundColor: bcf,
//         child: SvgPicture.asset(
//           "assets/images/info.svg",
//           color: Colors.white,
//           width: 23,
//         ),
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: info_page(widget._data))));
//         },
//         tooltip: 'پروفایل',
//       ),
//     );
//   }
//
//   Widget USERS() {
//     return Container(
//       child: FloatingActionButton(
//         child: SvgPicture.asset(
//           "assets/images/users.svg",
//           color: Colors.white,
//           width: 23,
//         ),
//         heroTag: 4,
//         backgroundColor: bcf,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (context) => Directionality(
//                       textDirection: TextDirection.rtl,
//                       child: users_page(widget._data))));
//         },
//         tooltip: 'زیرمجموعه ها',
//       ),
//     );
//   }
//
//   Widget toggle() {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       child: FloatingActionButton(
//         //   foregroundColor: Color(0xffffffff),
//         heroTag: 5,
//         backgroundColor: Color(0xff000000),
//         onPressed: animate,
//
//         tooltip: 'گزینه ها',
//         child: GestureDetector(
//           onTap: animate,
//           child: ClipOval(
//             child: Material(
//               child: InkWell(
//                 child: SizedBox(
//                   width: size.width * .12,
//                   height: size.width * .12,
//                   child: Container(
//                     // color: Color(0xcc0d47a1),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Color(0xffffffff),
//                         //  image: DecorationImage(image: AssetImage("assets/images/person.png"))
//                       ),
//                       //child: Image.asset("assets/images/person.png")
//                       child:
//
//                       FutureBuilder<String>(
//                         future: getImg(),
//                         builder: (context, AsyncSnapshot<String> snapshot) {
//                           // print("-----"+snapshot.data!.toString());
//                           if (snapshot.hasData) {
//                             //  List<News> _news2 = snapshot.data!;
//                             return
//                               //   NetworkImage(snapshot.data!.toString());
//                               CachedNetworkImage(
//                                 imageUrl: snapshot.data!.toString() ,
//                                 //imageUrl: snapshot.data!.toString() ,
//                                 placeholder: (context, url) =>
//                                     Image.asset("assets/images/person.png"),
//                                 errorWidget: (context, url, error) =>
//                                     Image.asset("assets/images/person.png"),
//                               );
//                           } else if (snapshot.hasError) {
//                             return Container();
//                           } else
//                             return Container();
//                         },
//                       )),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         // child: CircleAvatar(backgroundImage: AssetImage("assets/images/person.jpg"),)
//         // child: AnimatedIcon(
//         //   icon: AnimatedIcons.menu_close,
//         //   progress: _animateIcon,
//         // ),
//       ),
//     );
//   }
//
//   Future<String> getImg() async {
//     String response = await OnlineServices.getImg({
//       "agentcode": widget._data.last.agentCode,
//       "usercode": widget._data.last.userCode
//     });
//     //print (await response);
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getInformation() async {
//     String response = await OnlineServices.getInformation({
//       "agentcode": widget._data.last.agentCode,
//       "usercode": widget._data.last.userCode
//     });
//     //print (await response);
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getPazirandeAllCount() async {
//     String response = await OnlineServices.getPazirandeAllCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getCountOfPSP() async {
//
//     // String response = await OnlineServices.getCountOfPSP(
//     //     {
//     //       "agentcode": widget._data.last.agentCode,
//     //       "usercode": widget._data.last.userCode
//     //     });
//     String response = "28,39,55,79";
//     PASARGAD = double.parse(response.split(",")[0]);
//     IRANKISH = double.parse(response.split(",")[1]);
//     SADAD = double.parse(response.split(",")[2]);
//     BEHPARDAKHT = double.parse(response.split(",")[3]);
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getPazirandeEslahCount() async {
//     String response = await OnlineServices.getPazirandeEslahCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getPazirandeLaghvCount() async {
//     String response = await OnlineServices.getPazirandeLaghvCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getTakhsisAllCount() async {
//     String response = await OnlineServices.getTakhsisAllCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getTakhsisReadyCount() async {
//     String response = await OnlineServices.getTakhsisReadyCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getTakhsisNasbCount() async {
//     String response = await OnlineServices.getTakhsisNasbCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getDeviceAllCount() async {
//     String response = await OnlineServices.getDeviceAllCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getDeviceFreeCount() async {
//     String response = await OnlineServices.getDeviceFreeCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   Future<String> getDeviceNewCount() async {
//     String response = await OnlineServices.getDeviceNewCount(
//       //{"agentcode" : widget._data.last.agentCode } );
//         {
//           "agentcode": widget._data.last.agentCode,
//           "usercode": widget._data.last.userCode
//         });
//     return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
//   }
//
//   void _showDialog2(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     showDialog<void>(
//       context: context,
//       barrierDismissible: true, // user must tap button!
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(18))),
//           child: AlertDialog(
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: <Widget>[
//                   Directionality(
//                       textDirection: TextDirection.rtl, child: Column(
//                     children: [
//                       CachedNetworkImage(
//                         //imageUrl: snapshot.data!.toString().contains("d544") ? "q" :snapshot.data!.toString() ,
//                         imageUrl: "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg" ,
//                         placeholder: (context, url) =>
//                             Image.asset("assets/images/person.png"),
//                         errorWidget: (context, url, error) =>
//                             Image.asset("assets/images/person.png"),
//                       ),
//                       Text(msg)
//                     ],
//                   ))
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     // SystemNavigator.pop();
//                     //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(widget._data))));
//                   },
//                   child: Container(
//                     // margin: EdgeInsets.only(top: 0),
//                       padding: EdgeInsets.only(top: 4, bottom: 4),
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.blueAccent,
//                         border: Border.all(
//                           width: 1,
//                           color: Color(0xff000000),
//                         ),
//                         borderRadius: BorderRadius.all(Radius.circular(5)),
//                         //  border: Border(color: Colors.black, width: 1.0),
//                       ),
//                       //  color: Colors.lightBlueAccent,
//                       width: size.width * .3,
//                       child: Text(
//                         "باشه",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 16),
//                       ))),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//
//   void getPersonalMessage() async {
//     Map response;
//     response = await OnlineServices.getPersonalMessagee({
//       "agentcode": widget._data.last.agentCode,
//       "usercode": widget._data.last.userCode
//     });
//     if (response["data"] != "free") {
//       _message.clear();
//       _message.addAll(response['data']);
//       print(_message.last.message);
//       msg = _message.last.message;
//       _showDialog2(context);
//       setState(() {});
//     } else {
//       //  print("freeeeeee");
//     }
//   }
// }