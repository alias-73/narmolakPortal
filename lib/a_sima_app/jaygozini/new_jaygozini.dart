// ignore_for_file: non_constant_identifier_names

import 'package:cool_alert/cool_alert.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_date/persian_date.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/bankModel.dart';
import 'package:sima_portal/a_sima_app/models/checkSerialModel.dart';
import 'package:sima_portal/a_sima_app/models/serialModel.dart';
import 'package:sima_portal/a_sima_app/models/shobeModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Hesab/list_hesab.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../appbar_home.dart';
import '../models/soeichModel.dart';


class newReplace_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  newReplace_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => newReplace_pageState();
}

class newReplace_pageState extends State<newReplace_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  String sanad = "سند";
  List<CheckSerialModel> _data = [];
  String name = "نام پذیرنده";
  String terminal = "ترمینال";
  String forushgah = "فروشگاه";
  //String noe = "نوع دستگاه";
  String PSP = "PSP";
  String model = "نوع";
  bool hideBtn = true;
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  bool loading = false;
  late String isAllow ;
  late String isAllow2 ;
  List<SerialModel> _data4 = [];
  String _serial_value = "سریال";
  List<String> _serialvalue = [];
  final primary = Color(0xbb000000);
  late bool isPSPSelected = false;
  late bool pasargad = false;
  late bool iran = false;
  late bool sadad = false;
  late bool beh = false;
  late bool sepehr = false;
  late bool novin = false;
  final secondary = Color(0xfff29a94);
  late TextEditingController _controller2 = TextEditingController(text: "سریال");
  late Map response;
  List<String> _soeichvalue = [];

  String _soeich_value = "سوئیچ";
  List<SoeichModel> _data3 = [];
  ///95465654
  void getSoeichList() async {
    Map response = await OnlineServices.getSoeichList({"agentcode":widget._Agentdata.last.agentCode});
    _data3.clear();
    _soeichvalue.clear();
    _data3.addAll(response['data']);
    // print(_data1);

    for (int i = 0 ; i< _data3.length ; i++)
    {
      _soeichvalue.add(_data3[i].soeich_no);
    }
    setState(() {});

  }

  void _checkSupportRec() async {
    String response = await OnlineServices.checkSupportRec({"terminal": terminal});
    isAllow = response;
    if(isAllow == "yes")
      _showDialog("نماینده گرامی\nاین ترمینال، درخواست پشتیبانی باز دارد. \n لطفا بعد از انجام عملیات جایگزینی، تراکنش های ریالی مرتبط با سوئیچ را انجام دهید.\n باتشکر");

  }
  void _terminalLockRec() async {
    isAllow2 = await OnlineServices.terminalLock({"terminal": terminal});
    isAllow2 != "no" ?
    _showDialog(isAllow2) : null;
    ///G2001B17671

  }

  void getSerialList() async {
    Map response = await OnlineServices.getSerialList({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "psp": PSP,
      "noe": model
    });
    _data4.clear();
    _serialvalue.clear();
    _data4.addAll(response['data']);

    for (int i = 0; i < _data4.length; i++) {
      _serialvalue.add(_data4[i].serial_no);
    }
    setState(() {});
  }


  @override
  void initState() {
    getSoeichList();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight - 65;
    Color cl = Colors.black;
    Color cl2 = Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("جایگزینی سریال","", Icons.edit, (){})),

      body: SingleChildScrollView(
        child:Container(
          height: size.height - appBarHeight -50,
            child: Stack(
                children: [
            SingleChildScrollView(
               child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Text("لطفا PSP مورد نظر را انتخاب کنید",style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800,fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _soeichvalue.contains("پاسارگاد") ? GestureDetector(child:
                    Container(
                      width: _soeichvalue.contains("ایران کیش") ?size.width * .19 : size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: pasargad == true ? Color(0xc2d3d1d1) :Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/pasargad.png"),
                    ), onTap: (){
                        isPSPSelected = true;
                        _data.clear();
                        _data4.clear();
                        PSP = "PSP";
                        model = "نوع";
                        {pasargad = true; iran = false;sadad = false;beh = false;sepehr=false;novin=false;}
                        setState(() {});

                      },) : Center(),
                    _soeichvalue.contains("ایران کیش") ? GestureDetector(child:
                    Container(
                      width: _soeichvalue.contains("پاسارگاد") ?size.width * .19 : size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: iran == true ? Color(0xc2d3d1d1) : Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/irankish.png"),
                    ),
                      onTap: (){
                        _data.clear();
                        _data4.clear();
                        PSP = "PSP";
                        model = "نوع";
                        isPSPSelected = true;
                        {pasargad = false; iran = true;sadad = false;beh = false;sepehr=false;novin=false;}
                        setState(() {});

                      },): Center(),
                    _soeichvalue.contains("پرداخت نوین") ? GestureDetector(child:
                    Container(
                      width: size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: novin == true ? Color(0xc2d3d1d1) : Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/novin.png"),
                    ),
                      onTap: (){
                        _data.clear();
                        _data4.clear();
                        isPSPSelected = true;
                        {pasargad = false; iran = false;sadad = false;beh = false;sepehr=false;novin=true;}
                        setState(() {});

                      },) :Center(),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _soeichvalue.contains("سداد") ? GestureDetector(child:
                    Container(
                      width: _soeichvalue.contains("به پرداخت") ?size.width * .19 : size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: sadad == true ? Color(0xc2d3d1d1) : Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/sadad.png"),
                    ),
                      onTap: (){
                        _data.clear();
                        _data4.clear();
                        isPSPSelected = true;
                        {pasargad = false; iran = false;sadad = true;beh = false;sepehr=false;novin=false;}
                        setState(() {});

                      },) :Center(),
                    _soeichvalue.contains("به پرداخت") ? GestureDetector(child:
                    Container(
                      width: _soeichvalue.contains("سداد") ?size.width * .19 : size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: beh == true ? Color(0xc2d3d1d1) : Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/behpardakht.png"),
                    ),
                      onTap: (){
                        _data.clear();
                        _data4.clear();
                        isPSPSelected = true;
                        {pasargad = false; iran = false;sadad = false;beh = true;sepehr=false;novin=false;}
                        setState(() {});

                      },) : Center(),
                    _soeichvalue.contains("سپهر") ? GestureDetector(child:
                    Container(
                      width: _soeichvalue.contains("سداد") ?size.width * .19 : size.width * .19,
                      height: size.width * .18,
                      decoration: BoxDecoration(
                          color: sepehr == true ? Color(0xc2d3d1d1) : Color(0xffffffff)  ,
                          border: Border.all(width: 1, color: Color(0xff000000)),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Image.asset("assets/images/sepehr.png"),
                    ),
                      onTap: (){
                        _data.clear();
                        _data4.clear();
                        isPSPSelected = true;
                        {pasargad = false; iran = false;sadad = false;beh = false;sepehr = true;novin=false;}
                        setState(() {});

                      },) : Center(),
                  ],
                ),

                Visibility(child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width * .5,
                      margin: EdgeInsets.only(right: 25, top: 13),
                      child: TextFormField(
                        enabled: _data.isNotEmpty ? false : true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text ,
                        cursorColor: cl,
                        textAlign: TextAlign.center,
                        key: _key1,
                        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          counterText: "",
                          prefixIcon: Icon(
                            Icons.adjust_outlined,
                            color: cl,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: cl,
                              width: 1.0,
                            ),
                          ),
                          fillColor: cl,
                          focusColor: cl,
                          hoverColor: cl,
contentPadding: EdgeInsets.zero,
                          //errorText: _errorText1,
                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl)),

                          labelText: "سریال فعلی",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl2)),
                          // errorText: 'Error message',
                          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 25,top: 12,right: 7),
                      child: ElevatedButton(onPressed: _data.isNotEmpty ? null : (){
                        _data.clear();
                      //     print("------");
                      //    print(_key1.currentState!.value.toString());
                      if (_key1.currentState!.value.toString().length > 1) {
                        _getData();
                      } else
                        Comp.showSnackError(context);} , child: Text("بررسی سـریال",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.teal)
                          )
                      ),minimumSize: MaterialStateProperty.all(Size(size.width * .28, 10)),elevation: MaterialStateProperty.all(10),padding: MaterialStateProperty.all(EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5)),backgroundColor: MaterialStateProperty.all(Colors.teal)),),),
                  ],
                ),visible: isPSPSelected),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    _data.isNotEmpty ? Comp.editBox9_1(context, "نوع", model == "GPRS" ? Icons.wifi : model == "Typical" ? Icons.phone : Icons.cable, model) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "ترمینال", Icons.title, terminal) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "سند", Icons.drive_file_rename_outline, sanad) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "فروشگاه", Icons.storefront, forushgah) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "نام پذیرنده", Icons.person_outline, name) : Center(),
                    _data.isNotEmpty ? Comp.editBox8(context, "PSP", Icons.apps, PSP) : Center(),
                    ///4D2A0116

                    _data.isNotEmpty ? Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                            controller: _controller2,
                            enabled: false,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.drive_file_rename_outline,
                                color: Colors.black,
                              ),

                              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: cl,width: 1.0)),
                              labelText: "سریال",
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: cl,width: 1.0)),
                            ),
                          ),
                        ),
                        ///4D2A0116

                        Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                            width: size.width,
                            padding: EdgeInsets.only(right: 60,left: 20),
                            child:
                            SearchableDropdown.single(
                              style: TextStyle(color: Color(0x00000000)),
                              items: _serialvalue.map((String val) {
                                return DropdownMenuItem<String>(

                                    value: val,
                                    child: Text(val));
                              }).toList(),
                              underline: Container(),
                              // value: ,
                              hint: Text(""),
                              searchHint: "انتخاب سریال",
                              onChanged: (value) {
                                _serial_value = value;
                                _controller2 = TextEditingController(text: _serial_value);
                                hideBtn = false;

                                setState(() {});
                              },
                              isExpanded: true,
                            )
                        ),

                      ],
                    ) : Center(),

                    SizedBox(height: size.height * .08,),
                  ],
                ),
              ],
            ),
          ),
                  Visibility(child: Comp.fullBtn(size, "ثبت جایگزینی",Icons.save_outlined ,fun ),visible: !hideBtn),
                  SizedBox(height: 20,),
                  loading == true ?
                  Comp.showLoading(size.height , size.width) : Center(),
            //  SizedBox(height: 20,),

        ])),
      ) ,
    );
  }
  

  void fun() {

      if (

      name.length > 1 &&
          sanad.length > 1 &&
          forushgah.length > 1 &&
          terminal.length > 1 &&
          _serial_value.length > 5
      ) {
        loading = true;
        setState(() {});
        sendDataForReplace();
      }
      else {
        Comp.showSnack(context, Icons.warning_amber_rounded,
            "مقادیر را بصورت صحیح وارد کنید");
      }
  }


  void _getData() async {

    response = await OnlineServices.checkSerial2_1({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "panel": sepehr ? "سپهر" :pasargad ? "پاسارگاد" : iran ? "ایران کیش" : sadad ? "سداد" : beh ? "به پرداخت" : novin ? "پرداخت نوین" : "---",
      "serial": _key1.currentState!.value.toString()
    });
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      name = _data[0].name;
      sanad = _data[0].sanad;
      forushgah = _data[0].forushgah;
      terminal = _data[0].terminal;
      model = _data[0].model;
      PSP = _data[0].soeich;
      getSerialList();
      _checkSupportRec();
      _terminalLockRec();
      setState(() {});
    }
    else {
      sanad = "سند";
      name = "نام پذیرنده";
      terminal = "ترمینال";
      forushgah = "فروشگاه";
      PSP = "PSP";
      model = "مدل";
      _serialvalue.clear();
      setState(() {});
      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          confirmBtnText: "بستن",
          onConfirmBtnTap: (){
            Navigator.pop(context);
          },
          title: "",
          backgroundColor: Colors.white,
          text: "سریال یافت نشد"
      );
    }

  }



 void sendDataForReplace() async {
   PersianDate persianDate = PersianDate();String today = persianDate.getDate.toString().substring(0, persianDate.getDate.toString().length - 13).replaceAll("-", "/");String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;
    String response = await (OnlineServices()).sendDataForReplace({
      "tarikh": today, "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "sanadpazirande": sanad,
      "namepazirande": name,
      "serialold": _key1.currentState!.value.toString(),
      "serialnew": _serial_value.substring(0, _serial_value.length - (_serial_value.split("-").last.length + 1))
    });
    // print("--------------------" + response);
    if (response == "ok") {
      loading = false;
      setState(() {});
      Navigator.pop(context);
      _showDialog("با موفقیت ثبت شد");
    }else{
      loading = false;
      setState(() {});
      Navigator.pop(context);
      _showDialog("خطا");
    }
  }

  void _showDialog(String txt) {
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
                      textDirection: TextDirection.rtl,
                      child: Text(txt,textAlign: TextAlign.start,))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) =>
                    //             Directionality(
                    //                 textDirection: TextDirection.rtl,
                    //                 child: appbar_home(widget._Agentdata))));
                  },
                  child: const Text(
                    "تایید",
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
