import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/models/rizWalletModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:flutter_icons/flutter_icons.dart';


import '../Pazirade/edit_Pazirande.dart';
import '../Pazirade/edit_PazirandeH.dart';

class RizWalletAccordion extends StatefulWidget {
  final String title;
  // BuildContext context;
  int index;
  var size;
  final String content;
  List<RizWalletModel> _data = [];
  List<AgentModel> _Agentdata = [];

  RizWalletAccordion(this.title, this.content, this._data,this.index,this.size, this._Agentdata);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<RizWalletAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
   double fontSize1 = 15;
   double fontSize2 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
  // var size = MediaQuery.of(widget.context).size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:(){
      setState(() {
        _showContent = !_showContent;
      });},child: Card(
      margin: EdgeInsets.only(bottom: 5,top: 10, right: 10, left: 10),
      child: Column(children: [
        ListTile(
            title:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: (widget.size.width-10) * .49,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.date_range_sharp,size: 20,),
                      SizedBox(width: 5,),
                      Flexible(child: Text( widget._data[widget.index].tarikh ,
                        textAlign: TextAlign.center,style: TextStyle(
                            color: primary, fontSize: fontSize1, fontWeight: FontWeight.w500),maxLines: 2,)),
                    ],
                  ),),
                Row(
                  children: [
                    Icon(Icons.info,size: 20,color: widget._data[widget.index].noe.toString().contains("برداشت") ? Colors.red : widget._data[widget.index].noe.toString().contains("واریز") ? Colors.green : primary),
                    SizedBox(width: 10,),
                    Text( widget._data[widget.index].noe,
                        style: TextStyle(
                            color: widget._data[widget.index].noe.toString().contains("برداشت") ? Colors.red : widget._data[widget.index].noe.toString().contains("واریز") ? Colors.green : primary, fontSize: fontSize1))
                  ],
                )
              ],
            )
        ),
        Padding(child: Divider(height: 1,color: Colors.red,),padding: EdgeInsets.only(right: 20),),
        _showContent
            ? Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            width: double.infinity,
            // height: 110,
            margin: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
            padding: EdgeInsets.only(bottom: 5,top: 5, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Expanded(child: Column(
                      children: [
                        widget._data[widget.index].bes == "0" ? items(widget._data[widget.index].bed, Icons.adjust) : items(widget._data[widget.index].bes, Icons.adjust),
                      ],

                    )),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        items(widget._data[widget.index].saat, Icons.access_time),
                      ],

                    )),

                  ],
                ),
                h(),
                items(widget._data[widget.index].sharh, Icons.message),


              ],
            )
        )
            : Container()
      ]),
    ),);
  }


  Widget h (){ double s = 12;return SizedBox( height: s); }

  Widget items (String txt , IconData ic){
    return Row(
      children: [
        Icon(ic , size: 25,),
        SizedBox(
          width: 5,
        ),
        Flexible(child: Text( txt == null ? "-" :  txt,
            style: TextStyle(
                color: primary, fontSize: 13, letterSpacing: .3))),

      ],
    );
  }

}