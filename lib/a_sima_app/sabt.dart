
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/components/InputFields.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos2.dart';

import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';
import 'package:sima_portal/a_sima_app/EM/em_cartableP.dart';

import 'components/Styles.dart';
import 'EM/em_cartableI.dart';

class sabt_page extends StatefulWidget {
  String shenase ;
  String psp ;

  List<AgentModel> _Agentdata = [];

  sabt_page(this.shenase,this._Agentdata,this.psp);

  @override
  State<StatefulWidget> createState() => sabt_pageState();

}

class sabt_pageState extends State<sabt_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  String _key6 = "";
  String _key7 = "";
  String _key8 = "";

  // PersianDate persianDate = PersianDate( "yyyy/mm/dd  \n DD  , d  MM  ");
  String _datetime = 'انتخاب کنید';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  List<String> _genderValue = ['01', '02','03', '04','05', '06','07', '08','09', '10','11','12','13','14','15','16','17','18','19','20','21','22','23','00',];
  String _gender_Value = "ساعت";
  String _region_Value = "دقیقه";
  List<String> _regionValue = ['01', '02','03', '04','05', '06','07', '08','09', '10','11','12','13','14','15','16','17','18','19','20','21','22','23','24','25','26','27','28','29','30','31','32','33','34','35','36','37','38','39','40','41','42','43','44','45','46','47','48','49','50','51','52','53','54','55','56','57','58','59'];
  late TextEditingController _controller1= TextEditingController(text: "دقیقه");
  late TextEditingController _controller2= TextEditingController(text: "ساعت");
 late TextEditingController _controller3 = TextEditingController(text: "تاریخ");

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    var size = MediaQuery.of(context).size;

    bool _allow = true;
    Color cl = Colors.black;
    return WillPopScope(
        child:
      Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("درخواست های پشتیبانی","", Icons.edit, (){})),
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:Container(
          margin: EdgeInsets.only(top: 20),
          height: size.height,
          // color: Colors.white,
          child:
          ListView(
           // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Comp.editBox1(context,1,0, "توضیحات", Icons.message_outlined, _key1, ""),
              Comp.editBox1(context, 1,0,"پیگیری", Icons.drive_file_rename_outline, _key2, ""),
              GestureDetector(
                  onTap: _showDatePicker,
                  child:  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Container(
                        margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                        //  initialValue: _datetime == "-" ? "-" : _datetime.replaceAll("-", "/"),
                          controller: _controller3,
                          enabled: false,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,
                            prefixIcon: Icon(
                              Icons.cake,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cl,width: 1.0)),
                            labelText: "تاریخ",
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: cl,width: 1.0)),
                          ),
                        ),
                      ),
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      width: size.width * .4, child:Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                       // width: size.width * .3,
                        margin: EdgeInsets.only( right: 10, top: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                       //   initialValue: _region_Value,
                          controller: _controller1,
                          enabled: false,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,

                            prefixIcon: Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),

                            labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cl,width: 1.0)),
                            labelText: "دقیقه",
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: cl,width: 1.0)),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(  bottom: 6),
                          width: size.width,
                          padding: EdgeInsets.only(right: 30,left: 20),
                          child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              items:_regionValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                              onChanged: (newVal) {
                                _region_Value = newVal!;
                                _key6 = newVal;
                                _controller1 = TextEditingController(text: _region_Value);
                                setState(() {});
                              }))
                    ],
                  )),
                  Container(
                      width: size.width * .4, child:Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(

                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: TextFormField(
                          textAlign: TextAlign.center,
                         // initialValue: _gender_Value,
                          controller: _controller2,
                          enabled: false,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,

                            prefixIcon: Icon(
                              Icons.access_time,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cl,width: 1.0)),
                            labelText: "ساعت",
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: cl,width: 1.0)),
                          ),
                        ),
                      ),
                      Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only( bottom: 6),
                          width: size.width,
                          padding: EdgeInsets.only(right: 30,left: 20),
                          child: DropdownButton<String>(
                              isExpanded: true,
                              underline: Container(),
                              items:_genderValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                              onChanged: (newVal) {
                                _gender_Value = newVal!;
                                _key7 = newVal;
                                _controller2 = TextEditingController(text: _gender_Value);
                                setState(() {});
                              }))
                    ],
                  )),
                ],
              ),
              Comp.fullBtn(size, "ثبت", Icons.save_outlined, fun),

            ],
          ),
        ),
      ),
    onWillPop: () {
         // showInSnackBar();
    return Future.value(_allow); // if true allow back else block it
    });
  }

  void fun(){
    if (_key1.currentState!.value.toString().length > 2 &&
        _key2.currentState!.value.toString().length > 2 &&
        _key6.length > 1 &&
        _key7.length > 1 &&
        _key8.contains("-")
    )
    {
      sendDataForSave();
    }
    else Comp.showSnackError(context);
  }

  void sendDataForSave() async {
    String response;

     widget.psp == "پاسارگاد" ? response = await (OnlineServices()).sendDataForPasargad({"shenase" : widget.shenase  , "saat": _key7.toString() + ":" + _key6.toString() , "tozihat" : _key1.currentState!.value.toString(), "tarikh": _key8.toString().replaceAll("-", "/") ,"peygiri" : _key2.currentState!.value.toString() })
    : response = await (OnlineServices()).sendDataForIranKish({"peygiri" : widget.shenase  , "saat": _key7.toString() + ":" + _key6.toString() , "tozihat" : _key1.currentState!.value.toString(), "tarikh": _key8.toString().replaceAll("-", "/") ,"rahgiri" : _key2.currentState!.value.toString() });

    if (response=="ok")
    {
      setState(() {});
      _showDialog(context);
    }
    else{
 //     print("errrror");
    }
  }

  void _showDialog(BuildContext context) {
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
                      child: Text('با موفقیت ثبت شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                widget.psp=="پاسارگاد" ?
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: em_cartableP_page(widget._Agentdata))))
                    : Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: em_cartableI_page(widget._Agentdata))));


              },
                  child: Text("تایید",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),))
            ],
          ),
        );
      },
    );
  }

  void _showDatePicker() async {
    String m = "";
    String d = "";
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1401,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
          if (!showTitleActions) {
          }
        }, onConfirm: (year, month, day) {
          month! < 10 ? m = ("0$month") : m = ("$month");
          day! < 10 ? d = ("0$day") : d = ("$day");
          _datetime = '$year-$m-$d';
          if (!_datetime.contains("انتخاب"))
          {
            _key8 = _datetime;
          _controller3= TextEditingController(text: _datetime.replaceAll("-", "/"));
          }  setState(() {});

        });
  }


}