import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/chart1Model.dart';
import '../services/online_services.dart';

class _LineChart extends StatelessWidget {
  double h;
  double w;
  List<Chart1Model> _data1 = [];
  List<Chart1Model> _data2 = [];

  _LineChart(this._data1, this._data2, this.h, this.w);
  double bigger = 0;
  double smaller = 10000;

  @override
  Widget build(BuildContext context) {
    checkBiger();
    return LineChart(
      sampleData1,
      swapAnimationDuration: const Duration(milliseconds: 250),
    );
  }

  void checkBiger() {
    for (int i = 0; i < _data1.length; i++) {
      double.parse(_data1[i].count) > bigger
          ? bigger = double.parse(_data1[i].count)
          : null;
    }
    for (int i = 0; i < _data2.length; i++) {
      double.parse(_data2[i].count) > bigger
          ? bigger = double.parse(_data2[i].count)
          : null;
    }

    for (int i = 0; i < _data1.length; i++) {
      double.parse(_data1[i].count) < smaller
          ? smaller = double.parse(_data1[i].count)
          : null;
    }
    for (int i = 0; i < _data2.length; i++) {
      double.parse(_data2[i].count) < smaller
          ? smaller = double.parse(_data2[i].count)
          : null;
    }
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
        minX: 0,
        maxX: 6,
        maxY: bigger,
        minY: smaller,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  LineTouchData get lineTouchData2 => LineTouchData(
        enabled: false,
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Color(0xff75729e),
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = "";

    text = value.toInt().toString();

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 1,
        reservedSize: 40,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    print("__________________________________");
    // print(_data1[0]);
    const style = TextStyle(
      color: Color(0xff72719b),
      fontWeight: FontWeight.w400,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = Text(_data1[0].date.toString().split("/")[2], style: style);

        break;
      case 1:
        text = Text(_data1[1].date.toString().split("/")[2], style: style);
        break;
      case 2:
        text = Text(_data1[2].date.toString().split("/")[2], style: style);
        break;
      case 3:
        text = Text(_data1[3].date.toString().split("/")[2], style: style);
        break;
      case 4:
        text = Text(_data1[4].date.toString().split("/")[2], style: style);
        break;
      case 5:
        text = Text(_data1[5].date.toString().split("/")[2], style: style);
        break;
      case 6:
        text = Text(_data1[6].date.toString().split("/")[2], style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 40,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Color(0xff4e4965), width: 3),
          left: BorderSide(color: Colors.transparent),
          right: BorderSide(color: Colors.transparent),
          top: BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: false,
        color: const Color(0xffc40a21),
        barWidth: 3,
        isStrokeCapRound: false,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(0, _data1.length > 0 ? double.parse(_data1[0].count) : 0.0),
          FlSpot(1, _data1.length > 0 ? double.parse(_data1[1].count) : 0.0),
          FlSpot(2, _data1.length > 0 ? double.parse(_data1[2].count) : 0.0),
          FlSpot(3, _data1.length > 0 ? double.parse(_data1[3].count) : 0.0),
          FlSpot(4, _data1.length > 0 ? double.parse(_data1[4].count) : 0.0),
          FlSpot(5, _data1.length > 0 ? double.parse(_data1[5].count) : 0.0),
          FlSpot(6, _data1.length > 0 ? double.parse(_data1[6].count) : 0.0),
        ],
      );
  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: false,
        color: const Color(0xffffbe00),
        barWidth: 3,
        isStrokeCapRound: false,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: [
          FlSpot(0, _data2.length > 0 ? double.parse(_data2[0].count) : 0.0),
          FlSpot(1, _data2.length > 0 ? double.parse(_data2[1].count) : 0.0),
          FlSpot(2, _data2.length > 0 ? double.parse(_data2[2].count) : 0.0),
          FlSpot(3, _data2.length > 0 ? double.parse(_data2[3].count) : 0.0),
          FlSpot(4, _data2.length > 0 ? double.parse(_data2[4].count) : 0.0),
          FlSpot(5, _data2.length > 0 ? double.parse(_data2[5].count) : 0.0),
          FlSpot(6, _data2.length > 0 ? double.parse(_data2[6].count) : 0.0),
        ],
      );
}

class LineChartSample1 extends StatefulWidget {
  List<AgentModel> _Agent = [];
  LineChartSample1(this._Agent);
  @override
  State<StatefulWidget> createState() => LineChartSample1State();
}

class LineChartSample1State extends State<LineChartSample1> {
  List<Chart1Model> _data1 = [];
  List<Chart1Model> _data2 = [];
  bool isShowChart = false;
  late Map response1;
  late Map response2;

  @override
  void initState() {
    getChartData1();

    Future.delayed(const Duration(milliseconds: 3000), () {
      isShowChart = true;
      setState(() {});
    });
    super.initState();
  }

  void getChartData1() async {
    response1 = await OnlineServices.getChart1({
      "agentcode": widget._Agent.last.agentCode,
      "usercode": widget._Agent.last.userCode
    });

    response2 = await OnlineServices.getChart2({
      "agentcode": widget._Agent.last.agentCode,
      "usercode": widget._Agent.last.userCode
    });
    //  print(response);
    if (response1["data"] != "free") {
      _data1.clear();
      _data1.addAll(response1['data']);
    }

    if (response2["data"] != "free") {
      _data2.clear();
      _data2.addAll(response2['data']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .3,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        gradient: LinearGradient(
          colors: [
            Color(0xffffffff),
            Color(0xffffffff),
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 16.0, left: 6.0),
                  child: isShowChart
                      ? _LineChart(
                          _data1,
                          _data2,
                          MediaQuery.of(context).size.height,
                          MediaQuery.of(context).size.width)
                      : SpinKitSpinningLines(color: Colors.black),
                ),
              ),
            ],
          ),
          //    IconButton(onPressed: (){getChartData();}, icon: Icon(Icons.refresh)),
        ],
      ),
    );
  }
}
