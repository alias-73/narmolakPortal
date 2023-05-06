import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:persian_date/persian_date.dart';

import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../models/PazirandeHistoryModel.dart';
import '../models/ehrazModel.dart';
import 'edit_Pazirande.dart';
import 'edit_PazirandeH.dart';
import 'list_memberCo.dart';
import 'list_pazirande.dart';

class PazirandeAccordion extends StatefulWidget {
  int index;
  var size;
  List<PazirandeModel> _data = [];
  List<AgentModel> _Agentdata = [];

  PazirandeAccordion(this._data, this.index, this.size, this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<PazirandeAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
  double fontSize1 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
  final _key1 = GlobalKey<FormFieldState>();
  String _key2 = " ";
  Color cl = Color(0xff000000);
  late String today = "";
  late String datetime = "";

  final List<String> _genderValue = [
    'انصراف مشتری',
    'انصراف بانک',
    'عدم همکاری مشتری',
    'عدم حضور یا پاسخگویی پذیرنده',
    'نصب شده توسط سایر pspها',
    'نقص مدارک پذیرنده',
    'نداشتن آدرس ثابت جهت پشتیبانی',
    'ناکارآمد بودن پایانه',
    'آماده نبودن بستر اطلاعاتی',
    'تغییر شماره حساب متصل به pos',
    'به صلاحدید شرکت',
    'سایر موارد'
  ];
  String _gender_Value = "انتخاب کنید";
  late TextEditingController _controller2 = TextEditingController(text: "");
  List<EhrazModel> _data = [];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
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
                          Icon(!widget._data[widget.index].noe
                                  .toString()
                                  .contains("حقوقی")
                              ? Icons.person_pin
                              : Icons.person_pin_rounded),
                          SizedBox(
                            width: 5,
                          ),
                          Flexible(
                              flex: 1,
                              child: Text(
                                widget._data[widget.index].name == null
                                    ? "-"
                                    : widget._data[widget.index].name,
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
                        widget._data[widget.index].soeich == "پرداخت نوین" ? Image.asset(height: 25,"assets/images/novin.png") :
                        widget._data[widget.index].soeich == "ایران کیش" ? Image.asset(height: 25,"assets/images/irankish.png") :
                        widget._data[widget.index].soeich == "سداد" ?      Image.asset(height: 25,"assets/images/sadad.png") :
                        widget._data[widget.index].soeich == "پاسارگاد" ?  Image.asset(height: 25,"assets/images/pasargad.png") :
                        widget._data[widget.index].soeich == "سپهر" ?      Image.asset(height: 25,"assets/images/sepehr.png") :
                        widget._data[widget.index].soeich == "به پرداخت" ? Image.asset(height: 25,"assets/images/behpardakht.png") :
                        Center()
                        ,SizedBox(
                          width: 10,
                        ),
                        Text(widget._data[widget.index].status,
                            style: TextStyle(
                                color: widget._data[widget.index].status
                                        .toString()
                                        .contains("اصلاح")
                                    ? Colors.red
                                    : widget._data[widget.index].status
                                            .toString()
                                            .contains("تایید")
                                        ? Colors.blue
                                        : widget._data[widget.index].status
                                                .toString()
                                                .contains("فعال")
                                            ? Colors.green
                                            : primary,
                                fontSize: fontSize1))
                      ],
                    )
                  ],
                )),
                _showContent
                    ? Stack(alignment: Alignment.centerLeft, children: [
                        Column(
                          children: [
                            Padding(
                              child: Divider(
                                height: 0,
                                color: Color(0xff000000),
                              ),
                              padding: EdgeInsets.only(
                                  right: 20, left: 20, bottom: 4),
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
                                          MainAxisAlignment.spaceAround,
                                      //crossAxisAlignment: CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Expanded(
                                            child: Column(
                                          children: [
                                            items(
                                                widget
                                                    ._data[widget.index].name2,
                                                Icons.store),
                                            h(),
                                            items(
                                                widget
                                                    ._data[widget.index].mobile,
                                                Icons.phone_iphone),
                                            h(),
                                            items(
                                                widget._data[widget.index].noe2,
                                                widget._data[widget.index]
                                                            .noe2 ==
                                                        "GPRS"
                                                    ? Icons.wifi
                                                    : widget._data[widget.index]
                                                                .noe2 ==
                                                            "Typical"
                                                        ? Icons.phone
                                                        : Icons.cable),
                                            widget._Agentdata.last.userCode ==
                                                    "0"
                                                ? h()
                                                : Center(),
                                            widget._Agentdata.last.userCode ==
                                                    "0"
                                                ? items(
                                                    widget._data[widget.index]
                                                        .usercode,
                                                    Icons.person_outline)
                                                : Center(),
                                          ],
                                        )),
                                        Expanded(
                                            child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            items(
                                                widget._data[widget.index].tarikh.isEmpty ? "--/--/----" : widget._data[widget.index].tarikh,
                                                Icons
                                                    .date_range),
                                            h(),
                                            items(
                                                widget
                                                    ._data[widget.index].sanad+"_" + widget._data[widget.index].soeich,
                                                Icons
                                                    .drive_file_rename_outline),
                                            h(),
                                            items(
                                                widget
                                                    ._data[widget.index].soeich,
                                                Icons.apps),
                                            h(),
                                            items(
                                                widget._data[widget.index].noe,
                                                !widget._data[widget.index].noe
                                                        .toString()
                                                        .contains("حقوقی")
                                                    ? Icons.person_pin
                                                    : Icons.person_pin_rounded),
                                          ],
                                        )),
                                      ],
                                    ),
                                    SizedBox(height: 9),
                                    items(widget._data[widget.index].senf,
                                        Icons.storefront_rounded),
                                    SizedBox(height: 8),
                                  ],
                                ))
                          ],
                        ),

                      ])
                    : Container()
              ]),
              PopupMenuButton(
                itemBuilder: (context) {
                  var list = <PopupMenuEntry<Object>>[];
                  widget._data[widget.index].noe.toString().contains("حقوقی")
                      ? list.add(PopupMenuItem(
                          child: txt("اعضای شرکت"),
                          value: 5,
                        ))
                      : Container();
                  list.add(PopupMenuItem(
                    child: txt("حساب  "),
                    value: 1,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("ترمینال"),
                    value: 2,
                  ));
                  widget._data[widget.index].status.toString().contains("اصلاح")
                      ? list.add(PopupMenuItem(
                          child: txt("نمایش خطا"),
                          value: 3,
                        ))
                      : widget._data[widget.index].status
                              .toString()
                              .contains("بررسی")
                          ? list.add(PopupMenuItem(
                              child: txt("نمایش خطا"),
                              value: 3,
                            ))
                          : widget._data[widget.index].status
                                  .toString()
                                  .contains("رد پرونده")
                              ? list.add(PopupMenuItem(
                                  child: txt("نمایش خطا"),
                                  value: 3,
                                ))
                              : Container();
                  widget._data[widget.index].status.toString().contains("اصلاح")
                      ? list.add(PopupMenuItem(
                          child: txt("ویرایش   "),
                          value: 4,
                        ))
                      : widget._data[widget.index].status
                              .toString()
                              .contains("کارتابل")
                          ? list.add(PopupMenuItem(
                              child: txt("ویرایش   "),
                              value: 4,
                            ))
                          : widget._data[widget.index].status
                                  .toString()
                                  .contains("بررسی")
                              ? list.add(PopupMenuItem(
                                  child: txt("ویرایش   "),
                                  value: 4,
                                ))
                              : Container();
                  widget._data[widget.index].status
                          .toString()=="فعال"
                      ? list.add(PopupMenuItem(
                          child: txt("درخواست ابطال"),
                          value: 6,
                        ))
                      : Container();
                  widget._data[widget.index].status.toString().contains("فعال")
                      ? list.add(PopupMenuItem(
                          child: txt("فعالسازی سیما پِی"),
                          value: 7,
                        ))
                      : Container();
                  list.add(PopupMenuItem(
                    child: txt("تاریخچه  "),
                    value: 8,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("مشخصات کامل  "),
                    value: 9,
                  ));
                  list.add(PopupMenuItem(
                    child: txt("اطلاعات احراز   "),
                    value: 10,
                  ));

                  return list;
                },
                onSelected: (value) {
                  doo(value as int, widget._data[widget.index].noe);
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

  void _ebalDialog(BuildContext context) async {
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
                  Divider(
                    thickness: 2,
                    color: Colors.black87,
                  )
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
                                //initialValue: _gender_Value,
                                controller: _controller2,
                                enabled: false,
                                cursorColor: Colors.black,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800),
                                decoration: InputDecoration(
                                  // contentPadding: EdgeInsets.zero,
                                  prefixIcon: Icon(
                                    Icons.info_outline,
                                    color: Colors.black,
                                  ),
                                  labelStyle: TextStyle(
                                      color: cl, fontWeight: FontWeight.w800),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: cl, width: 1.0)),
                                  labelText: "علت انصراف",
                                  disabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: cl, width: 1.0)),
                                ),
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                //  margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                                width: size.width,
                                padding: EdgeInsets.only(right: 30, left: 10),
                                child: DropdownButton<String>(
                                    isExpanded: true,
                                    underline: Container(),
                                    items: _genderValue.map((String val) {
                                      return DropdownMenuItem<String>(
                                        value: val,
                                        child: Text(val),
                                      );
                                    }).toList(),
                                    onChanged: (newVal) {
                                      _gender_Value = newVal!;
                                      _key2 = newVal;
                                      _controller2 = TextEditingController(
                                          text: _gender_Value);
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
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Text(
                      "     لغو     ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_key1.currentState!.value.toString().isNotEmpty &&
                          _key2.toString().length > 1) {
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

  void ebtalReq(String sanad) async {

    PersianDate persianDate = PersianDate();String today = persianDate.getDate.toString().substring(0, persianDate.getDate.toString().length - 13).replaceAll("-", "/");String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;


    String response = await OnlineServices.ebtalRequest({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "tarikh": today,
      "saat": datetime,
      "sanad": sanad,
      "sharh": _key1.currentState!.value.toString(),
      "dalil": _key2.toString(),
    });
    if (response.contains("ok")) {
      _showDialogEbtal(context, "درخواست با موفقیت اسال شد");
      // print("______________________");
    } else {
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
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child: poses_list_page(widget._Agentdata))));
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

  Future getPazirandeHistory(String sanad) async {
    String txt = "";
    List<PazirandeHistoryModel> _data = [];
    late Map response;
    response = await OnlineServices.getPazirandeHistory({"sanad": sanad});
    if (response != null) {
      _data.clear();
      _data.addAll(response['data']);
      for (int i = 0; i < _data.length; i++) {
        txt += _data[i].name + "\n";
        txt += _data[i].time + "     ";
        txt += _data[i].date + "\n";
        txt += _data[i].disc + "\n";
        txt += "- - - - - - - - -";
        txt += "\n";
      }
      //  print(txt);
      _showDialog(txt);
    }
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

  Future terminal(String sanad) async {
    String response = await (OnlineServices()).terminal({"sanad": sanad});
    String ter;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 5)
      ter = "ترمینالی پیدا نشد";
    else
      ter = "سریال: " +
          response.split(",")[0] +
          "\n" +
          "برند: " +
          response.split(",")[1] +
          "\n"
              "مدل: " +
          response.split(",")[2] +
          "\n" +
          "ترمینال: " +
          response.split(",")[3] +
          "\n"
              "فروشگاه: " +
          response.split(",")[4];
    _showDialog(ter);
  }

  Future hesab(String sanad) async {
    String response = await (OnlineServices()).hesab({"sanad": sanad});
    String hes;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 4)
      hes = "حساب پیدا نشد";
    else
      hes = "بانک: " +
          response.split(",")[0] +
          "\n"
              "     شعبه: " +
          response.split(",")[1] +
          "\n"
              "حساب: " +
          response.split(",")[2] +
          "\n"
              "\n"
              "شبا: " +
          response.split(",")[3];
    _showDialog(hes);
  }

  void _showDialog(String txt) {
    var size = MediaQuery
        .of(context)
        .size;
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


  Future khata(String sanad) async {
    String response = await (OnlineServices()).khata({"sanad": sanad});

    Comp.show_short_info(response
        .replaceAll("\n", "")
        .replaceAll("\r", "")
        .replaceAll("\t", "")
        .toString());
    //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}
  }

  void _showDialog3(
      String txt1, String txt2, String txt3, String txt4, String txt5) {
    var size = MediaQuery.of(context).size;

    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Color(0x69bcdeff),
              body: Center(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Color(0xFFEAEAEA)),
                  width: size.width * .85,
                  height: size.height * .8,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Text(
                        "مشخصات پذیرنده",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                      txtBox(txt1),
                      Divider(color: Colors.black, thickness: .7),
                      txtBox(txt2),
                      Divider(color: Colors.black, thickness: .7),
                      txtBox(txt3),
                      Divider(color: Colors.black, thickness: .7),
                      txtBox(txt4),
                      Divider(color: Colors.black, thickness: .7),
                      txtBox(txt5),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
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
                ),
              ));
        });
  }

  Widget txtBox(String txt) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      padding: EdgeInsets.all(6),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            txt,
            style: TextStyle(fontSize: 16),
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(0xFFEAEAEA)),
    );
  }

  void simaPayReq() async {
    
    String response0 = await OnlineServices.simaPayAllow(
        {"sanad": widget._data[widget.index].sanad});

    if (response0.contains("no")) {
      String response = await OnlineServices.simaPayRequest({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": widget._Agentdata.last.userCode,
        "tarikh": today,
        "saat": datetime,
        "sanad": widget._data[widget.index].sanad,
        "name": widget._data[widget.index].name,
      });
      if (response.contains("ok"))
        Comp.show_short_info(
            "درخواست با موفقیت اسال شد\nنتیجه درخواست فعالسازی توسط پیامک اطلاع رسانی خواهد شد");
    } else {
      Comp.show_short_info("برای این پذیرنده قبلا درخواست سیماپی ثبت شده است");
    }
  }

  void doo(int value, String noe) {
    if (value == 1) {
      hesab(widget._data[widget.index].sanad);
    } else if (value == 2) {
      terminal(widget._data[widget.index].sanad);
    } else if (value == 3) {
      khata(widget._data[widget.index].sanad);
    }
    else if (value == 4) {
      noe == "حقیقی"
          ? Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: edit_registerPos(
                          widget._data[widget.index].sanad.toString(),
                          widget._Agentdata))))
          : Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: edit_registerPosH(
                          widget._data[widget.index].sanad.toString(),
                          widget._Agentdata))));
    } else if (value == 5) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => Directionality(
                  textDirection: TextDirection.rtl,
                  child: memberCo_page(
                      widget._Agentdata,
                      widget._data[widget.index].sanad.toString(),
                      widget._data[widget.index].emza.toString()))));
    } else if (value == 6) {
      _ebalDialog(context);
    } else if (value == 7) {
      simaPayReq();
    } else if (value == 8) {
      getPazirandeHistory(widget._data[widget.index].sanad);
    } else if (value == 9) {
      showInfo(widget._data[widget.index].sanad);
    } else if (value == 10) {
      ehrazInfo(widget._data[widget.index].sanad);
    }
  }

  void ehrazInfo(String sanad) async {
    _data.clear();
    Map response = await OnlineServices.get_ehrazInfo({"sanad": sanad});
    _data.addAll(response['data']);


    showDialog2(context);
  }

   showDialog2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // int c = res.split(",").length~/2;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          height: size.height * .8,width: size.width * .7,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: SizedBox(
                height: size.height * .8,width: size.width * .7,
                child:
              ListView.builder(itemCount: _data.length,itemBuilder: (BuildContext context, int index) {
                // print(res.split(",")[index]);

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 5),
                  padding: EdgeInsets.symmetric(vertical: 5,horizontal: 8),
                  alignment: Alignment.topRight,
                    decoration: BoxDecoration(
                      color: _data[index].a.toString().contains("yes") ?
                      Color(0xff6bff6b) : _data[index].a.toString().contains("no") ? Color(0xffffadad) : Color(0xffffffff),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      border: Border.all(width: .8,color: Color(0xff484848))
                    ),
                    // width: size.width * .8,

                    child: Text(_data[index].q,textAlign: TextAlign.end,)
                );
                index++;
              },),
            )),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                  },
                  child: Text(
                    "بستن",
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


  Future showInfo(String sanad) async {
    String response = await OnlineServices.get_editPazirande({"sanad": sanad});
    String res =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    //res = res.replaceAll(",", "\n");
    String nameFa =
        "نام فارسی" + ": " + res.split(",")[0] + " " + res.split(",")[1];
    String nameEn = "\n" +
        "نام انگلیسی" +
        ": " +
        res.split(",")[2] +
        " " +
        res.split(",")[3];
    String nameP = "\n" + "نام پدر" + ": " + res.split(",")[4];
    String nameFoFa = "نام فروشگاه" + ": " + res.split(",")[5];
    String nameFoEn = "\n" + "" + res.split(",")[6];
    String meli = "کدملی" + ": " + res.split(",")[7];
    String tel = "تلفن" + ": " + res.split(",")[8] + res.split(",")[9];
    String mobile =
        "\n" + "موبایل" + ": " + res.split(",")[10] + res.split(",")[11];
    String maliyat = "کدمالیاتی" + ": " + res.split(",")[12];
    String codeposti = "\n" + "کدپستی" + ": " + res.split(",")[13];

    _showDialog3(nameFa + nameEn + nameP, nameFoFa + nameFoEn, meli,
        tel + mobile, maliyat + codeposti);
    //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}
  }

  Widget h() {
    double s = 12;
    return SizedBox(height: s);
  }

  Widget items(String txt, IconData ic) {
    double fontSize2 = 14;
    return Row(
      children: [
        Icon(ic),
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
