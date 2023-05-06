
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

class about extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<about> {
  String about = "";

  @override
  void initState() {
    getLawsAndAbout();
    super.initState();
  }
  void getLawsAndAbout() async {
    String response = await OnlineServices.getLawsAndAbout();
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    about = response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "").split(",")[1];
    setState(() {});

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("درباره ما","", Icons.edit, (){})),

      backgroundColor: Color(0xffe3e3e3),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(9),
              padding: EdgeInsets.all(9),
              color: Colors.white,
              child: Text( about,
                  textAlign: TextAlign.right,style: TextStyle(
                      color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500)),
            )
          ],
        ),
      ),

    );
  }}