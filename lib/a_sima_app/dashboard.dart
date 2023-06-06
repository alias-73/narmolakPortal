import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:persian_date/persian_date.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/video_services/list_products.dart';
import 'package:sima_portal/a_sima_app/video_services/list_videos.dart';
import 'package:sima_portal/a_sima_app/profile/wallet.dart';
import '../case.dart';
import 'Pazirade/list_pazirandeMaliyat.dart';
import 'alarm.dart';
import 'chart/line_chart_page.dart';
import 'components/ScaleRoute.dart';
import 'EM/em_cartableI.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'EM/em_cartableP.dart';
import 'models/PersonalMessageModel.dart';
import 'models/alarmModel.dart';
import 'models/messageModel.dart';

import 'models/notifyModel.dart';

// Future<void> sss() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await initializeService();
//   ///runApp(const qqq());
// }

// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//     androidConfiguration: AndroidConfiguration(
//       // this will executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//     ),
//     iosConfiguration: IosConfiguration(
//       // auto start service
//       autoStart: true,
//
//       // this will executed when app is in foreground in separated isolate
//       onForeground: onStart,
//
//       // you have to enable background fetch capability on xcode project
//       onBackground: onIosBackground,
//     ),
//   );
//   service.startService();
// }
// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//  // print('FLUTTER BACKGROUND FETCH');
//
//   return true;
// }
//
// void onStart(ServiceInstance service) {
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 100), (timer) async {
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "سرویس اطلاع رسانی پرتال دستگاه های کارتخوان",
//         content: "",
//       );
//     }
//
//     /// you can see this log in logcat
//     print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');
//     checkNotify();
//
//     String device="";
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });

Future checkNotify() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var messaging = FirebaseMessaging.instance;
  var token = await messaging.getToken();

  var rng = Random();
  List<NotifyModel> _data = [];
  late Map response;
  response = await OnlineServices.getNotify({"token": token});
  // print("________________________");
  // print(response);

  if (response['data'] != "free") {
    _data.clear();
    _data.addAll(response['data']);

    for (int i = 0; i < response.length; i++) {
      // NotificationApi.showNotification(
      //     payload: rng.nextInt(100).toString(),
      //     body: _data[i].body,
      //     title: _data[i].title,
      //     id: rng.nextInt(100)
      // );
    }
  }
  //else print("LLLLLLLLLLLLLLLLLLLLLLLLLLLLLL");
}

class dashboard extends StatefulWidget {
  List<AgentModel> _data = [];

  //const _LineChart8({required this.isShowingMainData});

  late final bool isShowingMainData;

  dashboard(this._data);

  @override
  State<StatefulWidget> createState() => dashboardState();
}

class dashboardState extends State<dashboard>
    with SingleTickerProviderStateMixin {
  int currentPageIndex = 2;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  String text = "Stop Service";
// }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'brand': build.brand,
      'manufacturer': build.manufacturer,
      'model': build.model,
    };
  }

  List<PersonalMessageModel> _message = [];
  String msg = " s";
  List<MessageModel> _msg = [];
  List<AlarmModel> _alarm = [];
  late String today = "";
  late String datetime = "";
  bool isOpened = false;

  late AnimationController _animationController;
  late Animation<Color> _buttonColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  Color bcf = Colors.black;

  Color CIran = Color(0xffff0000);
  Color CPasargad = Color(0xffffb911);
  Color CSadad = Color(0xff065ed5);
  Color CBeh = Colors.teal;
  Color CSep = Color(0xff700039);
  Color CPN = Color(0x738969FC);
  late AnimationController localAnimationController;
  final colorList = <Color>[
    Color(0xffff0000),
    Color(0xffffb911),
    Color(0xff065ed5),
    Colors.teal,
    Color(0xff700039),
    Color(0x738969FC)
  ];

  ChartType _chartType = ChartType.ring;

  ///$$$$$
  double _ringStrokeWidth = 50;

  ///$$$$$
  double _chartLegendSpacing = 100;

  ///$$$$$

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.left;
  double PASARGAD = 0;
  double IRANKISH = 0;
  double BEHPARDAKHT = 0;
  double PARDAKHTNOVIN = 0;
  double SADAD = 0;
  double SEPEHR = 0;
  int key = 0;
  bool isShowChart = false;
  String target1 = "";
  String target2 = "";
  late double EmPercent;
  String EmAll = "";
  String EmBaz = "";

  @override
  initState() {
    initPlatformState();
    PersianDate persianDate = PersianDate();
    today = persianDate.getDate
        .toString()
        .substring(0, persianDate.getDate.toString().length - 13)
        .replaceAll("-", "/");
    String h = DateTime.now().hour.toString();
    if (h.length == 1) h = "0" + h;
    String m = DateTime.now().minute.toString();
    if (m.length == 1) m = "0" + m;
    String datetime = h + ":" + m;

    getCountOfPSP();

    Future.delayed(const Duration(seconds: 3), () {
      // print(today);
      // print(datetime);
      // print(widget._data.last.agentCode);
      // print(widget._data.last.userCode);
      // print(_deviceData['version.sdkInt'].toString());
      // print(_deviceData['version.release']);
      // print(_deviceData['manufacturer']);
      // print(_deviceData['brand']);
      // print(_deviceData['model']);
      OnlineServices.sendLoginInfo({
        "tarikh": today,
        "saat": datetime,
        "agentcode": widget._data.last.agentCode,
        "usercode": widget._data.last.userCode,
        "sdk": _deviceData['version.sdkInt'].toString(),
        "version": _deviceData['version.release'],
        "manufacturer": _deviceData['manufacturer'],
        "brand": _deviceData['brand'],
        "model": _deviceData['model'],
      });
    });

    _getMsg();
    _getAlarm();

    //menu = false;
    // menu2 = false;
    getInformation();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Color(0x00000000),
      end: Color(0x00000000),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )) as Animation<Color>;
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    if (Platform.isAndroid) {
      deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    final dataMap = <String, double>{
      "ایران کیش": IRANKISH,
      "پاسارگاد": PASARGAD,
      "سداد": SADAD,
      "به پرداخت": BEHPARDAKHT,
      "پرداخت نوین": PARDAKHTNOVIN,
      "سپهر": SEPEHR,
    };
    final chart = PieChart(
      key: ValueKey(key),

      ///totalValue: 35,
      dataMap: dataMap,
      centerText: "PSP",
      //legendLabels: {"a":"b" , "h":"s"},
      animationDuration: Duration(milliseconds: 3000),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 500
          ? MediaQuery.of(context).size.width * .4
          : MediaQuery.of(context).size.width * .4,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      legendOptions: LegendOptions(
        showLegendsInRow: false,
        legendPosition: _legendPosition,
        showLegends: false,
        legendShape: BoxShape.circle,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: true,
      ),
      ringStrokeWidth: 50,
      emptyColor: Colors.grey,

      //  gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
    );

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        WillPopScope(
            child: SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                    child: Stack(
                  children: [
                    Visibility(
                      visible: true,
                      child: Column(
                        children: [
                          // StreamBuilder<Map<String, dynamic>>(
                          //   stream: FlutterBackgroundService().on('update'),
                          //   builder: (context, snapshot) {
                          //     if (!snapshot.hasData) {
                          //       return const Center(
                          //         child: Center(),
                          //       );
                          //     }
                          //
                          //     final data = snapshot.data!;
                          //     String device = data["device"];
                          //     DateTime date = DateTime.tryParse(data["current_date"]);
                          //     return Column(
                          //       children: [
                          //         //  Text(date.toString()),
                          //       ],
                          //     );
                          //   },
                          // ),
                          // ElevatedButton(
                          //   child: const Text("Foreground Mode"),
                          //   onPressed: () {
                          //     FlutterBackgroundService().invoke("setAsForeground");
                          //   },
                          // ),
                          // ElevatedButton(
                          //   child: const Text("Background Mode"),
                          //   onPressed: () {
                          //     FlutterBackgroundService().invoke("setAsBackground");
                          //   },
                          // ),
                        ],
                      ),
                    ),
                    Container(
                        //margin: EdgeInsets.only(top: 8,bottom: 5),
                        // height: mainHeight * .2,
                        color: Color(0xffdedede),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: AnimationConfiguration.toStaggeredList(
                              duration: const Duration(milliseconds: 575),
                              childAnimationBuilder: (widget) => SlideAnimation(
                                verticalOffset:
                                    MediaQuery.of(context).size.width / 2,
                                child: FadeInAnimation(child: widget),
                              ),
                              children: [
                                SizedBox(
                                  height: 7,
                                ),
                                SizedBox(
                                  height: size.height * .35,
                                  width: size.width,
                                  child: LineChartPage(widget._data),
                                ),
                                SizedBox(
                                  height: 7,
                                ),
                                itemInfo1(),

                                SizedBox(
                                  height: 10,
                                ),
                                circularInd1(),
                                SizedBox(
                                  height: 10,
                                ),

                                circularInd2(),
                                SizedBox(
                                  height: 9,
                                ),

                                //   loading(),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(0)),
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  height: size.height * .7 * .5,
                                  width: size.width * .92,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            itmColor("ایران کیش", CIran),
                                            itmColor("پاسارگاد", CPasargad),
                                            itmColor("سداد", CSadad),
                                            itmColor("به پرداخت", CBeh),
                                            itmColor("سپهر", CSep),
                                            itmColor("پرداخت نوین", CPN),
                                          ]),
                                      LayoutBuilder(
                                        builder: (_, constraints) {
                                          if (constraints.maxWidth >= 600) {
                                            return chart;
                                          } else {
                                            return Container(
                                              child: chart,
                                              //  margin: EdgeInsets.symmetric(vertical: 32,),
                                            );
                                          }
                                        },
                                      ),
                                      SizedBox(
                                        width: 5,
                                      )
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )))
                  ],
                )),
              ),
            ),
            onWillPop: () {
              CoolAlert.show(
                context: context,
                title: "",
                confirmBtnText: "   بله  ",
                cancelBtnText: "نه",
                showCancelBtn: false,
                onCancelBtnTap: () {
                  Navigator.pop;
                },
                type: CoolAlertType.warning,
                onConfirmBtnTap: () {
                  exit(0);
                },
                text: 'آیا از برنامه خارج می شوید؟',
                backgroundColor: Colors.white,
              );
              // _showDialog(context);
              return Future.value(false); // if true allow back else block it
            }),
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              // Transform(
              //   transform: Matrix4.translationValues(
              //     0,
              //     _translateButton.value * 4.0,
              //     0,
              //   ),
              //   child: widget._data.last.userCode == "0" ? USERS() : SizedBox(),
              // ),
              // Transform(
              //   transform: Matrix4.translationValues(
              //     0,
              //     _translateButton.value * 3.0,
              //     0,
              //   ),
              //   child: WALLET(),
              // ),
              // Transform(
              //   transform: Matrix4.translationValues(
              //     0,
              //     _translateButton.value * 2.0,
              //     0.0,
              //   ),
              //   child: TRANSACTION(),
              // ),
              // Transform(
              //   transform: Matrix4.translationValues(
              //     0,
              //     _translateButton.value,
              //     0.0,
              //   ),
              //   //  child:  inbox() ,
              //   child: INFO(),
              // ),
              Column(
                children: [
                  // FloatingActionButton(onPressed: (){
                  //   menu2 = true;
                  //   setState(() {});
                  //
                  // },
                  //   heroTag: 6,
                  //   child: Icon(Icons.warning,color: Colors.red,size: 30,), backgroundColor: Color(0xff000000),
                  // ),
                  // SizedBox(height: 25,),
                  //   toggle()
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget circularInd1() {
    var size = MediaQuery.of(context).size;
    String info =
        "نماینده در طول ماه جاری باید تلاش نماید تا به هدف مشخص شده در ثبت و فعال سازی پرونده برسد.در صورتی که نماینده به هدف بازاریابی مشخص شده برسد، در پایان آن ماه 10 درصد پاداش در صورت وضعیت لحاظ خواهد گردید.و در صورتی که نماینده بیشتر از 20 درصد از هدف مشخص شده فاصله داشته باشد 10 درصد از صورت وضعیت نماینده کسر خواهد گردید.";

    return Stack(children: [
      Container(
          height: size.height * .2,
          alignment: Alignment.center,
          width: size.width * .92,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(0),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color(0xffeea100),
                  Color(0xffeea100),
                ],
              )
              //color: Color(0xffeea100),
              ),
          child: Stack(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                SizedBox(
                  width: size.width * .4,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "هدف این ماه",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 24),
                      ),
                      Row(
                        children: [
                          Text(
                            target1 + " / ",
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 20),
                          ),
                          Text(
                            target2,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.w900, fontSize: 30),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                FutureBuilder<String>(
                  future: getTarget(),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return CircularPercentIndicator(
                        radius: 60.0,
                        lineWidth: 20.0,
                        animation: true,
                        percent: double.parse(
                                snapshot.data.toString().split(",")[0]) /
                            100,
                        //   percent: double.parse(snapshot.data.toString()),
                        backgroundColor: Colors.black,
                        center: Text(
                          "${snapshot.data?.split(",")[0]}%",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 20),
                        ),
                        progressColor: Color(0xffffffff),
                      );
                    } else {
                      return Container();
                    }
                    //Parikhasteh
                  },
                ),
              ]),
              Padding(
                padding: EdgeInsets.only(right: 3, top: 3),
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                      child: Image.asset(
                        "assets/images/info.png",
                        height: (size.height * .25) * .15,
                      ),
                      onTap: () async {
                        _showDialog(info);
                      }),
                ),
              )
            ],
          ))
    ]);
  }

  Widget circularInd2() {
    var size = MediaQuery.of(context).size;
    Color c1 = Color(0xff00720e);
    Color c2 = Color(0xffffa41b);
    Color c3 = Color(0xffb60202);

    String info =
        "در صورتی که پذیرنده های ثبت شده توسط نماینده به صورت تلفنی و با استفاده از اپلیکیشن ها مربوطه اقدام به ثبت درخواست پشتیبانی نمایند ، در این بخش نمایش داده خواهد شد\nنماینده با توجه به سوئیچ باید اقدام به رفع آن نماید.مهلت اقدام برای هر درخواست 48 ساعت می باشد.\nدر صورت عدم اقدام در زمان اعلام شده، به ازای هر درخواست روزانه نماینده جریمه خواهد شد.";
    return FutureBuilder<String>(
      future: getEmBazCount(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Container(
              height: size.height * .24,
              alignment: Alignment.center,
              width: size.width * .92,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xffe0dddd),
                      double.parse(snapshot.data.toString().split(",")[0]) < 20
                          ? c1
                          : double.parse(
                                      snapshot.data.toString().split(",")[0]) <
                                  80
                              ? c2
                              : double.parse(snapshot.data
                                          .toString()
                                          .split(",")[0]) <
                                      101
                                  ? c3
                                  : Color(0xffb4b4b4)
                    ],
                  )),
              child: Stack(
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: size.width * .4,
                            child: Column(
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "EM",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 24),
                                      ),
                                      Image.asset(
                                        "assets/images/pasargad.png",
                                        height: 40,
                                      )
                                    ]),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(children: [
                                      Text(
                                        "کل\n" +
                                            snapshot.data
                                                .toString()
                                                .split(",")[1],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      )
                                    ]),
                                    Column(children: [
                                      Text(
                                        "باز\n" +
                                            snapshot.data
                                                .toString()
                                                .split(",")[2],
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                            fontWeight: FontWeight.w900,
                                            fontSize: 20),
                                      )
                                    ]),
                                  ],
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          ScaleRoute(
                                              page: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child:
                                                em_cartableP_page(widget._data),
                                          )));
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xff000000))),
                                    child: Text("نمایش همه"))
                              ],
                            )),
                        CircularPercentIndicator(
                          radius: 60.0,
                          lineWidth: 20.0,
                          animation: true,
                          percent: double.parse(
                                  snapshot.data.toString().split(",")[0]) /
                              100,
                          progressColor: Colors.white,
                          center: Text(
                            "${snapshot.data?.split(",")[0]}%",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          backgroundColor: double.parse(
                                      snapshot.data.toString().split(",")[0]) <
                                  20
                              ? Color(0xff2abb26)
                              : double.parse(snapshot.data
                                          .toString()
                                          .split(",")[0]) <
                                      80
                                  ? Color(0xffcb882b)
                                  : double.parse(snapshot.data
                                              .toString()
                                              .split(",")[0]) <
                                          101
                                      ? Color(0xffaf2828)
                                      : Color(0xffb4b4b4),
                        )

                        //SizedBox(width: size.width * .1,),
                      ]),
                  Padding(
                    padding: EdgeInsets.only(right: 3, top: 3),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                          child: Image.asset(
                            "assets/images/info.png",
                            height: (size.height * .25) * .15,
                          ),
                          onTap: () {
                            _showDialog(info);
                          }),
                    ),
                  )
                ],
              ));
        } else {
          return Container();
        }
      },
    );
  }

  void _showDialog3() {
    var size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Color(0x69bcdeff),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Color(0xffffffff)),
                        width: size.width * .75,
                        height: size.height * .35,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "محصولات",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 19),
                            ),
                            Image.asset("assets/images/devices.jpg"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            ScaleRoute(
                                page: Directionality(
                              textDirection: TextDirection.rtl,
                              child: list_products(widget._data),
                            )));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xffffffff)),
                          width: size.width * .75,
                          height: size.height * .35,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "آموزش",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 19),
                              ),
                              Image.asset("assets/images/learning.png"),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              ScaleRoute(
                                  page: Directionality(
                                textDirection: TextDirection.rtl,
                                child: list_videos(widget._data),
                              )));
                        }),
                  ],
                ),
              ));
        });
  }

  void _showEmMenu() {
    var size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Color(0x69bcdeff),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Color(0xffffffff)),
                        width: size.width * .75,
                        height: size.height * .4,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "ایران کیش",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 19),
                            ),
                            Image.asset("assets/images/irankish.png"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            ScaleRoute(
                                page: Directionality(
                              textDirection: TextDirection.rtl,
                              child: em_cartableI_page(widget._data),
                            )));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xffffffff)),
                          width: size.width * .75,
                          height: size.height * .4,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "پاسارگاد",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 19),
                              ),
                              Image.asset("assets/images/pasargad.png"),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              ScaleRoute(
                                  page: Directionality(
                                textDirection: TextDirection.rtl,
                                child: em_cartableP_page(widget._data),
                              )));
                        }),
                  ],
                ),
              ));
        });
  }

  Widget Menu2() {
    var size = MediaQuery.of(context).size;
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/MaliyatLogo.jpg",
          height: (size.height * 0.5) * .6,
        ),
        space(),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: maliyat_list_page(widget._data, 1))));
            },
            child: Text("   نمایش لیست فوری   ",
                style: TextStyle(fontSize: 25, color: Colors.white))),
        space(),
        ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Directionality(
                          textDirection: TextDirection.rtl,
                          child: maliyat_list_page(widget._data, 2))));
            },
            child: Text("  نمایش لیست خیلی فوری  ",
                style: TextStyle(fontSize: 25, color: Colors.white)))
      ],
    );
  }

  Widget space() {
    return SizedBox(
      height: 28,
    );
  }

  Widget items2(
      BuildContext, String title, String ic, Color c, Widget w, int di) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 25;
    double icSize = size.width * 0.15;
    double icSize2 = size.width * 0.25;

    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        //  alignment: Alignment.center,
        height: (size.height - statusBarHeight) * .2,
        width: size.width * 0.5,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: bcItemColor1,
          //   borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,

                  width: size.width * .5 * .6,

                  margin: EdgeInsets.only(right: 8),
                  color: c,
                  // alignment: Alignment.center,
                  child: ic == "assets/images/takhsis.png"
                      ? Image.asset(
                          ic,
                          height: icSize2,
                          width: icSize2,
                        )
                      : ic == "assets/images/replace.png"
                          ? Image.asset(
                              ic,
                              height: icSize2,
                              width: icSize2,
                            )
                          : Image.asset(
                              ic,
                              height: icSize,
                              width: icSize,
                            ),
                ),
              ],
            ),
            // دستگاه پذیرنده تخصیص جایگزینی ای ام
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: Colors.white),
            ),
            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Directionality(
                    textDirection: TextDirection.rtl, child: w)));

        setState(() {});
      },
    );
  }

  Widget items(BuildContext, String title, String ic, Color c, Widget w) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    // dynamic w = list_moaref_page(widget._data);
    double fontSize = 25;
    double h = 0.2;
    double icSize = size.width * 0.15;
    double icSize2 = size.width * 0.25;

    Color bcItemColor1 = c;
    Color textColor = Color(0xbb000000);
    Color color = Color(0xff321654);
    return GestureDetector(
      child: Container(
        //  alignment: Alignment.center,
        height: (size.height - statusBarHeight) * .2,
        width: size.width * 0.5,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: bcItemColor1,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              color: c,
              alignment: Alignment.center,
              child: ic == "assets/images/takhsis.png"
                  ? Image.asset(
                      ic,
                      height: icSize2,
                      width: icSize2,
                    )
                  : ic == "assets/images/replace.png"
                      ? Image.asset(
                          ic,
                          height: icSize2,
                          width: icSize2,
                        )
                      : Image.asset(
                          ic,
                          height: icSize,
                          width: icSize,
                        ),
            ),
            Text(
              title,
              style: TextStyle(
                  fontSize: title.contains("مدارک") ? 22 : fontSize,
                  color: Colors.white),
            ),
            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
        title == "محصولات"
            ? _showDialog3()
            : title.contains("EM")
                ? _showEmMenu()
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl, child: w)));
      },
    );
  }

  Widget itemInfo1() {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            itmMain(getParvandeAll, "پذیرنده", Icons.person_pin),
            itmMain(
                getEslahAll, "نیاز به اصلاح", Icons.drive_file_rename_outline),
            itmMain(getTakhsisAll, "آماده تخصیص", Icons.mobile_screen_share),
          ],
        ),
        width: size.width * .92);
  }

  Widget itmMain(Function f, String title, IconData ic) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize3 = blockSize * 3;
    double fontSize8 = blockSize * 9;
    double fontSize6 = blockSize * 6;
    double fontSize7 = blockSize * 7;
    double fontSize10 = blockSize * 10;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight - 80;
    double itemHeight = mainHeight * .15;
    double itemWidth = (size.width - (size.width * .08)) * .33;
    Color color = Color(0xff321654);
    return Container(
        alignment: Alignment.topRight,
        //padding: EdgeInsets.all(10),
        width: itemWidth,
        height: itemHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffffffff),
              Color(0xffffffff),
            ],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              right: 13,
              left: 0,
              bottom: 0,
              child: Text(
                title,
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: fontSize3, color: Colors.black),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              bottom: 0,
              child: Align(
                alignment: Alignment.center,
                child: FutureBuilder<String>(
                  future: f(),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        (int.parse(snapshot.data.toString())).toString(),
                        style:
                            TextStyle(fontSize: fontSize6, color: Colors.black),
                      );
                    } else if (snapshot.hasError) {
                      return Container();
                    } else
                      return Container();
                  },
                ),
              ),
            ),
            Positioned(
              child: Align(
                child: Icon(
                  ic,
                  size: fontSize6,
                ),
                alignment: Alignment.bottomLeft,
              ),
              top: 0,
              right: 0,
              left: 5,
              bottom: 5,
            ),
          ],
        ));
  }

  Widget itm(double w, double h, Function f, String title) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize3 = blockSize * 3;
    double fontSize4 = blockSize * 4;
    double fontSize5 = blockSize * 5;
    return SizedBox(
        height: h,
        width: w,
        child: FutureBuilder<String>(
          future: f(),
          builder: (context, AsyncSnapshot<String> snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Text(
                    snapshot.data!,
                    style: TextStyle(fontSize: fontSize5, color: Colors.white),
                  ),
                  Text(
                    title,
                    style: TextStyle(fontSize: fontSize3, color: Colors.white),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Container();
            } else
              return Container();
          },
        ));
  }

  Widget headerItem(String title, IconData ic, double Hsize) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize3 = blockSize * 3;
    double fontSize4 = blockSize * 4;
    double fontSize5 = blockSize * 5;
    double fontSize7 = blockSize * 7;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
          margin: EdgeInsets.only(right: 25),
          alignment: Alignment.topRight,
          height: Hsize * .2,
          child: Text(
            title,
            style: TextStyle(fontSize: fontSize5, color: Colors.black),
          ),
        ),
        Icon(
          ic,
          color: Colors.black,
          size: fontSize7,
        )
      ],
    );
  }

  void _getMsg() async {
    Map response = await OnlineServices.getMessages({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    if (response['data'] != "free") {
      _msg.clear();
      _msg.addAll(response['data']);
      for (int i = 0; i < _msg.length; i++)
        _showMsg(_msg[i].date, _msg[i].message);
    }
    // else
    // print("free");
  }

  void _getAlarm() async {
    // Future.delayed(Duration(seconds: 3), (){
    //   Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: alarm())));
    //
    // });

    Map response = await OnlineServices.getAlarm({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });

    _alarm.clear();
    _alarm.addAll(response['data']);
    _alarm.first.alarm == "new"
        ? Future.delayed(Duration(seconds: 3), () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Directionality(
                        textDirection: TextDirection.rtl, child: alarm())));
          })
        : null;

    // else
    // print("free");
  }

  removee() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences preferences = await _prefs;
    preferences.remove("mDateKey");
  }

  Future _deleteImageFromCache() async {
    String url = "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg";
    await CachedNetworkImage.evictFromCache(url);
  }

  void _showMsg(String date, String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            title: Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    Text("اطلاعیه ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            fontSize: 20)),
                    Divider(
                      color: Colors.black87,
                      thickness: 2,
                    )
                  ],
                )),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 9),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl:
                              "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg",
                          placeholder: (context, url) =>
                              Image.asset("assets/images/empty.png"),
                          errorWidget: (context, url, error) =>
                              Image.asset("assets/images/empty.png"),
                        )),
                  ),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Row(
                        children: [
                          Icon(Icons.date_range_sharp),
                          SizedBox(
                            width: 15,
                          ),
                          Text("تاریخ اطلاعیه: " + date),
                        ],
                      )),
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            txt,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    _deleteImageFromCache();
                    Navigator.pop(context);
                    // SystemNavigator.pop();
                    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(widget._data))));
                  },
                  child: Text(
                    "     مطالعه کردم      ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20),
                  )),
            ],
          ),
        );
      },
    );
  }

  void _showDialog(String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl, child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
                  },
                  child: Text(
                    "        مطالعه کردم        ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ))
            ],
          ),
        );
      },
    );
  }

  // Widget WALLET() {
  //   return Container(
  //     child: FloatingActionButton(
  //       heroTag: 1,
  //       backgroundColor: bcf,
  //       onPressed: () {
  //         Navigator.push(context, MaterialPageRoute(builder: (context) =>
  //             Directionality(textDirection: TextDirection.rtl,
  //                 child: wallet_page(widget._data))));
  //       },
  //       tooltip: 'کیف پول',
  //       child: SvgPicture.asset(
  //         "assets/images/wallet.svg",
  //         color: Colors.white,
  //         width: 23,
  //       ),
  //       // child: Icon(
  //       //   Icons.account_box_outlined,
  //       //   size: 30,
  //       // ),
  //     ),
  //   );
  // }
  //
  // Widget TRANSACTION() {
  //   return Container(
  //     child: FloatingActionButton(
  //       isExtended: true,
  //       heroTag: 2,
  //       backgroundColor: bcf,
  //       onPressed: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     Directionality(
  //                         textDirection: TextDirection.rtl,
  //                         child: list_riz_page(widget._data))));
  //       },
  //       tooltip: 'ریزتراکنش',
  //       child: Icon(Icons.bar_chart, size: 33,),
  //     ),
  //   );
  // }
  //
  // Widget INFO() {
  //   return Container(
  //     child: FloatingActionButton(
  //       heroTag: 3,
  //       backgroundColor: bcf,
  //       onPressed: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     Directionality(
  //                         textDirection: TextDirection.rtl,
  //                         child: info_page(widget._data))));
  //       },
  //       tooltip: 'پروفایل',
  //       child: SvgPicture.asset(
  //         "assets/images/info.svg",
  //         color: Colors.white,
  //         width: 23,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget USERS() {
  //   return Container(
  //     child: FloatingActionButton(
  //       heroTag: 4,
  //       backgroundColor: bcf,
  //       onPressed: () {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) =>
  //                     Directionality(
  //                         textDirection: TextDirection.rtl,
  //                         child: users_page(widget._data))));
  //       },
  //       tooltip: 'زیرمجموعه ها',
  //       child: SvgPicture.asset(
  //         "assets/images/users.svg",
  //         color: Colors.white,
  //         width: 23,
  //       ),
  //     ),
  //   );
  // }
  //
  // Widget toggle() {
  //   var size = MediaQuery
  //       .of(context)
  //       .size;
  //   return Container(
  //     child: FloatingActionButton(
  //       //   foregroundColor: Color(0xffffffff),
  //       heroTag: 5,
  //       backgroundColor: Color(0xff000000),
  //       onPressed: animate,
  //
  //       tooltip: 'گزینه ها',
  //       child: GestureDetector(
  //         onTap: animate,
  //         child: ClipOval(
  //           child: Material(
  //             child: InkWell(
  //               child: SizedBox(
  //                 width: size.width * .12,
  //                 height: size.width * .12,
  //                 child: Container(
  //                   // color: Color(0xcc0d47a1),
  //                     alignment: Alignment.center,
  //                     decoration: BoxDecoration(
  //                       color: Color(0xffffffff),
  //                       //  image: DecorationImage(image: AssetImage("assets/images/person.png"))
  //                     ),
  //                     //child: Image.asset("assets/images/person.png")
  //                     child:
  //
  //                     FutureBuilder<String>(
  //                       future: getImg(),
  //                       builder: (context, AsyncSnapshot<String> snapshot) {
  //                         // print("-----"+snapshot.data!.toString());
  //                         if (snapshot.hasData) {
  //                           //  List<News> _news2 = snapshot.data!;
  //                           return
  //                             //   NetworkImage(snapshot.data!.toString());
  //                             CachedNetworkImage(
  //                               imageUrl: snapshot.data!.toString(),
  //                               //imageUrl: snapshot.data!.toString() ,
  //                               placeholder: (context, url) =>
  //                                   Image.asset("assets/images/person.png"),
  //                               errorWidget: (context, url, error) =>
  //                                   Image.asset("assets/images/person.png"),
  //                             );
  //                         } else if (snapshot.hasError) {
  //                           return Container();
  //                         } else
  //                           return Container();
  //                       },
  //                     )),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       // child: CircleAvatar(backgroundImage: AssetImage("assets/images/person.jpg"),)
  //       // child: AnimatedIcon(
  //       //   icon: AnimatedIcons.menu_close,
  //       //   progress: _animateIcon,
  //       // ),
  //     ),
  //   );
  // }

  Future<String> getImg() async {
    String response = await OnlineServices.getImg({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //print (await response);
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getInformation() async {
    String response = await OnlineServices.getInformation({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //print (await response);
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getTarget() async {
    String res = "";
    String res2 = "";
    String response = await OnlineServices.getTarget({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    res =
        response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
    target1 = res.split(",")[1];
    target2 = res.split(",")[2];
    setState(() {});
    return res;
  }

  Future<String> getParvandeAll() async {
    String response = await OnlineServices.getParvandeAll(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getCountOfPSP() async {
    String response = await OnlineServices.getCountOfPSP({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //response = "28,39,55,79";
    PASARGAD = double.parse(response.split(",")[0]);
    IRANKISH = double.parse(response.split(",")[1]);
    SADAD = double.parse(response.split(",")[2]);
    BEHPARDAKHT = double.parse(response.split(",")[3]);
    PARDAKHTNOVIN = double.parse(response.split(",")[4]);
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getEslahAll() async {
    String response = await OnlineServices.getParvandeEslah(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getPazirandeLaghvCount() async {
    String response = await OnlineServices.getPazirandeLaghvCount(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getTakhsisAll() async {
    String response = await OnlineServices.getParvandeTakhsis({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getEmBazCount() async {
    String res = "";
    String response = await OnlineServices.getEmBazCount({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    res =
        response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
    //   res = "81,50,30";
    return res;

    return res;
  }

  Future<String> getTakhsisReadyCount() async {
    String response = await OnlineServices.getTakhsisReadyCount(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getTakhsisNasbCount() async {
    String response = await OnlineServices.getTakhsisNasbCount(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getDeviceAllCount() async {
    String response = await OnlineServices.getDeviceAllCount(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getDeviceFreeCount() async {
    String response = await OnlineServices.getDeviceFreeCount({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  Future<String> getDeviceNewCount() async {
    String response = await OnlineServices.getDeviceNewCount(
        //{"agentcode" : widget._data.last.agentCode } );
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
        });
    return response
        .replaceAll("\n", "")
        .replaceAll("\t", "")
        .replaceAll("\r", "");
  }

  void _showDialog2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          CachedNetworkImage(
                            //imageUrl: snapshot.data!.toString().contains("d544") ? "q" :snapshot.data!.toString() ,
                            imageUrl:
                                "http://194.33.125.128:80/Portal/pos/notif-main/notif.jpg",
                            placeholder: (context, url) =>
                                Image.asset("assets/images/person.png"),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/person.png"),
                          ),
                          Text(msg)
                        ],
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // SystemNavigator.pop();
                    //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(widget._data))));
                  },
                  child: Text(
                    "باشه",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
            ],
          ),
        );
      },
    );
  }

  void getPersonalMessage() async {
    Map response;
    response = await OnlineServices.getPersonalMessagee({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    if (response["data"] != "free") {
      _message.clear();
      _message.addAll(response['data']);
      //   print(_message.last.message);
      msg = _message.last.message;
      _showDialog2(context);
      setState(() {});
    } else {
      //  print("freeeeeee");
    }
  }

  Widget itmColor(String title, Color color) {
    String logo = title == "پاسارگاد"
        ? "pasargad"
        : title == "ایران کیش"
            ? "irankish"
            : title == "سداد"
                ? "sadad"
                : title == "به پرداخت"
                    ? "behpardakht"
                    : title == "سپهر"
                        ? "sepehr"
                        : title == "پرداخت نوین"
                            ? "novin"
                            : "";
    return Row(
      children: [
        Container(
          height: 8,
          width: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Container(
          margin: EdgeInsets.only(left: 5),
          height: 30,
          width: 30,
          child: Image.asset("assets/images/${logo}.png"),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 11),
        ),
      ],
    );
  }

  Widget loading() {
    return LayoutBuilder(
      builder: (context, _) {
        return IconButton(
          icon: Icon(Icons.play_circle_filled),
          iconSize: 50.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => ShowCase(),
                fullscreenDialog: true,
              ),
            );
          },
        );
      },
    );
  }
}
