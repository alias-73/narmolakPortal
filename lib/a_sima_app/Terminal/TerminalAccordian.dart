import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/Terminal/list_terminal.dart';
import 'package:sima_portal/a_sima_app/models/terminalModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import '../components/Styles.dart';
import '../models/agentModel.dart';
import 'list_enable_request.dart';

class TerminalAccordion extends StatefulWidget {
  int index;
  var size;
  List<AgentModel> _Agentdata = [];

  List<TerminalModel> _data = [];

  TerminalAccordion(this._data, this.index, this.size , this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<TerminalAccordion> {
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
                          Icon(Icons.person_pin),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              child: Text(
                            widget._data[widget.index].name == null ? "" : widget._data[widget.index].name,
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
                        Icon(Icons.drive_file_rename_outline),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget._data[widget.index].sanad,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  //crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                        child: Column(
                                      children: [
                                        items(
                                            widget._data[widget.index].brand +
                                                "-" +
                                                widget
                                                    ._data[widget.index].model,
                                            Icons.south_east_outlined),
                                        h(),
                                        items(widget._data[widget.index].terminal,
                                            Icons.adjust_outlined),
                                      ],
                                    )),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        items(
                                            widget._data[widget.index].serial,
                                            Icons.settings_cell_rounded),
                                        h(),
                                        items(widget._data[widget.index].foroshgah,
                                            Icons.storefront),

                                      ],
                                    )),
                                  ],
                                ),
                                h(),
                                // items(widget._data[widget.index].name, Icons.location_on),
                                //  h(),
                                //  SizedBox(height: 6),
                              ],
                            ))
                      ])
                    : Container()
              ]),
              PopupMenuButton(
                itemBuilder: (context) {
                  var list = <PopupMenuEntry<Object>>[];
                  list.add(PopupMenuItem(
                    child: txt("درخواست ابطال"),
                    value: 1,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("فعالسازی ترمینال"),
                    value: 2,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("پایش نصب"),
                    value: 3,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("لیست درخواست فعالسازی"),
                    value: 4,
                  ));

                  return list;
                },
                onSelected: (value) {
                  doo(value as int);
                },
                child: Column(
                  children: [Text("عملیات"), Icon(Icons.keyboard_arrow_down)],
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Colors.blueGrey,
              ),
            ],
          )),
    );
  }


  void _ebalDialog() async {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Text(
                    "درخواست ابطال",
                    textAlign: TextAlign.center,
                  ),
                  Divider(thickness: 2,color: Colors.black87,)
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              //  margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                              //  initialValue: _gender_Value,
                                controller: _controller2,
                                enabled: false,
                                cursorColor: Colors.black,
                                style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(
                                    Icons.info_outline,
                                    color: Colors.black,
                                  ),
                                  labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: cl,width: 1.0)),
                                  labelText: "علت انصراف",
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                      borderSide: BorderSide(color: cl,width: 1.0)),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                //  margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                                width: size.width,
                                padding: EdgeInsets.only(right: 30,left: 10),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Container(),
                                    items:_genderValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                                    onChanged: (newVal) {
                                      _gender_Value = newVal!;
                                      _key2 = newVal;
                                      _controller2 = TextEditingController(text: _gender_Value);
                                      setState(() {});
                                    }))
                          ],
                        )),
                    SizedBox(height: 20),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 2,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "توضیحات"),
                          key: _key1,
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Text(
                      "     لغو     ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_key1.currentState!.value.toString().isNotEmpty && _key2.toString().length > 1) {
                        Navigator.pop(context);
                        ebtalReq(widget._data[widget.index].sanad);
                      } else
                        Comp.showSnackError(context);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    child: Text(
                      "   تایید   ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
              ],
            );
          },
        );
      },
    );
  }

  void  ebtalReq(String sanad) async {
    
    
    
    String m = DateTime.now().minute.toString(); if (m.length == 1)
      m = "0" + m;
    String datetime ="";
    String response = await OnlineServices.ebtalRequest(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode,
          "tarikh": today,
          "saat": datetime,
          "sanad": sanad,
          "sharh": _key1.currentState!.value.toString(),
          "dalil": _key2.toString(),
        });
    if(response.contains("ok"))
    {
      _showDialogEbtal(context,"درخواست با موفقیت اسال شد");
      // print("______________________");
    }
    else
    {
      // print("__________asdasd____________");
    }

  }

  void _showDialogEbtal(BuildContext context, String txt) {
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
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: ter(widget._Agentdata))));
                  },
                  child: Text(
                    "           تایید           ",
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

  void doo(int value) {
    if (value == 1) {_ebalDialog();}
    else if (value == 2) {enableTerminal(widget._data[widget.index].sanad ,widget._data[widget.index].terminal , );}
    else if (value == 3) {payesh(widget._data[widget.index].terminal );}
    else if (value == 4) { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: list_enable_request(widget._data[widget.index].terminal))));}
  }

  Future payesh(String terminal) async {
    String response = await (OnlineServices()).getPayesh({"terminal": terminal});
    String ter;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 5)
      ter = "خالی";
    else
      ter = "ثبت: " +
          response.split(",")[0] +
          "\n"+
          "تایید شاپرک: " +
          response.split(",")[1] +
          "\n"
              "تخصیص: " +
          response.split(",")[2] +
          "\n"+
          "نصب: " +
          response.split(",")[3] +
          "\n"
              "شماره نسخه: " +
          response.split(",")[4] +
         "\n"
        "نام فروشگاه: " +
        response.split(",")[5];
    _showDialog( ter);
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
