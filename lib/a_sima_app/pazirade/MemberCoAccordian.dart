import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/Pazirade/memberCo_upload.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/memberCo-model.dart';

class MemberCoAccordian extends StatefulWidget {
  int index;
  var size;
  String sanad;
  List<MemberCoModel> _data = [];
  List<AgentModel> _Agentdata = [];
  MemberCoAccordian(this._data,this.index,this.size, this._Agentdata,this.sanad);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<MemberCoAccordian> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
   double fontSize1 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
 // var size = MediaQuery.of(widget.context).size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap:(){
      setState(() {
      _showContent = !_showContent;
    });},child:

    Card(
      margin: EdgeInsets.only(bottom: 5,top: 10, right: 10, left: 10),
      child:
        Stack(alignment: Alignment.bottomLeft,children: [
          Column(children: [
            ListTile(
                title:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(width: (widget.size.width-10) * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person_pin,),
                          SizedBox(
                            width: 7,
                          ),
                          Flexible(flex: 1,child: Text( widget._data[widget.index].name == null ? "-" : widget._data[widget.index].name ,
                            textAlign: TextAlign.center,style: TextStyle(
                                color: primary, fontSize: fontSize1, fontWeight: FontWeight.w500),maxLines: 4,)),
                        ],
                      ),),
                    Row(
                      children: [
                        Icon(widget._data[widget.index].status.toString().contains("نشده") ? Icons.warning_amber_rounded : Icons.adjust, color: widget._data[widget.index].status.toString().contains("نشده") ? Colors.red : Colors.green ),
                        SizedBox(width: 6),
                        Text("مدارک\n"+ widget._data[widget.index].status,textAlign: TextAlign.center,
                            style: TextStyle(
                                color: widget._data[widget.index].status.toString().contains("نشده") ? Colors.red : Colors.green, fontSize: fontSize1)),
                      ],

                    ),
                    IconButton(onPressed: (){
                      widget._data[widget.index].status.toString().contains("نشده") ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: memberCoupload(widget._Agentdata,widget.sanad,widget._data[widget.index].id,widget._data[widget.index].name,widget._data[widget.index].status)))) : null ;
                    }, icon: Icon(Icons.upload_file,color: !widget._data[widget.index].status.toString().contains("نشده") ? Color(0x00000000) : Colors.black,))

                  ],
                )),
            _showContent
                ?Column(children: [
                    Padding(child: Divider(height: 0,color: Color(0xff000000),),padding: EdgeInsets.only(right: 20,left: 20,bottom: 4),),
                    Container(
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.white,
                        ),
                        width: double.infinity,
                        // height: 110,
                        margin: EdgeInsets.only(bottom: 0,top: 3, right: 10, left: 10),
                        padding: EdgeInsets.only(bottom: 0,top: 0, right: 10, left: 10),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              //crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[

                                Expanded(child: Column(
                                  children: [
                                    items(widget._data[widget.index].meli, Icons.credit_card),
                                    h(),
                                    items(widget._data[widget.index].mobilepish + widget._data[widget.index].mobile, Icons.phone_iphone),
                                  ],

                                )),
                                Expanded(child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    items(widget._data[widget.index].tavalod , Icons.date_range_sharp),
                                    h(),
                                    items((widget._data[widget.index].telpish.toString() + "-" + widget._data[widget.index].tel.toString()), Icons.phone),
                                  ],

                                )),



                              ],
                            ),
                            h(),
                          ],
                        )
                    )
            ],)

                : Container()
          ]),

        ],)

    ),);
  }

  Widget txt (String txt)
  {
    Color c = Colors.white;
    double s = 15;
    return Align(child: Column(children: [
      Text(txt, style: TextStyle(fontSize: s, color: c)),
      Divider(color: Colors.white,height: 2,)
    ],),alignment: Alignment.centerRight,);
  }


  void _showDialog(BuildContext context , String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(18)) ),

          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(textDirection: TextDirection.rtl,
                      child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){ Navigator.pop(context);
                // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
              },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4,bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(width: 1,color: Color(0xff000000),),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text("تایید",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13),)
                  ))
            ],
          ),
        );
      },
    );
  }


  Widget h (){ double s = 12;return SizedBox( height: s); }

  Widget items (String txt , IconData ic){
     double fontSize2 = 14;

    return Row(
      children: [
      Icon(ic) ,
        SizedBox(
          width: 5,
        ),
        Flexible(child: Text( txt == null ? "-" :  txt,
            style: TextStyle(
                color: primary, fontSize: fontSize2))),

      ],
    );
  }

}