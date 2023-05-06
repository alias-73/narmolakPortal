import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sima_portal/a_sima_app/login_page.dart';
import 'a_sima_app/models/agentModel.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new sampleState();
}

class sampleState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    List<AgentModel> a = [];
    return MaterialApp(
      navigatorObservers: [FlutterSmartDialog.observer],
      builder: FlutterSmartDialog.init(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Sans',
        primaryColor: Colors.white,
        hintColor: Colors.black,
        accentColor: Colors.red,
        primarySwatch: Colors.green,
      ),
      home:
      //// new 
          Directionality(textDirection: TextDirection.rtl, child: login_page()),
    );
  }
}
