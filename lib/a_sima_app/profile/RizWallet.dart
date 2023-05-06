
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/profile/RizWalletAccordian.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'dart:ui';

import '../components/Styles.dart';

import '../models/PersonalMessageModel.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../models/rizWalletModel.dart';

class rizWallet_page extends StatefulWidget {

  List<AgentModel> _Agentdata = [];
  rizWallet_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => infoState();

}

class infoState extends State<rizWallet_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String msg = " s";
 late String add;
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<RizWalletModel> _data = [];
  List<RizWalletModel> _data2 = [];
//  List<PazirandeModel> _data3 = [];
  late Map response;
  bool isOpened = false;

  @override
  void initState() {
    super.initState();
  }

  Future<String> getBalance() async {
    String response = await OnlineServices.getBalance(
        {"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
    return response;
  }

  Future<List<RizWalletModel>>_getData() async {
    i++;
    if (i <2) {
      response = await OnlineServices.getRizWallet({"agentcode" : widget._Agentdata.last.agentCode,"usercode" : widget._Agentdata.last.userCode} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        // print(_data.length);

        Future.delayed(const Duration(milliseconds: 1000), () {
          setState(() {
            // Here you can write your code for open view
          });
// Here you can write your code

          // setState(() {
          //   // Here you can write your code for open view
          // });

        });

      }
      else
      {
        isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }


  @override
  Widget build(BuildContext context) {
    //print("__" + widget._data.last.userCode + "__");
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight;
    double itemHeight = mainHeight * .45;
    double itemWidth = size.width * .45;
    double h = .13;
   // print(widget._data.last.userCode);
   // print(widget._data.last.agentCode);

    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست تراکنش ها","", Icons.edit, (){})),

      body: Container(
        color: Color(0x11000000),
        padding: EdgeInsets.zero,
        alignment: Alignment.center,
        height: mainHeight ,
        width: size.width,
        // decoration: BoxDecoration(
        //
        //   color: Color(0xffffad42),
        //   borderRadius: BorderRadius.only(bottomRight: Radius.circular(80),bottomLeft: Radius.circular(80)),
        //   //border: Border.all(color: Color(0xffffffff))
        // ),
        // color: Colors.blue,
        child: Stack(
          children: [
            FutureBuilder<List<RizWalletModel>>(future: _getData(),
              builder: (context, AsyncSnapshot<List<RizWalletModel>> snapshot) {
                if (snapshot.hasData) {
                  return
                    // Accordion(
                    //     maxOpenSections: 4,
                    //     headerBorderRadius: 20,
                    //     headerBackgroundColor: Color(0xff999999),
                    //     headerPadding: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    //     children: [
                    //     AccordionSection(
                    //       isOpen: true,
                    //       leftIcon: Icon(Icons.insights_rounded, color: Colors.white),
                    //       header: Text('Introduction', style: _headerStyle),
                    //       content: Text(_loremIpsum2, style: _contentStyle),
                    //       contentHorizontalPadding: 20,
                    //     ),
                    //
                    //     ]);
                    ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                        });
                }
                /*

                     */
                else if (snapshot.hasError) {return Container();} else return Container() ;},),
            _data2.length < 1 && isFree == false ?
            Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
      ),
    ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery
        .of(context)
        .size;
    var blockSize = size.width / 100;
    return
      RizWalletAccordion("", "", _data, index, size, widget._Agentdata);
  }


}