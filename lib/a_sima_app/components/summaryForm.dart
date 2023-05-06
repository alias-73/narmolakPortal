import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class summaryForm extends StatelessWidget {
  String txtTitle;
  IconData ic;
  Color color;
  String Key;

  summaryForm(
      {required this.txtTitle,required this.ic, required this.color,required this.Key });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double widthItem = size.width * .88;
    Color bcTextColor = Color(0x22000000);


    // TODO: implement build
    return Container(
      // height: 100,
      margin: EdgeInsets.only(top: 4),
      width: widthItem,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color, Color(0x99000000)]
          ),
          color: bcTextColor,
          borderRadius: BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: color)
      ),
      padding: EdgeInsets.only(right: 10, left: 10, top: 7, bottom: 7),
      child: Row(
        children: <Widget>[
          Container(
              width: widthItem * .5,
              child: Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(left: 7),
                      child: Icon(ic, color: color)),
                    Flexible(child: Text(txtTitle + ":", maxLines: 4, style: TextStyle(
                    color: Color(0xff000000), fontSize: fontSize4,
                  )))
                ],
              )
          ),
          Flexible(child: FutureBuilder<String>(future: getPrefs(Key),
            builder: (context, snapshot) {
               return Text(
                  snapshot.data!, overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(
                    color: Color(0xff000000), fontSize: fontSize4,
                  ));
            },) )

        ],
      ),
    );
  }

  Future<String> getPrefs(String key) async {
    String value = "---";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = prefs.getString(key)!;
    return value;
  }
}