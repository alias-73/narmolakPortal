// ignore_for_file: non_constant_identifier_names

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/bankModel.dart';
import 'package:sima_portal/a_sima_app/models/serialModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';


class changePersonalInfo extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  changePersonalInfo(this._Agentdata);

  @override
  State<StatefulWidget> createState() => changePersonalInfoState();
}

class changePersonalInfoState extends State<changePersonalInfo> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  String sanad = "سند";
  String name = "نام پذیرنده";
  String serial = "ترمینال";
  String forushgah = "فروشگاه";
  List<BankModel> _data = [];
  String _serial_value = "";
  List<String> _serialvalue = ["الف","ب","ل","د","ر","1","2","3","4","9","10","11"];
  //String noe = "نوع دستگاه";
  final _key1 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4_1 = GlobalKey<FormFieldState>();
  final _key4_2 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  bool loading = false;
  final primary = Color(0xbb000000);
  late bool isPSPSelected = false;
  late bool pasargad = false;
  late bool iran = false;
  late bool sadad = false;
  late bool beh = false;
  final secondary = Color(0xfff29a94);
  late TextEditingController _controller2 = TextEditingController(text: "");
  String pazirandeName = "0";
  late Map response ;
  ///95465654

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
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("تغییر مشخصات هویتی","", Icons.edit, (){})),

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
                        enabled: pazirandeName !="0" ? false : true,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text ,
                        cursorColor: cl,
                        textAlign: TextAlign.center,
                        maxLength: 10,
                        key: _key1,
                        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,

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
                          //errorText: _errorText1,
                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl)),

                          labelText: "کد ملی",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl2)),
                          // errorText: 'Error message',
                          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(left: 25,top: 12,right: 7),
                      child: ElevatedButton(onPressed: (){
                        if (_key1.currentState!.value.toString().length == 10) {
                          loading = true;
                          setState(() {});
                          _getData();
                        } else
                          Comp.showSnackError(context);  } , child: Text("بررسی ",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),
                          style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: BorderSide(color: Colors.teal)
                          )
                      ),minimumSize: MaterialStateProperty.all(Size(size.width * .28, 10)),elevation: MaterialStateProperty.all(10),padding: MaterialStateProperty.all(EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5)),backgroundColor: MaterialStateProperty.all(Colors.teal)),),),
                  ],
                ),
                SizedBox(height: 10,),
                pazirandeName !="0" ? Text( "نام پذیرنده:  " + pazirandeName ,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 23),) : Center() ,

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    pazirandeName != "0" ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                     Container(
                     width: size.width * .4,
                     margin: EdgeInsets.only( right: 30, top: 10),
                     child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _controller2,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(right: 10),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "حرف",
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: cl,width: 1.0)),
                      ),
                    ),
                  ),
                  ///4D2A0116

                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 35,  bottom: 6),
                      width: size.width * .4,
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
                        searchHint: "انتخاب حرف",
                        onChanged: (value) {
                          _serial_value = value;
                          _controller2 = TextEditingController(text: _serial_value);

                          setState(() {});
                        },
                        isExpanded: true,
                      )
                  ),

                ],
              ),
                        Text("/",style: TextStyle(fontSize: 28),),
                        Comp.editBoxCustom(context, "سری","",2, _key6 , size.width * .3),

                      ],
                    ) : Center(),
                    pazirandeName != "0" ? Comp.editBox5(context, 0 , 6 , "سریال شناسنامه", Icons.drive_file_rename_outline, _key3 , "") : Center(),
                    pazirandeName != "0" ? Comp.editBox6(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key4_1, _key4_2, "","")  : Center(),
                    pazirandeName != "0" ? Comp.editBox5(context, 0 , 10 , "کد مالیاتی", Icons.phone_android, _key5 , "") : Center(),
                    pazirandeName != "0" ? Text( "پر کردن فیلدها، اختیاری است."  ,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 19,color: Colors.red)) : Center(),

                    SizedBox(height: size.height * .08,),
                  ],
                ),
              ],
            ),
          ),
                  Comp.fullBtn(size, "ثبت تغییرات",Icons.save_outlined ,fun ),
                  SizedBox(height: 20,),
                  loading == true ? Comp.showLoading(size.height , size.width) : Center(),

            //  SizedBox(height: 20,),

        ])),
      ) ,
    );
  }

  void fun(){

      if (
          _key3.currentState!.value.toString().isNotEmpty  ||
          _key4_1.currentState!.value.toString().isNotEmpty ||
          _key4_2.currentState!.value.toString().isNotEmpty ||
          _key6.currentState!.value.toString().isNotEmpty  ||
          _serial_value.isNotEmpty                         ||
          _key5.currentState!.value.toString().isNotEmpty
         )
      {
        loading = true;
        setState(() {});
        sendDataForReplace();

      }
      else {
        Comp.showSnack(context, Icons.warning_amber_rounded, "مقادیر را بصورت صحیح وارد کنید");
      }
  }

  void _getData() async {

    response = await OnlineServices.checkCodeMeli({
      "codemeli": _key1.currentState!.value.toString()
    });
  //  print(response);
    if (response["data"] != "free") {
      loading = false;
      setState(() {});
      _data.clear();
      _data.addAll(response['data']);
      pazirandeName = _data.last.bankName;
      setState(() {});
    }
    else {
      loading = false;
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
          text: "کدملی یافت نشد"
      );
    }

  }


 void sendDataForReplace() async {
    late String today = "";
    String datetime ="";

    String response = await (OnlineServices()).checkCodeMeliSave({
      "tarikh": today, "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "codemeli": _key1.currentState!.value.toString(),
      "maliyat": _key5.currentState!.value.toString()       ,
      "seri": _key6.currentState!.value.toString()          ,
      "serial": _key3.currentState!.value.toString()        ,
      "mobilepish": _key4_1.currentState!.value.toString()  ,
      "mobile": _key4_2.currentState!.value.toString()      ,
      "harf": _serial_value                                 ,


    });
    // print("--------------------" + response);
    if (response == "ok") {
      loading = false;
      setState(() {});
      Navigator.pop(context);
      _showDialog("با موفقیت ثبت شد");
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
                    Navigator.pop(context);
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
