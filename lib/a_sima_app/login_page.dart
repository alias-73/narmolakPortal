import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:connectivity/connectivity.dart';
import 'package:cool_alert/cool_alert.dart';
// import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_animator/widgets/animator_widget.dart';
import 'package:flutter_animator/widgets/specials/roll_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:sima_portal/a_sima_app/q/screens/splash_q.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/test.dart';
import 'package:url_launcher/url_launcher.dart';
import '../case.dart';
import 'appbar_home.dart';
import 'components/Styles.dart';
import 'components/delayed_animation.dart';
import 'errogPage.dart';
import 'models/agentModel.dart';

/// razavi  razavi@8532
/// barari  barari4382
///

class login_page extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => sampleState();
}

class sampleState extends State<login_page> with SingleTickerProviderStateMixin{
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  int i = 0;

  final int delayedAmount = 1000;
  late double _scale;
  late  AnimationController _controller;
  int version = 25 ;
  int UpVersion = 0;
  bool? _hasBioSensor;

  bool isTesting = false;
  List<AgentModel> _data = [];
  String info = "0";
  bool remember = false;
  bool privacyPolicy = true;
  String userToken = "";
  bool _passwordVisible = false;
  late String privacy;
  late String en_message = "";
  bool isAuth = false;
  late bool AllowLogin = false;
  bool? isBio = false;
  TextEditingController? controller1 = TextEditingController(text: "demo");
  TextEditingController? controller2 = TextEditingController(text: "demo");

  void notify() async {

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    var messaging = FirebaseMessaging.instance;
    var token = await messaging.getToken();
    userToken = token.toString();
    // print("________________________________");
    // print(userToken);
    FirebaseMessaging.onMessage.listen((event) {});
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }

  setRememberPrefs(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("remember",state);

  }

  // lastVersionChanges() async {
  //   void ShowLastChanges() async {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     // prefs.remove("last_version");
  //     prefs.setString("last_version" , "$version").toString();
  //     // print("seted: ${prefs.getString("last_version")}");
  //     String message = await (OnlineServices()).getlastChanges({"noskhe" : version.toString()});
  //     // print("message: $message");
  //     _showLastChanges(message);
  //
  //   }
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String versionChange = prefs.getString("last_version").toString();
  //   // print(versionChange);
  //   versionChange.contains(version.toString()) ? null :
  //   ShowLastChanges();
  // }

  checkEnablePortal() async {
      en_message = await (OnlineServices()).checkEnablePortal();

      // en_message="akslad";
      en_message.contains("yes") ?
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: errorPage(en_message))))
          : en_message.contains("no") ? null :
      Comp.showSnack(context,Icons.warning_amber_rounded,"لطفا از اتصال دستگاه خود به اینترنت اطمینان حاصل نمایید");

  }


  void getRememberPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getBool("remember").toString().contains("null") ? null : remember = prefs.getBool("remember")!;
    setState(() {});

  }

  setPrefs(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String pass = _key2.currentState!.value.toString();
    await prefs.setString("info", name  + "," + _key1.currentState!.value.toString()  + "," + pass);
  }

  void getBioPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getBool("isBio").toString().contains("null") ? null : isBio = prefs.getBool("isBio");
    setState(() {});
  }

  void getPrefs(int i) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.remove("info");
    // prefs.remove("isBio");
    i == 0 ? prefs.remove("info") : null;
    setState(() {});
    await prefs.getString("info").toString().contains("null") ? null : info = prefs.getString("info").toString();
    setState(() {});
    if(info == "null" || info == "0")
    {
      info = "0";
    }
    else
    {
      remember == true ? controller1 = TextEditingController(text: info.split(",")[1]) : null;
      remember == true ? controller2 = TextEditingController(text: info.split(",")[2]) : null;

      isAuth = true;
      setState(() {});
      //  i == 0 ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: login_page()))) :
      //  isBio == true ? Future.delayed(const Duration(milliseconds: 3000), () {
      //  isAuth = true;
      // setState(() {});
      // if (UpVersion <= version) {
      //   _checkBio();
      //  // sendDataForLogin2();
      // }
      // }) : sendDataForLogin3();
    }
  }
  //
  // void getPrivacyPolicy() async {
  //   privacy = await (OnlineServices()).getPrivacyPolicy();
  // }


  final GlobalKey<AnimatorWidgetState> basicAnimation1 = GlobalKey<AnimatorWidgetState>();
  final GlobalKey<AnimatorWidgetState> basicAnimation2 = GlobalKey<AnimatorWidgetState>();

  @override
  dispose() {
    // print("____________________________");
    super.dispose();
  }


  @override
  void initState() {
    getBioPrefs();
    getRememberPrefs();
    // getPrivacyPolicy();
    notify();
    getPrefs(1);
    checkNewVersion();
    checkEnablePortal();

      // lastVersionChanges();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    //  Future.delayed(const Duration(milliseconds: 1000), () {basicAnimation2.currentState?.forward();});
    loadingd();
    super.initState();
  }

  void loadingd(){
    Future.delayed(const Duration(milliseconds: 1500), () {basicAnimation2.currentState?.forward(); loadingd();});}

  String text = "Stop Service";
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    double r = 20;
    double l = 20;
    double t = 10;
    double b = 10;

    double hItem = size.height * .35;

    Color cl = Colors.black;
    final color = Colors.black;
    _scale = 1 - _controller.value;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body:

        SafeArea(
          child:  Stack(
            alignment: Alignment.topCenter,
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * .03,),
                  Image.asset("assets/images/appbar_logo.png",width: 150 ),
                  DelayedAnimation(
                    child: Text("گروه نرم افزاری نرمولک", style: TextStyle(fontWeight: FontWeight.w800, color: Color(0xff0f703a), fontSize: 20)),
                    delay: delayedAmount + 1400,
                  ),

                  DelayedAnimation(
                    child: txtBox(
                        false, "نام کاربری", Icons.person, _key1 , controller1! ),
                    delay: delayedAmount + 1400,
                  ),
                  SizedBox(height: 0.06,),
                  DelayedAnimation(
                    child: txtBox(true, "رمز عبور", Icons.lock, _key2 , controller2!),
                    delay: delayedAmount + 1600,
                  ),
                  SizedBox(height: 0.04,),
                  DelayedAnimation(
                    delay: delayedAmount + 1800,
                    child:  Column(
                      children: [
                        Container(width: size.width * .7, child: Padding(
                          padding: EdgeInsets.only(left: 0, right: 0, top: 15),
                          child: ElevatedButton(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(Icons.add_box_outlined,color: Color(0x00000000),),
                              Text("ورود", style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),),
                              Icon(Icons.arrow_forward,color: Colors.black,)
                            ],
                          ),
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(20),
                                  backgroundColor: MaterialStateProperty.all(Color(
                                      0xffdadada))),
                              onLongPress: (){
                              //  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: test())));

                              },
                              onPressed: () {
                                if (_key1.currentState!.value
                                    .toString()
                                    .length > 1 && _key2.currentState!.value
                                    .toString()
                                    .length > 2) {
                                  //   print(_key1.currentState!.value.toString().trim());
                                  sendDataForLogin();
                                }
                                else
                                  Comp.showSnack(
                                      context, Icons.warning_amber_rounded,
                                      "لطفا نام کاربری یا رمز عبور را وارد نمایید");
                              }
                          ),
                        )),
                        SizedBox(height: size.height * .02,),

                        SizedBox(width: size.width * .6, child: CheckboxListTile(title: Text("مرا بخاطر داشته باش"),activeColor: Colors.black, onChanged: (bool? value) { setRememberPrefs(value!); remember = value; setState(() {} );}, value: remember,),),
                        SizedBox(height: size.height * .02,),


                        // Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                        //   SizedBox(width: size.width * .46),
                        //   IconButton(onPressed: (){_getAuth();}, icon: Icon(Icons.fingerprint,size: 100,)),
                        //   SizedBox(width: size.width * .3),
                        //
                        // ])
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * .09,),
                  SizedBox(height: size.height * 0.12,child: RollIn(key: basicAnimation1,child: Container(
                      width: size.width,
                      child:
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              avatar_item("sadad2"),
                              avatar_item("irankish"),
                              avatar_item("pasargad"),
                              avatar_item("behpardakht"),
                              avatar_item("sepehr"),
                              avatar_item("novin"),

                            ],
                          ),

                        ],
                      )

                  )),),

                  SizedBox(height: size.height * .12,),


                ],
              ),


              Align(child: Padding(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(" "),
                    Text("نسخه 2.0.5"),

                  ]),padding: EdgeInsets.only(left: 10,right: 10,bottom: 7),), alignment: Alignment.bottomLeft,),
            ],
          ),
        )
    );
  }

  // void _showLastChanges(String message) {
  //   var size = MediaQuery.of(context).size;
  //   showDialog<void>(
  //     context: context,
  //     barrierDismissible: true, // user must tap button!
  //     builder: (BuildContext context) {
  //       return Container(
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.all(Radius.circular(18))),
  //         child: AlertDialog(
  //           title: Directionality(
  //               textDirection: TextDirection.rtl,
  //               child: Text("تغییرات نسخه اخیر",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.black87,
  //                       fontSize: 20))),
  //           content: SingleChildScrollView(
  //             child: ListBody(
  //               children: <Widget>[
  //
  //                 Directionality(
  //                     textDirection: TextDirection.rtl,
  //                     child: Column(
  //                       children: [
  //                         SizedBox(
  //                           height: 10,
  //                         ),
  //                         /// حل مشکل چندبار لاگین شدن
  //                         /// حل مشکل عدم نمایش تغییرات اخیر
  //                         Html(data:"""
  //                        $message
  //                        """
  //                         ),
  //                       ],
  //                     ))
  //               ],
  //             ),
  //           ),
  //           actions: <Widget>[
  //             ElevatedButton(
  //                 onPressed: () {Navigator.pop(context);},
  //                 child: Text(
  //                   "     مطالعه کردم      ",
  //                   style: TextStyle(
  //                       fontWeight: FontWeight.bold,
  //                       color: Colors.white,
  //                       fontSize: 20),
  //                 )),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  Widget avatar_item(String logo){
    double endR = 20;
    double radius = 30;
    return AvatarGlow(
      endRadius: endR,
      duration: Duration(seconds: 2),
      glowColor: Colors.white24,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 30.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.grey[100],
            radius: radius,
            child: Padding(padding: EdgeInsets.all(2),child: Image.asset("assets/images/${logo}.png"),),
          )),
    );
  }

  Widget avatar_item2(String logo){
    double endR = 60;
    double radius = 40;
    return AvatarGlow(
      endRadius: endR,
      duration: Duration(seconds: 2),
      glowColor: Colors.white,
      repeat: true,
      repeatPauseDuration: Duration(seconds: 2),
      startDelay: Duration(seconds: 1),
      child: Material(
          elevation: 30.0,
          shape: CircleBorder(),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: radius,
            child: Padding(padding: EdgeInsets.all(11),child: Image.asset("assets/images/${logo}.png"),),
          )),
    );
  }

  void _showprivacy() {
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
                child: Text("حفظ سیاست های حریم خصوصی",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                        fontSize: 20))),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            privacy,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {Navigator.pop(context);},
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

  Widget txtBox(bool sec,String label, IconData ic, Key key , TextEditingController controller ) {
    var size = MediaQuery.of(context).size;
    Color cl = Color(0xff565656);
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: TextFormField(
        controller: controller,
        obscureText: sec ? !_passwordVisible : false,
        textInputAction: TextInputAction.next,
        //initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.left,
        key: key,
        style: TextStyle(color: cl, fontWeight: key == _key1 ? FontWeight.w600 : FontWeight.w400),
        //   initialValue: 'Input text',
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon:  IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              !sec ? Icons.height : _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: sec == true ? Color(0xff3d3d3d) : Color(0x00000000) ,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              sec ? setState(() {
                _passwordVisible =
                !_passwordVisible;
              }) : Null;
            },) ,
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          // enabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          //
          // ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w300),
          // focusedBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.all(Radius.circular(10.0)),
          //     borderSide: BorderSide.none),

          labelText: label,

          //  border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

        ),
      ),
    );
  }

  Future checkNewVersion() async {

    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      String response = await (OnlineServices()).checkNewVersion();

      UpVersion = int.parse(response
          .replaceAll("\n", "")
          .replaceAll("\r", "")
          .replaceAll("\t", ""));
      // print("_____________________");
      // print(UpVersion);

      if (UpVersion > version) {
        expireDialog();
      }
    }
    else
      Comp.showSnack(context,Icons.warning_amber_rounded,"لطفا از اتصال دستگاه خود به اینترنت اطمینان حاصل نمایید");

  }

  void expireDialog(){
    CoolAlert.show(
      context: context,
      confirmBtnText: "   خروج  ",
      type: CoolAlertType.warning,
      title: "خطای نسخه نرم افزار",
      onConfirmBtnTap: (){
        Navigator.pop(context);
        SystemNavigator.pop();
        },
      text: "لطفا نسخه جدید را از مدیر برنامه دریافت نمایید",
      backgroundColor: Colors.white,
    );
  }
  void expireDialog1(){
    CoolAlert.show(
      context: context,
      confirmBtnText: "   دانلود نسخه جدید  ",
      type: CoolAlertType.warning,
      title: "خطای نسخه نرم افزار",
      onConfirmBtnTap: (){
        Navigator.pop(context);
        _launchUrl("https://cafebazaar.ir/app/com.alias.sima_portal");
      },
      text: "لطفا نسخه جدید را از کافه بازار دانلود نمایید",
      backgroundColor: Colors.white,
    );
  }

///14.400  1.10.000003322-2
  ///55      12311-4
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch ';
    }
  }
  void sendDataForLogin() async {

    String Qresponse;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi &&
        (en_message.contains("yes")  || en_message.contains("no")) ) {
      if (UpVersion > version) {
        expireDialog();      } else {
        Map response;
        response = await (OnlineServices()).sendDataForLogin({
          "username": _key1.currentState!.value.toString(),
          "password": _key2.currentState!.value.toString(),
        });

        if (response['data'] != "free") {
          _data.clear();
          _data.addAll(response['data']);
          Qresponse = await OnlineServices.checkQuestionare({ "agentcode": _data.last.agentCode, "usercode": _data.last.userCode});

          sendToken(userToken, _data.last.agentCode, _data.last.userCode);
          setPrefs(_data.last.name);
          Qresponse == "yes" ?
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(_data))))
              :
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: introPage(_data))));


        } else {
          Comp.showSnack(context,Icons.warning_amber_rounded,"نام کاربری یا رمز عبور اشتباه است");

        }
      }
    } else
      {Comp.showSnack(context,Icons.wifi_off,"لطفا از اتصال دستگاه خود به اینترنت اطمینان حاصل نمایید");
      checkEnablePortal();
      checkNewVersion();
      }

  }


  void sendDataForLogin3() async {
    String Qresponse;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (UpVersion > version) {
        expireDialog();
      } else {
        // print("______________2222222222___________________");
        // print("______________2222${info}222222___________________");
        Map response;
        response = await (OnlineServices()).sendDataForLogin({
          "username": info.split(",")[1],
          "password": info.split(",")[2],
        });

        if(response['data'] == "free"){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("info");

        }

        if (response != null) {
          _data.clear();
          _data.addAll(response['data']);
          Qresponse = await OnlineServices.checkQuestionare({ "agentcode": _data.last.agentCode, "usercode": _data.last.userCode});

          sendToken(userToken, _data.last.agentCode, _data.last.userCode);
          setPrefs(_data.last.name);
          Qresponse == "yes" ?
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(_data))))
              :
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: introPage(_data))));

        } else {
          Comp.showSnack(context,Icons.warning_amber_rounded,"نام کاربری یا رمز عبور اشتباه است");

        }
      }
    } else
      Comp.showSnack(context,Icons.wifi_off,"لطفا از اتصال دستگاه خود به اینترنت اطمینان حاصل نمایید");

  }

  void sendToken(String token, String agentCode, String userCode) async {
    String response;    response = await (OnlineServices()).sendToken(
        {"token": userToken, "agentcode": agentCode, "usercode": userCode , "version":version.toString()});
  }

  void sendDataForLogin2() async {
    String Qresponse;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (UpVersion > version) {
        expireDialog();
      } else {
        Map response;
        response = await (OnlineServices()).sendDataForLogin({
          "username": info.split(",")[1],
          "password": info.split(",")[2],
        });
        // print("______________2222222222___________________");
        if(response['data'] == "free"){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove("info");

        }

        if (response != null) {
          _data.clear();
          _data.addAll(response['data']);
          Qresponse = await OnlineServices.checkQuestionare({ "agentcode": _data.last.agentCode, "usercode": _data.last.userCode});

          sendToken(userToken, _data.last.agentCode, _data.last.userCode);
          setPrefs(_data.last.name);
          Qresponse == "yes" ?
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(_data))))
              :
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: introPage(_data))));

        } else {
          Comp.showSnack(context,Icons.warning_amber_rounded,"نام کاربری یا رمز عبور اشتباه است");

        }
      }
    } else
      Comp.showSnack(context,Icons.wifi_off,"لطفا از اتصال دستگاه خود به اینترنت اطمینان حاصل نمایید");

  }


}
/*
 DelayedAnimation(
                  child:  Container(width: size.width * .9, child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                    child: Container(
                      // height: 50,
                      width: size.width * .9,
                      child:  Directionality(textDirection: TextDirection.rtl, child:  CheckboxListTile(title:  RichText(
                          text: TextSpan(
                              children: [
                                TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: "با ورود به پرتال سیماخوان، تمام "
                                ),
                                TextSpan(
                                    style: TextStyle(    decoration: TextDecoration.underline,color: Colors.black,fontStyle: FontStyle.italic,fontWeight: FontWeight.w800),
                                    text: "قوانین حفظ حریم خصوصی",
                                    recognizer: TapGestureRecognizer()..onTap =  () async{
                                      _showprivacy();
                                    }
                                ),
                                TextSpan(
                                    style: TextStyle(color: Colors.black),
                                    text: " را مطالعه و با آن موافقت میکنم."
                                ),
                              ]
                          )),
                        value: privacyPolicy,
                        activeColor: Colors.teal,
                        onChanged: (bool? value){
                          setState(() {
                            privacyPolicy = value!;
                          });
                        },)),
                    ),
                  )),
                  delay: delayedAmount + 2000,
                ),
 */