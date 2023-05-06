// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
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

import 'models/checkIMElModel.dart';
import 'models/soeichModel.dart';


class newIMEI_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  newIMEI_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => newIMEI_pageState();
}

class newIMEI_pageState extends State<newIMEI_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  String sanad = "سند";
  List<CheckIMEIModel> _data = [];
  String name = "نام پذیرنده";
  String terminal = "ترمینال";
  String mobile = "موبایل";
  String serial = "سریال";
  String brand = "برند";
  String modell = "مدل";
  String url = "مدل";
  String forushgah = "فروشگاه";
  //String noe = "نوع دستگاه";
  String PSP = "PSP";
  String model = "نوع";
  bool hideBtn = true;
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  bool loading = false;
  late String isAllow ;
  List<SerialModel> _data4 = [];
  String _serial_value = "سریال";
  List<String> _serialvalue = [];
  final primary = Color(0xbb000000);

  final secondary = Color(0xfff29a94);
  late TextEditingController _controller1 = TextEditingController(text: "");
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
  }

  @override
  void initState() {

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
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("طرح رجیستری","", Icons.edit, (){})),

      body: SingleChildScrollView(
        child:Container(
          height: size.height - appBarHeight -50,
            child: Stack(
                children: [
            SingleChildScrollView(
               child: Column(
              children: <Widget>[
                SizedBox(height: 10,),

                 Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: size.width * .5,
                      margin: EdgeInsets.only(right: 25, top: 13),
                      child: TextFormField(
                        //initialValue: "70063323",
                        enabled: _data.isNotEmpty ? false : true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text ,
                        cursorColor: cl,
                        controller: _controller1,
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

                          labelText: "ترمینال",
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
                        Comp.showSnackError(context);} , child: Text("بررسی ترمینال",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.teal)
                          )
                      ),minimumSize: MaterialStateProperty.all(Size(size.width * .28, 10)),elevation: MaterialStateProperty.all(10),padding: MaterialStateProperty.all(EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5)),backgroundColor: MaterialStateProperty.all(Colors.teal)),),),
                  ],
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _data.isNotEmpty ? Comp.editBox9(context, "سند", Icons.drive_file_rename_outline, sanad) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "نام", Icons.person_outline, name) : Center(),
                    _data.isNotEmpty ? Comp.editBox9(context, "موبایل", Icons.title, mobile) : Center(),
                    _data.isNotEmpty ? Comp.editBox8(context, "PSP", Icons.apps, PSP) : Center(),
                    _data.isNotEmpty ? Comp.editBox8(context, "سریال", Icons.drive_file_rename_outline, serial) : Center(),
                    _data.isNotEmpty ? Comp.editBox8(context, "برند", Icons.account_tree_outlined, brand) : Center(),
                    _data.isNotEmpty ? Comp.editBox8(context, "مدل", Icons.ad_units_rounded, model) : Center(),

                    _data.isNotEmpty ? SizedBox( child: CachedNetworkImage(
                        imageUrl: url,
                        placeholder: (context, url) =>
                            Image.asset("assets/images/pos3.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/pos3.png"),
                      ),height: size.width * .5) : Center(),

                    _data.isNotEmpty ? Comp.editBox1(context,1,0, "شماره IMEI", Icons.drive_file_rename_outline, _key2, "") : Center(),
                    _data.isNotEmpty ? Comp.editBox1(context,0,11, "شماره SIM", Icons.drive_file_rename_outline, _key3, "") : Center(),
                    _data.isNotEmpty ? Comp.editBox1(context,1,0, "شماره APN", Icons.drive_file_rename_outline, _key4, "") : Center(),

                    SizedBox(height: size.height * .08,),
                         ],
                       ),
                     ],
                   ),
                 ),
                  Visibility(child: Comp.fullBtn(size, "ثبت",Icons.save_outlined ,fun ),visible: _data.isNotEmpty),
                  SizedBox(height: 20,),
                  loading == true ?
                  Comp.showLoading(size.height , size.width) : Center(),
            //  SizedBox(height: 20,),

        ])),
      ) ,
    );
  }
  
  void fun(){
     // print("___________33");
      if (
        _key2.currentState?.value.length > 4

      ) {
        loading = true;
        setState(() {});
        sendDataForReplace();
      }
      else {
        Comp.showSnack(context, Icons.warning_amber_rounded, "IMEI را بصورت صحیح وارد کنید");
      }
    }

  void _getData() async {

    response = await OnlineServices.checkTerminal({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "terminal": _key1.currentState!.value.toString()
    });
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      name = _data[0].name;
      sanad = _data[0].sanad;
      serial = _data[0].serial;
      brand = _data[0].brand;
      url = _data[0].url;
      mobile = _data[0].mobilepish + _data[0].mobile;
      // forushgah = _data[0].forushgah;
      // terminal = _data[0].terminal;
      model = _data[0].model;
      PSP = _data[0].soeich;
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
          text: "ترمینال یافت نشد"
      );
    }

  }

 void sendDataForReplace() async {
   PersianDate persianDate = PersianDate();String today = persianDate.getDate.toString().substring(0, persianDate.getDate.toString().length - 13).replaceAll("-", "/");String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;

    String response = await (OnlineServices()).sendDataForIMEI({
      "tarikh": today, "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "sanadpazirande": sanad,
      "terminal": _key1.currentState!.value.toString(),
      "serial": serial,
      "soeich": PSP,
      "imei": _key2.currentState!.value.toString(),
      "apn": _key4.currentState!.value.toString(),
      "mobile": _key3.currentState!.value.toString(),
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
