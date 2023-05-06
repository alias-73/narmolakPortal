import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/profile/RizWalletAccordian.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'dart:ui';

import 'package:sima_portal/a_sima_app/tarh_List.dart';
import 'package:sima_portal/a_sima_app/transfer_credit.dart';
import 'RizWallet.dart';
import 'package:flutter/foundation.dart';
import 'package:pie_chart/pie_chart.dart';
import '../models/rizWalletModel.dart';
import  'package:persian_number_utility/persian_number_utility.dart';

class wallet_page extends StatefulWidget {

  List<AgentModel> _Agentdata = [];

  wallet_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => infoState();

}
enum LegendShape { Circle, Rectangle }

class infoState extends State<wallet_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String msg = " s";
  late String add;
  int i = 0;
  double X = 0;
  double Y = 0;

  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<RizWalletModel> _data = [];
  late Map response;
  bool isOpened = false;

  final colorList = <Color>[
    Color(0xffcc0202),
    Color(0xff02cc02),

  ];

  ChartType _chartType = ChartType.ring; ///$$$$$
  bool _showCenterText = false;
  double _ringStrokeWidth = 50; ///$$$$$
  double _chartLegendSpacing = 20; ///$$$$$

  bool _showLegendsInRow = false;
  bool _showLegends = false;

  bool _showChartValueBackground = true;
  bool _showChartValues = true;
  bool _showChartValuesInPercentage = true;  ///$$$$$
  bool _showChartValuesOutside = false;

  bool _showGradientColors = false;

  LegendShape _legendShape = LegendShape.Circle;
  LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;

  @override
  void initState() {
    getBedSum();
    getBestSum();
    super.initState();
  }


  void getBedSum() async {
    String response = await OnlineServices.getBedSum(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode
        });
    X = double.parse(response);

    setState(() {});
  }

  void getBestSum() async {
    String response = await OnlineServices.getBestSum(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode
        });
    Y = double.parse(response);
    setState(() {
    });
  }

  Future<String> getBalance() async {
    String response = await OnlineServices.getBalance2(
        {
          "agentcode": widget._Agentdata.last.agentCode,
           "usercode": widget._Agentdata.last.userCode
        });
    return response;
  }


  @override
  Widget build(BuildContext context) {
    final dataMap = <String, double>{
      "برداشت": X,
      "واریز": Y,
    };
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: Duration(milliseconds: 1000),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: MediaQuery.of(context).size.width / 3.2 > 300
          ? 300
          : MediaQuery.of(context).size.width * .5,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: false,
        legendShape: _legendShape == LegendShape.Circle
            ? BoxShape.circle
            : BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: 50,
      emptyColor: Colors.grey,
    //  gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
    );
///690120000000009538779034*11000001231170*710150000000118800110604
    //print("__" + widget._data.last.userCode + "__");
    // TODO: implement build
    var size = MediaQuery
        .of(context)
        .size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight;
    double itemHeight = mainHeight * .45;
    double itemWidth = size.width * .45;
    double h = .13;
    double fontSize = 16;
    // print(appBarHeight);
    // print(widget._data.last.agentCode);

    return  Scaffold(
      backgroundColor: Color(0xfffac80a),
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              height: size.height * .3,
              width: size.width,
              color: Color(0x00ffffff),
              child: Container(
                padding: EdgeInsets.all(20),
                height: size.height * .3 * .8,
                width: size.width * .85,

                decoration: BoxDecoration(
                  color: Color(0xaaffffff),
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    Icon(Icons.account_balance_wallet_outlined, size: 40,),
                    //SizedBox(height: mainHeight * .3 * 0.05),
                    Text("موجودی", style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 23),),
                  ],),

                  FutureBuilder<String>(future: getBalance(),
                    builder: (context, AsyncSnapshot<String> snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data!.toPersianDigit() + " ریال",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 35),);
                      } else if (snapshot.hasError) {return Container();} else return Container();},)

                ],),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffffffff),
                borderRadius: BorderRadius.only(topRight: Radius.circular(60),
                    topLeft: Radius.circular(60)),
              ),
              height: size.height * .7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    height: size.height * .7 * .5,
                    width: size.width,
                    child: LayoutBuilder(
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
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    width: size.width * .9,
                    decoration: BoxDecoration(
                      color: Color(0x22000000),
                      borderRadius: BorderRadius.all( Radius.circular(30)),
                    ),
                    height: size.height * .7 * .2,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                      GestureDetector(onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: rizWallet_page(widget._Agentdata)))
                        );
                      }, child:
                      Text("تراکنش ها", style: TextStyle(color: Colors.black,fontSize: fontSize),) ,),
                      Container(color: Color(0x64000000),height: 50,width: 1,),
                      GestureDetector(onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: tarh_page()))
                        );
                      }, child: Text("افزایش اعتبار", style: TextStyle(color: Colors.black,fontSize: fontSize),),),
                      Container(color: Color(0x64000000),height: 50,width: 1,),
                      GestureDetector(onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: transfer_page(widget._Agentdata)))
                        );
                      }, child: Text("انتقال اعتبار", style: TextStyle(color: Colors.black,fontSize: fontSize),),),

                    ],),)
                ],
              ),)


          ],),
      )
      ,
    );
  }

  Widget Button(String txt, IconData ic, Color c) {
    var size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.zero,
      alignment: Alignment.center,
      //height: size.height * .7 * .4,
      width: size.width * .425,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
         //   Icon(ic, size: 40, color: Colors.black,),
           // SizedBox(height: size.height * .35 * 0.05),
            Text(txt, style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20),)


          ],),
          //   ,
        ],
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