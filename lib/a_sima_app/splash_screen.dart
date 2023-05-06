// ignore_for_file: missing_return, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

import 'login_page.dart';


class splash_screen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>  splash_screenState();
}

class splash_screenState extends State<splash_screen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
          Navigator.pushReplacement(context, MaterialPageRoute(
                             builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: login_page())));

    });    super.initState();
  }
  int i = 0;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    var safePadding = MediaQuery.of(context).padding.top;
    var mainHeight = size.height - safePadding;
    Color c1 = Color(0x88ffffff);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xfffa95a7)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white
          
          ,
          appBar: AppBar(
            toolbarHeight: 0,
            brightness: Brightness.light,
            backgroundColor: Color(0xffffffff),
          ),
          body: Container(
              width: size.width ,
              height: size.height,
              //height: size.height,
           //   child: Image.asset("assets/images/2022.jpg",fit: BoxFit.cover,),
          ),
        ),);
  }

}
