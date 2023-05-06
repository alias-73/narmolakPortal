
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

class bioAuth extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<bioAuth> {
  bool switchValue=true;
  bool? isBio = false;

  @override
  void initState() {
    getPrefs();
    super.initState();
  }

  setPrefs(bool state) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isBio",state);
    getPrefs();
  }

  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.getBool("isBio").toString().contains("null") ? null : isBio = prefs.getBool("isBio");
    print("_____________-----_______");
    print(isBio);
    setState(() {});
    if (isBio == "null" || isBio == "0") {
      //isBio = "0";
    }
    else {}
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.symmetric(horizontal: 18),child: Text("جهت فعالسازی احراز هویت بیومتریک (اثر انگشت)، کلید زیر را فعال کنید",
              textAlign: TextAlign.center,style: TextStyle(fontSize: 19,fontWeight: FontWeight.w500),)),
            SizedBox(height: 25,),
            CupertinoSwitch(
              activeColor: Colors.teal,
              value: isBio!,
              onChanged: (value) {
                setState(() {
                  switchValue = value;
                  setPrefs(switchValue);
                });
              },
            ),
            SizedBox(height: 20,),
            Icon(Icons.fingerprint,size: 155,)
          ],
        ),
      ),
    );
  }}