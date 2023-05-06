
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';

import 'package:sima_portal/a_sima_app/Pazirade/register_pos22.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';

import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';

import '../appbar_home.dart';

class register_pos_page11 extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  register_pos_page11(this._Agentdata);

  @override
  State<StatefulWidget> createState() =>  register_pos_pageState();

}

class register_pos_pageState extends State<register_pos_page11> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key1 = GlobalKey<FormFieldState>();
  String _key2 = "";
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();

  late TextEditingController _controller3 = TextEditingController(text: _datetime == "-" ? "-" : _datetime.replaceAll("-", "/"));
  String _datetime = 'تاریخ ثبت شرکت';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';

  @override
  void initState()  {
    setDefaultPrefs();
    super.initState();
   }
   void setDefaultPrefs() async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
     for(int i =1 ; i<29; i++) {
      // if (getPrefs("key${i}") == "")
     {
       //print("key${i} is NULL");
       await prefs.setString("key${i}", "*");
     }}
   }

  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString( key , value);
    //print(key + ": " + prefs.getString( key ));
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    Color cl = Color(0xff000000);

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات شرکت","", Icons.edit, (){})),

      key: _scaffoldKey,
      backgroundColor: Color(0xffF3F3F3),
     // backgroundColor: Color(0xffFFFAFA),

      resizeToAvoidBottomInset: true,
      body:SingleChildScrollView(child:
      Column(
        children: <Widget>[
          Comp.editBox1(context,2,0, "شناسه ملی", Icons.drive_file_rename_outline, _key1, ""),
          GestureDetector(
              onTap: _showDatePicker,
              child:  Stack(
                alignment: Alignment.center,
                children: <Widget>[

                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      textAlign: TextAlign.center,
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
                        labelText: "تاریخ ثبت شرکت",
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: cl,width: 1.0)),
                      ),
                    ),
                  ),
                ],
              )),
          Comp.editBox1(context, 2,0,"شماره ثبت", Icons.edit, _key3, ""),
          Comp.editBox1(context,1,0,"نام شرکت فارسی", Icons.title, _key4, ""),
          Comp.editBox1(context,1,0, "نام شرکت انگلیسی", Icons.title, _key5, ""),
          SizedBox(height: 20,),
          Center(child: Text("صفحه 1 از 4",style: TextStyle(fontSize: 17),),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Comp.miniBtn1(context ,size, "مرحله بعد", Colors.teal , fun , 1),
              Comp.miniBtn1(context , size, "انصراف", Colors.red , fun2 , 2),
            ],
          ),
          SizedBox(height: 20,)

        ],
      ),
      ),
    );
  }

  void fun (){
    if (_key1.currentState!.value.toString().length > 2 &&
        _key2.length > 2 &&
        _key3.currentState!.value.toString().length > 2 &&
        _key4.currentState!.value.toString().length > 2 &&
        _key5.currentState!.value.toString().length > 2 &&
        _key2.contains("-")
    )
    {
      setPrefs("key1" , _key1.currentState!.value.toString().trim() );
      setPrefs("key2" , _key2.toString() );
      setPrefs("key3" , _key3.currentState!.value.toString().trim() );
      setPrefs("key4" , _key4.currentState!.value.toString().trim() );
      setPrefs("key5" , _key5.currentState!.value.toString().trim() );
      // Navigator.pop(context);
      Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child:
      register_pos_page22(widget._Agentdata))));
    }
    else Comp.showSnackError(context);
  }
  void fun2 () {
    Navigator.push(context,  MaterialPageRoute(builder: (context) =>  Directionality(textDirection: TextDirection.rtl, child:
    appbar_home(widget._Agentdata))));

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
          {      _key2 = _datetime;
          _controller3= TextEditingController(text: _datetime.replaceAll("-", "/"));
          }
          setState(() {});
        });
  }

}