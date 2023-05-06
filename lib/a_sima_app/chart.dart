//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:sima_portal/a_sima_app/device/list_device.dart';
// import 'package:sima_portal/a_sima_app/models/agentModel.dart';
// import 'package:sima_portal/a_sima_app/models/brandModel.dart';
// import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
// import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
// import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
// import 'package:sima_portal/a_sima_app/services/online_services.dart';
// import 'package:sima_portal/a_sima_app/sima_home1.dart';
// import 'package:sima_portal/a_sima_app/components/Styles.dart';
//
// import 'models/chart1Model.dart';
//
// class chart extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => device_register_pageState();
//
// }
//
// class device_register_pageState extends State<chart> {
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   List<Chart1Model> _data = [];
//   List<Chart1Model> _data2 = [];
//   int i = 0;
//   bool isFree = false;
//   late Map response;
//
//   void getChart1() async {
//
//     i++;
//     if (i < 2  )
//     {
//       response = await OnlineServices.getChart1({ "agentcode": "0", "usercode": "0"} );
//       //  response = await OnlineServices.getRizList({"terminal": "92625457", "agentcode": "10063", "tarikh": "1400/08/05"} );
//         _data.clear();
//         _data.addAll(response['data']);
//         setState(() {});
//
//     }
//
//   }
//
//
//
//   LineChartData get sampleData1 => LineChartData(
//     lineTouchData: lineTouchData1,
//     gridData: gridData,
//     titlesData: titlesData1,
//     borderData: borderData,
//     lineBarsData: lineBarsData1,
//     minX: 0,
//     maxX: 6,
//     maxY: 4,
//     minY: 0,
//   );
//
//   LineTouchData get lineTouchData1 => LineTouchData(
//     handleBuiltInTouches: true,
//     touchTooltipData: LineTouchTooltipData(
//       tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
//     ),
//   );
//
//   FlTitlesData get titlesData1 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: bottomTitles,
//     ),
//     rightTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
//   ///CHART-months-pazirande-m
//
//   List<LineChartBarData> get lineBarsData1 => [
//     lineChartBarData1_1,
//     lineChartBarData1_4
//   ];
//
//   LineTouchData get lineTouchData2 => LineTouchData(
//     enabled: false,
//   );
//
//   FlTitlesData get titlesData2 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: bottomTitles,
//     ),
//     rightTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
//
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color(0xff75729e),
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1m';
//         break;
//       case 2:
//         text = '2m';
//         break;
//       case 3:
//         text = '3m';
//         break;
//       case 4:
//         text = '5m';
//         break;
//       case 5:
//         text = '8m';
//         break;
//       default:
//         return Container();
//     }
//
//     return Text(text, style: style, textAlign: TextAlign.center);
//   }
//
//   SideTitles leftTitles() => SideTitles(
//     getTitlesWidget: leftTitleWidgets,
//     showTitles: true,
//     interval: 1,
//     reservedSize: 40,
//   );
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Color(0xff72719b),
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 0:
//         text = const Text('0', style: style);
//         break;
//       case 1:
//         text = const Text('1', style: style);
//         break;
//       case 2:
//         text = const Text('2', style: style);
//         break;
//       case 3:
//         text = const Text('3', style: style);
//         break;
//       case 4:
//         text = const Text('4', style: style);
//         break;
//       case 5:
//         text = const Text('5', style: style);
//         break;
//       case 6:
//         text = const Text('6', style: style);
//         break;
//       default:
//         text = const Text('');
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 10,
//       child: text,
//     );
//   }
//
//   SideTitles get bottomTitles => SideTitles(
//     showTitles: true,
//     reservedSize: 32,
//     interval: 1,
//     getTitlesWidget: bottomTitleWidgets,
//   );
//
//   FlGridData get gridData => FlGridData(show: false);
//
//   FlBorderData get borderData => FlBorderData(
//     show: true,
//     border: const Border(
//       bottom: BorderSide(color: Color(0xff4e4965), width: 4),
//       left: BorderSide(color: Colors.transparent),
//       right: BorderSide(color: Colors.transparent),
//       top: BorderSide(color: Colors.transparent),
//     ),
//   );
//
//   LineChartBarData get lineChartBarData1_1 => LineChartBarData(
//     isCurved: true,
//     color: const Color(0xff056232),
//     barWidth: 8,
//     isStrokeCapRound: true,
//     dotData: FlDotData(show: false),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(0 , 3   ),
//       FlSpot(1 , 1.5 ),
//       FlSpot(2 , 1.4 ),
//       FlSpot(3 , 3.4 ),
//       FlSpot(4, 4  ),
//     ],
//   );
//
//   LineChartBarData get lineChartBarData1_4 => LineChartBarData(
//     isCurved: false,
//     color: const Color(0xffc40a21),
//     barWidth: 6,
//     isStrokeCapRound: false,
//
//     dotData: FlDotData(show: true),
//     belowBarData: BarAreaData(show: false),
//     spots: const [
//       FlSpot(0, 2.8),
//       FlSpot(1, 3.9),
//       FlSpot(2, 5),
//       FlSpot(3, 3.3),
//       FlSpot(5, 2.5),
//     ],
//   );
//
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     var size = MediaQuery
//         .of(context)
//         .size;
//
//     return LineChart(
//       sampleData1 ,
//       swapAnimationDuration: const Duration(milliseconds: 250),
//     );
//   }}