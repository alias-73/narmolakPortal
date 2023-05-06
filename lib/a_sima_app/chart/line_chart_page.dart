import 'package:flutter/material.dart';

import '../models/agentModel.dart';
import 'line_chart_sample1.dart';

class LineChartPage extends StatelessWidget {
  List<AgentModel> _Agent = [];

  LineChartPage(this._Agent) ;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*.04),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(0)),
        color: const Color(0xfff1f1f1),

      ),
      child: ListView(

        children: <Widget>[

          LineChartSample1(_Agent),
          SizedBox(height: 5,),
          Row( mainAxisAlignment: MainAxisAlignment.center,children: [
            itmColor("پذیرنده" , Color(0xffc40a21)),
            SizedBox(width: 40,),
            itmColor("تخصیص" , Color(0xffffbe00)),
          ]),

        ],
      ),
    );
  }
}
Widget itmColor(String title, Color color) {
  return Row(
    children: [
      Container(
        margin: EdgeInsets.only(left: 5),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color
        ),
      ),
      Text(title),

    ],
  );
}