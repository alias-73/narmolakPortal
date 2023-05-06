import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/Terminal/list_terminal.dart';
import 'package:sima_portal/a_sima_app/models/terminalModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import 'components/Styles.dart';

import 'models/agentModel.dart';
import 'models/imeiModel.dart';

class IMEIAccordion extends StatefulWidget {
  int index;
  var size;
  List<AgentModel> _Agentdata = [];

  List<IMEIModel> _data = [];

  IMEIAccordion(this._data, this.index, this.size , this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<IMEIAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
  double fontSize1 = 15;
  double fontSize2 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
  Color cl = Color(0xff000000);
  late String today = "";
  late String datetime = "";

  List<String> _genderValue = ['انصراف مشتری' , 'انصراف بانک', 'عدم همکاری مشتری' , 'عدم حضور یا پاسخگویی پذیرنده','نصب شده توسط سایر pspها' , 'نقص مدارک پذیرنده','نداشتن آدرس ثابت جهت پشتیبانی','ناکارآمد بودن پایانه','آماده نبودن بستر اطلاعاتی','تغییر شماره حساب متصل به pos','به صلاحدید شرکت','سایر موارد'];
  String _gender_Value = "انتخاب کنید";
  TextEditingController _controller2 = TextEditingController(text: "");
  final _key1 = GlobalKey<FormFieldState>();
  String _key2 = " ";
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: (widget.size.width - 10) * .49,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.drive_file_rename_outline),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Text(
                             widget._data[widget.index].terminal,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: primary,
                                fontSize: fontSize1,
                                fontWeight: FontWeight.w500),
                            maxLines: 2,
                          )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Icon(Icons.info_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget._data[widget.index].vaziyat,
                            style:
                                TextStyle(color: primary, fontSize: fontSize1))
                      ],
                    )
                  ],
                )),
                _showContent
                    ? Column(children: [
                        Padding(
                          child: Divider(
                            height: 0,
                            color: Color(0xff000000),
                          ),
                          padding:
                              EdgeInsets.only(right: 20, left: 20, bottom: 4),
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
                                bottom: 0, top: 5, right: 10, left: 10),
                            padding: EdgeInsets.only(
                                bottom: 0, top: 5, right: 10, left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      children: [
                                        items(
                                            widget._data[widget.index].tarikh + " - " +widget._data[widget.index].saat
                                               ,
                                            Icons.date_range_outlined),
                                        h(),
                                        items(widget._data[widget.index].mobile,
                                            Icons.phone_android),
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        items("سریال: " +
                                            widget._data[widget.index].serial,
                                            Icons.device_hub),
                                        h(),
                                        items(widget._data[widget.index].soeich,
                                            Icons.apps),

                                      ],
                                    )),
                                  ],
                                ),
                                h(),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                          children: [
                                            items("IMEI: " +
                                                widget._data[widget.index].imei,
                                                Icons.ac_unit),
                                          ],
                                        )),
                                    Expanded(
                                        child: Column(
                                          children: [
                                            items("APN: " +
                                                widget._data[widget.index].apn,
                                                Icons.account_tree_outlined),
                                          ],
                                        )),
                                  ],
                                ),
                                h(),

                              ],
                            ))
                      ])
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
          Text(txt,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: s, color: c)),
          Divider(
            color: Colors.white,
            height: 2,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    );
  }


  Future enableTerminal(String sanad , String terminal) async {
    
    
    
    String m = DateTime.now().minute.toString(); if (m.length == 1)
      m = "0" + m;
    String datetime ="";
    String response = await (OnlineServices()).enableTerminal({"saat" : datetime , "tarikh" : today  ,"sanad": sanad ,"terminal": terminal , "agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode});
    response == "ok" ? CoolAlert.show(
      context: context,
      confirmBtnText: "   بستن  ",
      type: CoolAlertType.success,
      title: "درخواست فعالسازی ترمینال با موفقیت انجام شد",
      backgroundColor: Colors.white,
    ):
    CoolAlert.show(
      context: context,
      confirmBtnText: "   بستن  ",
      type: CoolAlertType.warning,
      title: "درخواست فعالسازی باز وجود دارد",
      backgroundColor: Colors.white,
    );
    //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}
  }

  void _showDialog( String txt) {
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
                  child: Text(
                    "   تایید   ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ))
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
    return Row(
      children: [
        Icon(ic),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(
                    color: primary, fontSize: 13, letterSpacing: .3))),
      ],
    );
  }
}
