
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/components/InputFields.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos2.dart';

import 'package:sima_portal/a_sima_app/models/pazirandeModel3.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';

import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';

import '../appbar_home.dart';

class register_pos_page1 extends StatefulWidget {List<AgentModel> _Agentdata = [];register_pos_page1(this._Agentdata);@override State<StatefulWidget> createState() =>  register_pos_pageState();}

class register_pos_pageState extends State<register_pos_page1> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  final _key8 = GlobalKey<FormFieldState>();
  String _key9 = "";
  String _key10= "";
  String _key11 = "";
  String namefa = "";
  String lastfa = "";
  String nameen = "";
  String lasten = "";
  String pedaren = "";
  String pedarfa = "";
  String tavalod = "";
  String shsh = "";
  String gensiat = "";
  String meliat = "";
  String _datetime = 'تاریخ تولد';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  List<String> _genderValue =      ['مذکر' , 'مونث'];
  String _gender_Value = "جنسیت";
  String _region_Value = "ملیت";
  List<String> _regionValue = ['ایرانی' , 'خارجی'];
  TextEditingController? _controller1;
  TextEditingController? _controller2;

  TextEditingController? _controller3;
  List<PazirandeModel3> _data = [];
  String init = " ";

  @override
  void initState()  {
    setDefaultPrefs();
    super.initState();
   }
   void setDefaultPrefs() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     for(int i =1 ; i<29; i++) {
     {
       await prefs.setString("key${i}", "*");
     }}
   }

  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString( key , value);
    //print(key + ": " + prefs.getString( key ));
  }


  void _getData() async {
    Map response;
    response = await OnlineServices.getPazirandeInfo({
      "codemeli": _key8.currentState!.value.toString()
    });
    //  print(response);
    if (response["data"] != "free") {
     // print("oooooooooooooook");

      _data.clear();
      _data.addAll(response['data']);

      namefa = _data[0].namefa;
      nameen = _data[0].nameen;
      lastfa = _data[0].lastfa;
      lasten = _data[0].lasten;
      pedaren = _data[0].pedaren;
      pedarfa = _data[0].pedarfa;
      shsh = _data[0].shsh;
      tavalod = _data[0].tavalod;
      meliat = _data[0].meliat;
      gensiat = _data[0].gensiat;

      setState(() {});
    }
    else {init = "";
    _data.clear();

    }
    setState(() {});
    // else {
    //   Comp.showSnack(context, Icons.warning_amber_rounded, "این کد ملی قبلا ثبت نشده است\n لطفا اطلاعات پذیرنده را بصورت کامل وارد کنید");
    // // print("nooooooooooooooooo");
    // }

    }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    Color bcTextColor = Color(0x22000000);
    Color cl = Color(0xff000000);
    ///0385957531
    return
       Scaffold(
           appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات هویتی","", Icons.edit, (){})),
           key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:SingleChildScrollView(child:
            Column(
              children: <Widget>[
                SizedBox(height: 10,),

                Container(
                  margin: EdgeInsets.only(left: 30, right: 30, top: 13),
                  child: TextFormField(
                   // enabled: initial.length > 0 ? false : true,
                    maxLength: 10,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    cursorColor: cl,
                   // initialValue: "0385957531",
                    textAlign: TextAlign.center,
                    key: _key8,
                    style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                    decoration: InputDecoration(
                      counterText: "",
                      prefixIcon: Padding(child: FloatingActionButton(
                        child: Icon(Icons.refresh),
                        backgroundColor: Colors.teal,
                        onPressed: () {
                          _key8.currentState!.value.toString().length == 10 ?
                          _getData() : Comp.showSnackError(context);},
                        mini: true,
                      ),padding: EdgeInsets.only(right: 9),),
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

                      labelText: "کد ملی",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: cl)),
                      // errorText: 'Error message',
                      border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                    ),
                  ),
                ),

                _data.isNotEmpty ? Comp.editBox3(context, "نام پذیرنده فارسی", Icons.person_outline, namefa) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام پذیرنده فارسی", Icons.person_outline, _key1, init): Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "نام خانوادگی پذیرنده فارسی", Icons.person_outline, lastfa) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام خانوادگی پذیرنده فارسی", Icons.person_outline, _key2, init): Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "نام پدر فارسی", Icons.person_pin_outlined, pedarfa) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام پدر فارسی", Icons.person_pin_outlined, _key5, init): Center(),


                _data.isNotEmpty ? Comp.editBox3(context, "نام پذیرنده انگلیسی", Icons.person_pin, nameen) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام پذیرنده انگلیسی", Icons.person_pin, _key3, init): Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "نام خانوادگی پذیرنده انگلیسی", Icons.person_pin, lasten) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام خانوادگی پذیرنده انگلیسی", Icons.person_pin, _key4, init): Center(),


                _data.isNotEmpty ? Comp.editBox3(context, "نام پدر انگلیسی", Icons.person_pin_outlined, pedaren) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,0, "نام پدر انگلیسی", Icons.person_pin_outlined, _key6, init): Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "شماره شناسنامه", Icons.card_membership, shsh) : Center(),
                _data.isEmpty ? Comp.editBox1(context,1,10, "شماره شناسنامه", Icons.card_membership, _key7, init): Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "ملیت", Icons.flag_outlined, meliat) : Center(),
                _data.isEmpty ? Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                      child: TextFormField(
                        textAlign: TextAlign.center,
                        controller: _controller1,
                        enabled: false,
                        cursorColor: Colors.black,
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,

                          prefixIcon: Icon(
                            Icons.flag_outlined,
                            color: Colors.black,
                          ),

                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cl,width: 1.0)),
                          labelText: "ملیت",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl,width: 1.0)),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                        width: size.width,
                        padding: EdgeInsets.only(right: 60,left: 20),
                        child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            items:_regionValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                            onChanged: (newVal) {
                              _region_Value = newVal!;
                              _key9 = newVal;
                              _controller1 = TextEditingController(text: _region_Value);
                              setState(() {});
                            }))
                  ],
                ) : Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "جنسیت", Icons.wc, gensiat) : Center(),
                _data.isEmpty ? Stack(
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
                          contentPadding: EdgeInsets.zero,

                          prefixIcon: Icon(
                            Icons.wc,
                            color: Colors.black,
                          ),
                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cl,width: 1.0)),
                          labelText: "جنسیت",
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: cl,width: 1.0)),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                        width: size.width,
                        padding: EdgeInsets.only(right: 60,left: 20),
                        child: DropdownButton<String>(
                            isExpanded: true,
                            underline: Container(),
                            items:_genderValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                            onChanged: (newVal) {
                              _gender_Value = newVal!;
                              _key10 = newVal;
                              _controller2 = TextEditingController(text: _gender_Value);
                              setState(() {});
                            }))
                  ],
                ) : Center(),

                _data.isNotEmpty ? Comp.editBox3(context, "تاریخ تولد", Icons.cake, tavalod) : Center(),
                _data.isEmpty ? GestureDetector(
                    onTap: _showDatePicker,
                    child:  Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                       //     initialValue: _datetime == "-" ? "-" : _datetime.replaceAll("-", "/"),
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
                              labelText: "تاریخ تولد",
                              disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: cl,width: 1.0)),
                            ),
                          ),
                        ),
                      ],
                    )) : Center(),
                ///
              //  Comp.editBox1(context, 1,0,"نام خانوادگی پذیرنده فارسی", Icons.person_outline, _key2, ""),
              //   Comp.editBox1(context,1,0, "نام پذیرنده انگلیسی", Icons.person_pin, _key3, ""),
              //   Comp.editBox1(context,1,0, "نام خانوادگی پذیرنده انگلیسی", Icons.person_pin, _key4, ""),
              //   Comp.editBox1(context,1,0, "نام پدر فارسی", Icons.person_pin_outlined, _key5, ""),
              //   Comp.editBox1(context, 1,0,"نام پدر انگلیسی", Icons.person_pin_outlined, _key6, ""),
              //   Comp.editBox1(context,2,10,"شماره شناسنامه", Icons.card_membership, _key7, ""),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Comp.miniBtn1(context ,size, "مرحله بعد", Colors.teal , fun , 1),
                    Comp.miniBtn1(context , size, "انصراف", Colors.red , fun2 , 2),
                  ],
                ),
                SizedBox(height: 20,)

              ],
            ),)
      );
  }



  void fun2 () {
    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child:
    appbar_home(widget._Agentdata))));

  }
  void fun(){
  //  print(_key1.currentState!.value.toString().trim());
    if(_data.isEmpty)
      {
        if (_key1.currentState!.value.toString().length > 2 &&
            _key2.currentState!.value.toString().length > 2 &&
            _key3.currentState!.value.toString().length > 2 &&
            _key4.currentState!.value.toString().length > 2 &&
            _key5.currentState!.value.toString().length > 2 &&
            _key6.currentState!.value.toString().length > 2 &&
            _key7.currentState!.value.toString().length > 0 &&
            _key8.currentState!.value.toString().length == 10 &&
            _key9.toString().length > 2 &&
            _key10.toString().length > 2 &&
            _key11.contains("-")
        )
        {
          setPrefs("key1" , _key1.currentState!.value.toString().trim() );
          setPrefs("key2" , _key2.currentState!.value.toString().trim() );
          setPrefs("key3" , _key3.currentState!.value.toString().trim() );
          setPrefs("key4" , _key4.currentState!.value.toString().trim() );
          setPrefs("key5" , _key5.currentState!.value.toString().trim() );
          setPrefs("key6" , _key6.currentState!.value.toString().trim() );
          setPrefs("key7" , _key7.currentState!.value.toString().trim() );
          setPrefs("key8" , _key8.currentState!.value.toString().trim() );
          setPrefs("key9" , _key9.toString() );
          setPrefs("key10" , _key10.toString() );
          setPrefs("key11" , _key11.toString() );
          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child:
          register_pos_page2(widget._Agentdata, _key8.currentState!.value.toString().trim(), _key11.toString().replaceAll("-", "/"),_key1.currentState!.value.toString().trim() + " " + _key2.currentState!.value.toString().trim()))));
        }    else Comp.showSnackError(context);
        }
    else
      {
        if (_key8.currentState!.value.toString().length == 10)
        {
          setPrefs("key1" , namefa );
          setPrefs("key2" , lastfa );
          setPrefs("key3" , nameen );
          setPrefs("key4" , lasten );
          setPrefs("key5" , pedarfa );
          setPrefs("key6" , pedaren );
          setPrefs("key7" , shsh );
          setPrefs("key8" , _key8.currentState!.value.toString() );
          setPrefs("key9" , meliat );
          setPrefs("key10" , gensiat );
          setPrefs("key11" , tavalod );
          Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child:
          register_pos_page2(widget._Agentdata, _key8.currentState!.value.toString(), tavalod,namefa + " " + lastfa))));
        }    else Comp.showSnackError(context);
      }
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
          {_key11 = _datetime;
          _controller3= TextEditingController(text: _datetime.replaceAll("-", "/"));}
          setState(() {});

        });
  }


}
