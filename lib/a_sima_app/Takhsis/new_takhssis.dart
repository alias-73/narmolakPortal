// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:persian_date/persian_date.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
import 'package:sima_portal/a_sima_app/models/serialModel.dart';
import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsisInf1.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

import '../appbar_home.dart';
import '../models/afterTakhsisModel.dart';
import '../dashboard.dart';
import 'takhsisInf2.dart';

class new_takhsis_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  new_takhsis_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => pos_register_pageState();
}

class pos_register_pageState extends State<new_takhsis_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  List<String> _brandvalue = [];
  List<String> _modelvalue = [];
  String _pazirande_Value = "پذیرنده";
  List<String> _pazirandeValue = [];
  String _key1 = "";
  String _brand_value = "برند";
  String btnTitle = "بعدا بررسی میکنم";
  late AudioPlayer player;
  bool btnDisable = false;

  List<AfterTakhsisModel> _data7 = [];
  String _store_value = "فروشگاه";
  String _terminal_value = "ترمینال";

  List<InfoTakhsisModel2> _data6 = [];
  List<InfoTakhsisModel1> _data5 = [];
  List<PazirandeModel2> _data3 = [];
  List<BrandModel> _data2 = [];
  List<BrandModelModel> _data1 = [];
  List<SerialModel> _data4 = [];
  String _serial_value = "سریال";
  String _psp_value = "PSP";
  String _noe_value = "نوع دستگاه";
  String _hesab_value = "حساب";
  String _sheba_value = "شبا";
  String _bank_value = "بانک";
  String _ostan_value = "استان";
  String _shahr_value = "شهر";
  List<String> _serialvalue = [];
  String _key2 = "";
  bool loading = false;
  late TextEditingController _controller1 =
      TextEditingController(text: "پذیرنده");
  late TextEditingController _controller2 =
      TextEditingController(text: "سریال");

  @override
  void initState() {
    getPazirandeList();
    getBrandList();
    super.initState();
    player = AudioPlayer();
  }

  void getInfoAfterTakhsis() async {
    _store_value = "فروشگاه";
    _terminal_value = "ترمینال";
    Map response = await OnlineServices.getInfoAfterTakhsis(
        {"sanad": _pazirande_Value.split("-")[0]});

    if (response["data"] == "wait") {
      Future.delayed(const Duration(seconds: 30), () {
        getInfoAfterTakhsis();
      });
    } else {
      await player.setAsset('assets/ding1.mp3');
      player.play();
      _data7.clear();
      _data7.addAll(response['data']);
      _store_value = _data7[0].store;
      _terminal_value = _data7[0].terminal;
      btnTitle = "بستن";
      setState(() {});
      Navigator.pop(context);
      _afterDialog1(context, 1);
    }
  }

  void getPazirandeList() async {
    Map response = await OnlineServices.getPazirandeList3({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode
    });
    _data3.clear();
    _serialvalue.clear();
    _data3.addAll(response['data']);
    for (int i = 0; i < _data3.length; i++) {
      // print(_data3[i].pazirande.split("-").last);
      _pazirandeValue.add(_data3[i].pazirande);
    }

    setState(() {});
  }

  void getBrandList() async {
    Map response = await OnlineServices.getBrandList();
    _data2.clear();
    _modelvalue.clear();
    _data2.addAll(response['data']);

    for (int i = 0; i < _data2.length; i++) {
      _brandvalue.add(_data2[i].brandName);
    }
    setState(() {});
  }

  void getModelList() async {
    // print("*" + _brand_value + "*");
    Map response =
        await OnlineServices.getBrandModelList({"brand": _brand_value});
    _data1.clear();
    _modelvalue.clear();
    _data1.addAll(response['data']);

    for (int i = 0; i < _data1.length; i++) {
      _modelvalue.add(_data1[i].modelName);
    }
    setState(() {});
  }

  void getSerialList(String psp) async {
    Map response = await OnlineServices.getSerialList({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "psp": psp,
      "noe": _noe_value
    });
    _data4.clear();
    _serialvalue.clear();
    _serial_value = "سریال";

    {
      _data4.addAll(response['data']);
      for (int i = 0; i < _data4.length; i++) {
        _serialvalue.add(_data4[i].serial_no);
      }
    }
    setState(() {});
  }

  void getInfoTakhsis1(String sanad) async {
    Map response = await OnlineServices.getInfoTakhsis1({"sanad": sanad});
    _data5.clear();
    _data5.addAll(response['data']);
    _noe_value = _data5.last.noe;
    _psp_value = _data5.last.psp;
    _ostan_value = _data5.last.ostan;
    _shahr_value = _data5.last.shahr;
    //   print(_noe_value);
    setState(() {});
  }

  void getInfoTakhsis2(String sanad) async {
    Map response = await OnlineServices.getInfoTakhsis2({"sanad": sanad});
    _data6.clear();
    _data6.addAll(response['data']);
    _bank_value = _data6.last.bank;
    _sheba_value = _data6.last.sheba;
    _hesab_value = _data6.last.hesab;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    Color cl = Color(0xff000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Comp.appBarHeight),
          child: Comp.app_bar("تخصیص دستگاه", "", Icons.edit, () {})),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 0),
          height: size.height,
          // color: Colors.white,
          child: ListView(
            //  mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 12,
              ),

              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    //padding: EdgeInsets.only( right: 30,),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _controller1,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        //contentPadding: EdgeInsets.only(right: 30),
                        prefixIcon: Icon(
                          Icons.adjust_outlined,
                          color: Color(0x00000000),
                        ),
                        labelStyle:
                            TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl, width: 1.0)),
                        labelText: "پذیرنده",
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: cl, width: 1.0)),
                      ),
                    ),
                  ),
                  _noe_value == "نوع دستگاه"
                      ? Container(
                          // decoration: BoxDecoration(
                          //     color: Color(0x22000000),
                          //     borderRadius: BorderRadius.all(Radius.circular(17))),
                          alignment: Alignment.center,
                          margin:
                              EdgeInsets.only(right: 35, left: 35, bottom: 6),
                          width: size.width,
                          padding: EdgeInsets.only(right: 60, left: 20),
                          child: SearchableDropdown.single(
                            style: TextStyle(color: Color(0x00000000)),
                            items: _pazirandeValue.map((String val) {
                              return DropdownMenuItem<String>(
                                value: val,
                                child: Text(val),
                              );
                            }).toList(),
                            underline: Container(),
                            // value: ,
                            //hint: Text(),
                            searchHint: "انتخاب پذیرنده",
                            onChanged: (value) {
                              _pazirande_Value = value;
                              _key1 = value;
                              getInfoTakhsis1(_key1.split("-").first);
                              getInfoTakhsis2(_key1.split("-").first);
                              _controller2 = TextEditingController(text: "");

                              _serial_value = "سریال";
                              _controller1 =
                                  TextEditingController(text: _pazirande_Value);
                              _key2 = "";
                              Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                getSerialList(_psp_value);
                              });
                              setState(() {});
                            },
                            isExpanded: true,
                          ))
                      : Center(),
                  // _noe_value == "نوع دستگاه" ? Container(
                  //     alignment: Alignment.center,
                  //     margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                  //     width: size.width,
                  //     padding: EdgeInsets.only(right: 60,left: 20),
                  //     child: DropdownButton<String>(
                  //       enableFeedback: true,
                  //         isExpanded: true,
                  //         underline: Container(),
                  //         items:_pazirandeValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                  //         onChanged: (newVal) {
                  //           _pazirande_Value = newVal;
                  //           _key1 = newVal;
                  //           getInfoTakhsis1(_key1.split("-").first);
                  //           getInfoTakhsis2(_key1.split("-").first);
                  //           _controller2 = TextEditingController(text: "");
                  //
                  //           _serial_value = "سریال";
                  //           _controller1 = TextEditingController(text: _pazirande_Value);
                  //           _key2 = "";
                  //           Future.delayed(const Duration(milliseconds: 1000), () {
                  //             getSerialList(_psp_value);
                  //           });
                  //           setState(() {});
                  //
                  //         })) : Center(),
                ],
              ),

              _noe_value != "نوع دستگاه"
                  ? Comp.editBox10(
                      context, "نوع دستگاه", Icons.device_hub, _noe_value)
                  : Center(),
              _psp_value != "PSP"
                  ? Comp.editBox8(context, "PSP", Icons.apps, _psp_value)
                  : Center(),
              _hesab_value != "حساب"
                  ? Comp.editBox9(context, "شماره حساب",
                      Icons.drive_file_rename_outline, _hesab_value)
                  : Center(),
              _sheba_value != "شبا"
                  ? Comp.editBox9(context, "شماره شبا",
                      Icons.drive_file_rename_outline, _sheba_value)
                  : Center(),
              _bank_value != "بانک"
                  ? Comp.editBox11(context, "بانک", Icons.store, _bank_value)
                  : Center(),
              _ostan_value != "استان"
                  ? Comp.editBox9(
                      context, "استان", Icons.location_city, _ostan_value)
                  : Center(),
              _shahr_value != "شهر"
                  ? Comp.editBox9(
                      context, "شهر", Icons.location_on, _shahr_value)
                  : Center(),

              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    //padding: EdgeInsets.only( right: 30,),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _controller2,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        //contentPadding: EdgeInsets.only(right: 30),
                        prefixIcon: Icon(
                          Icons.adjust_outlined,
                          color: Color(0x00000000),
                        ),
                        labelStyle:
                            TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl, width: 1.0)),
                        labelText: "سریال",
                        disabledBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: cl, width: 1.0)),
                      ),
                    ),
                  ),
                  Container(
                      // decoration: BoxDecoration(
                      //     color: Color(0x22000000),
                      //     borderRadius: BorderRadius.all(Radius.circular(17))),
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                      width: size.width,
                      padding: EdgeInsets.only(right: 60, left: 20),
                      child: SearchableDropdown.single(
                        style: TextStyle(color: Color(0x00000000)),
                        items: _serialvalue.map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        underline: Container(),
                        // value: ,
                        //hint: Text(),
                        searchHint: "انتخاب سریال",
                        onChanged: (value) {
                          _serial_value = value;
                          _key2 = value;
                          _controller2 =
                              TextEditingController(text: _serial_value);

                          setState(() {});
                        },
                        isExpanded: true,
                      )),
                  Padding(
                    padding: EdgeInsets.only(right: 39, bottom: 4),
                    child: FloatingActionButton(
                      child: Icon(Icons.refresh),
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        //   print(_psp_value);
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          getSerialList(_psp_value);
                        });
                        setState(() {});
                      },
                      mini: true,
                    ),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Stack(children: [
                    Comp.miniBtn1(
                        context, size, "ثبت اطلاعات", Colors.teal, fun, 1),
                    Visibility(
                        visible: btnDisable,
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          width: size.width * 0.4,
                          height: size.height * .06,
                          color: Color(0x80ffffff),
                        ))
                  ]),
                  Comp.miniBtn1(context, size, "انصراف", Colors.teal, () {}, 2),
                ],
              ),
              SizedBox(
                height: 15,
              )
              //    SizedBox(height: 40,)
            ],
          ),
        ),
        loading == true ? Comp.showLoading(size.height, size.width) : Center()
      ]),
    );
  }

  void _afterDialog1(BuildContext context, int i) async {
    var size = MediaQuery.of(context).size;
    double s = 12;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              contentPadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              title: Column(
                children: [
                  Text(
                    i == 1 ? "تخصیص با موفقیت انجام شد" : " . . . ",
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text("نام:"),
                                SizedBox(
                                  height: s,
                                ),
                                Text("سریال:"),
                                SizedBox(
                                  height: s,
                                ),
                                Text("سوئیچ:"),
                                SizedBox(
                                  height: s,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  _pazirande_Value.split("-")[1],
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: s,
                                ),
                                Text(
                                  _serial_value,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(
                                      decoration: TextDecoration.underline),
                                ),
                                SizedBox(
                                  height: s,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      _psp_value,
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                          decoration: TextDecoration.underline),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    _psp_value=="پرداخت نوین" ? Image.asset("assets/images/novin.png", width: 40, height: 40):
                                    _psp_value=="سداد" ? Image.asset("assets/images/sadad.png", width: 40, height: 40)
                                        : _psp_value=="به پرداخت"
                                            ? Image.asset(
                                                "assets/images/behpardakht.png",
                                                width: 40,
                                                height: 40,
                                              )
                                            : _psp_value.contains("سپهر")
                                                ? Image.asset(
                                                    "assets/images/sepehr.png",
                                                    width: 40,
                                                    height: 40,
                                                  )
                                                : _psp_value.contains("ایران")
                                                    ? Image.asset(
                                                        "assets/images/irankish.png",
                                                        width: 40,
                                                        height: 40)
                                                    : _psp_value.contains(
                                                            "پاسارگاد")
                                                        ? Image.asset(
                                                            "assets/images/pasargad.png",
                                                            width: 40,
                                                            height: 40)
                                                        : Center()
                                  ],
                                ),
                                SizedBox(
                                  height: s,
                                ),
                              ],
                            ),
                          ],
                        )),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: _terminal_value == "ترمینال"
                            ? Comp.editBox9(context, "ترمینال", Icons.terminal,
                                "در انتظار ...")
                            : Comp.editBox9(context, "ترمینال", Icons.terminal,
                                _terminal_value)

                        // _terminal_value!= "ترمینال" ? Comp.editBox9(context, "ترمینال", Icons.terminal, _terminal_value) : Container(height: size.height * .5, color: Color(0x7effffff), width: size.width, child:
                        // Column(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Center(child: SpinKitFadingFour(color: Color(0xffffa625)),),
                        //     Text("سیستم درحال تنظیم اطلاعات ترمینال و فروشگاه میباشد ...",textAlign: TextAlign.center,
                        //         style: TextStyle(color: Colors.black, fontSize: 17,fontWeight: FontWeight.w500))
                        //
                        //   ],
                        // ),),

                        ),
                    SizedBox(height: 10),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: _store_value == "فروشگاه"
                          ? Comp.editBox9(
                              context, "فروشگاه", Icons.store, "در انتظار ...")
                          : Comp.editBox9(
                              context, "فروشگاه", Icons.store, _store_value),
                    ),
                    _terminal_value == "ترمینال"
                        ? Container(
                            height: size.height * .5,
                            color: Color(0x7effffff),
                            width: size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: SpinKitFadingFour(
                                    color: Color(0xffffa625),
                                  ),
                                ),
                                Text(
                                    "سیستم درحال تنظیم اطلاعات ترمینال و فروشگاه میباشد ...",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          )
                        : Center(),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      // loading = false;
                      //  setState(() {});
                      Navigator.pop(context);
                      Navigator.pop(context);
                      // print(_key6.currentState?.value.toString());
                    },
                    child: Text(
                      btnTitle,
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

  Future<String> sendDataForTakhsis() async {
    PersianDate persianDate = PersianDate();
    String today = persianDate.getDate
        .toString()
        .substring(0, persianDate.getDate.toString().length - 13)
        .replaceAll("-", "/");
    String h = DateTime.now().hour.toString();
    if (h.length == 1) h = "0" + h;
    String m = DateTime.now().minute.toString();
    if (m.length == 1) m = "0" + m;
    String datetime = h + ":" + m;

    String response;
    response = await (OnlineServices()).sendDataForTakhsis({
      "tarikh": today,
      "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "sanad": _key1.split("-").first,
      "serial":
          _key2.substring(0, _key2.length - (_key2.split("-").last.length + 1)),
      "brand": "",
      "model": "",
      "usercode": widget._Agentdata.last.userCode
    });
    //  print(response);
    if (response == "ok") {
      await (OnlineServices())
          .sendDataForTakhsis2({"sanad": _key1.split("-").first});
      await (OnlineServices()).sendDataForTakhsis3({
        "sanad": _key2.substring(
            0, _key2.length - (_key2.split("-").last.length + 1))
      });
      // getPazirandeList();
      //   _pazirande_Value = "پذیرنده";
      loading = false;
      setState(() {});
      _afterDialog1(context, 0);
      getInfoAfterTakhsis();

      Future.delayed(const Duration(seconds: 180), () {
        // getInfoAfterTakhsis();
        print("waitttttt_________________${_terminal_value}________");
        if (_terminal_value == "ترمینال") {
          Navigator.pop(context);
          _showDialog(context,
              "مشکل در فراخوانی اطلاعات\nاطلاعات ترمینال و فروشگاه را از فهرست تخصیص بررسی نمایید.");
        }
      });

      // loading = false;
      // Navigator.pop(context);
      // _showDialog(context);
    } else {
      // print("errrror");
    }
    return "";
  }

  void fun() {
    // sendDataForTakhsis();

    if (_key1.length > 0 && _key2.length > 0) {
      sendDataForTakhsis();
      btnDisable = true;

      setState(() {});
    } else
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
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
                    Navigator.pop(context);
                    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));
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
}
