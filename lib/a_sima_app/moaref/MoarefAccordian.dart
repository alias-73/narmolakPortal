import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/Moaref/moaref-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';



class MoarefAccordion extends StatefulWidget {
  int index;
  var size;
  List<MoarefModel> _data = [];


  MoarefAccordion( this._data,this.index,this.size);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<MoarefAccordion> {
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
                    Icon(Icons.person_pin),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(child: Text( widget._data[widget.index].namepazirande == null ? "-" : widget._data[widget.index].namepazirande,
                      textAlign: TextAlign.center,style: TextStyle(
                            color: primary, fontSize: fontSize1, fontWeight: FontWeight.w500),maxLines: 2,)),
                  ],
                ),),
                Row(
                  children: [
                    Icon(Icons.drive_file_rename_outline),
                    SizedBox(width: 10,),
                    Text( widget._data[widget.index].sanadpazirande,
                        style: TextStyle(
                            color: primary, fontSize: fontSize1))
                  ],
                )
              ],
            )
        ),
        _showContent
            ? Column(children: [
          Padding(child: Divider(height: 0,color: Color(0xff000000),),padding: EdgeInsets.only(right: 20,left: 20,bottom: 4),),
          Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            width: double.infinity,
            // height: 110,
            margin: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
            padding: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Expanded(child: Column(
                      children: [
                        items(widget._data[widget.index].name, Icons.person),
                        h(),
                        items(widget._data[widget.index].mobile, Icons.phone_iphone),
                      ],
                    )),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        items(widget._data[widget.index].tell, Icons.phone),
                        h(),
                        h(),
                        h(),
                        //items(widget._data[widget.index].mobile, "assets/images/Mobile40.png"),

                      ],
                    )),
                  ],
                ),
                h(),
                items(widget._data[widget.index].address, Icons.location_on),
                h(),
                //  SizedBox(height: 6),

              ],
            )
        )
        ])
            : Container()
      ]),
    ),);
  }

  Widget h (){ double s = 12;return SizedBox( height: s); }

  Widget items (String txt , IconData ic){
    return Row(
      children: [
      Icon(ic),
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