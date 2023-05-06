import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/changeModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'edit_Pazirande.dart';
import 'edit_PazirandeH.dart';

class EditedStoreAccordion extends StatefulWidget {
  int index;
  var size;
  List<ChangeModel> _data = [];
  List<AgentModel> _Agentdata = [];

  EditedStoreAccordion(this._data, this.index, this.size, this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<EditedStoreAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
   double fontSize1 = 15;
  var iconSize1 = 28;
   double fontSize2 = 13;

  var iconSize2 = 20;

  // var size = MediaQuery.of(widget.context).size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Card(
          margin: EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(children: [
                ListTile(
                    title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: (widget.size.width - 10) * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              flex: 1,
                              child: Text(
                                widget._data[widget.index].terminal == null
                                    ? "-"
                                    : widget._data[widget.index].terminal,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: primary,
                                    fontSize: fontSize1,
                                    fontWeight: FontWeight.w500),
                                maxLines: 4,
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.info_outline,
                            color: widget._data[widget.index].status
                                    .toString()
                                    .contains("حال")
                                ? Colors.deepOrange
                                : widget._data[widget.index].status
                                        .toString()
                                        .contains("رد")
                                    ? Colors.red
                                    : widget._data[widget.index].status
                                            .toString()
                                            .contains("تایید")
                                        ? Colors.green
                                        : primary),
                        SizedBox(
                          width: 6,
                        ),
                        Text(widget._data[widget.index].status,
                            style: TextStyle(
                                color: widget._data[widget.index].status
                                        .toString()
                                        .contains("حال")
                                    ? Colors.deepOrange
                                    : widget._data[widget.index].status
                                            .toString()
                                            .contains("رد")
                                        ? Colors.red
                                        : widget._data[widget.index].status
                                                .toString()
                                                .contains("تایید")
                                            ? Colors.green
                                            : primary,
                                fontSize: fontSize1))
                      ],
                    ),
                    Visibility(child:  ElevatedButton(onPressed: (){
                      CoolAlert.show(
                        context: context,
                        confirmBtnText: "   بستن  ",
                        type: CoolAlertType.warning,
                        title: "",
                        backgroundColor: Colors.white,
                        text: widget._data[widget.index].desc,
                      );
                    },style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                        0xffe32323))) ,child: Text("خطا",style: TextStyle(fontWeight: FontWeight.w800),)),visible: widget._data[widget.index].status == "رد شد" ? true : false
                    )
                  ],
                )),
                _showContent
                    ? Column(
                        children: [
                          Padding(
                            child: Divider(
                              height: 0,
                              color: Color(0xff000000),
                            ),
                            padding:
                                EdgeInsets.only(right: 20, left: 20, bottom: 4),
                          ),
                          Row(
                            children: [
                              Expanded(child: Padding(child: Text("اطلاعات قبلی",
                                  style: TextStyle(decoration: TextDecoration.underline,
                                      color: primary,
                                      fontSize: fontSize2)),padding: EdgeInsets.only(right: 22),),),
                              Expanded(child: Text("اطلاعات جدید",
                                  style: TextStyle(decoration: TextDecoration.underline,
                                  color: primary,
                                      fontSize: fontSize2)),),
                            ],
                          ),
                          Container(
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              // height: 110,
                              margin: EdgeInsets.only(
                                  bottom: 0, top: 3, right: 10, left: 10),
                              padding: EdgeInsets.only(
                                  bottom: 0, top: 0, right: 10, left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        child:  Column(
                                            children: [
                                              items(
                                                  widget._data[widget.index]
                                                      .foroshgahfaold,
                                                  Icons.store),
                                              h(),
                                              items2(
                                                  widget._data[widget.index]
                                                      .foroshgahenold,
                                                  Icons.store),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .mobilepishold +
                                                      widget._data[widget.index]
                                                          .mobileold,
                                                  Icons.phone_iphone),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .tellpishold +
                                                      widget._data[widget.index]
                                                          .tellold,
                                                  Icons.phone)
                                            ],
                                          )
                                       ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              items(
                                                  widget._data[widget.index]
                                                      .foroshgahfanew,
                                                  Icons.store),
                                              h(),
                                              items2(
                                                  widget._data[widget.index]
                                                      .foroshgahennew,
                                                  Icons.store),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .mobilepishnew+
                                                      widget._data[widget.index]
                                                          .mobilenew,
                                                  Icons.phone_iphone),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .tellpishnew+
                                                      widget._data[widget.index]
                                                          .tellnew,
                                                  Icons.phone),
                                            ],
                                          )
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                ],
                              ))
                        ],
                      )
                    : Container()
              ]),
            ],
          )),
    );
  }

  Widget txt(String txt) {
    Color c = Colors.white;
    double s = 15;
    return Align(
      child: Column(
        children: [
          Text(txt, style: TextStyle(fontSize: s, color: c)),
          Divider(
            color: Colors.white,
            height: 2,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    );
  }

  void _showDialog(BuildContext context, String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl, child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
                  },
                  child: Container(
                      // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      )))
            ],
          ),
        );
      },
    );
  }

  Widget h() {
    double s = 12;
    return SizedBox(height: s);
  }

  Widget items(String txt, IconData ic) {
     double fontSize2 = 14;

    return Row(
      children: [
        Icon(
          ic,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }
  Widget items2(String txt, IconData ic) {
     double fontSize2 = 14;

    return Row(
      children: [
        Icon(
          ic,
          size: 19,
        ),
        //92847716
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }
}
