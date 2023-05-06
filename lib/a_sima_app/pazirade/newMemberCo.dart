
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

import 'package:sima_portal/a_sima_app/models/agentModel.dart';

import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

import 'list_memberCo.dart';

class newMemberCo extends StatefulWidget {String _sanad;String emza; List<AgentModel> _Agentdata = []; newMemberCo(this._sanad,this._Agentdata,this.emza);@override State<StatefulWidget> createState() =>  register_pos_pageState();}

class register_pos_pageState extends State<newMemberCo> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  final _key8 = GlobalKey<FormFieldState>();
  final _key9 = GlobalKey<FormFieldState>();
  final _key10 = GlobalKey<FormFieldState>();
  final _key11 = GlobalKey<FormFieldState>();
  final _key12 = GlobalKey<FormFieldState>();
  String _key13 = "";
  String _key14 = "";
  TextEditingController _controller1 = TextEditingController(text: "جنسیت");
  TextEditingController _controller2 = TextEditingController(text: "تاریخ تولد");

  String _datetime = 'انتخاب کنید';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  List<String> _genderValue = ['مذکر' , 'مونث'];
  String _gender_Value = "جنسیت";


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    Color cl = Color(0xff000000);

    return
       Scaffold(
           appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ثبت امضاکننده جدید","", Icons.edit, (){})),
           key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:SingleChildScrollView(child:
            Column(
              children: <Widget>[
                Comp.editBox1(context,1,0, "نام فارسی", Icons.person_outline, _key1, ""),
                Comp.editBox1(context, 1,0,"نام خانوادگی فارسی", Icons.person_outline, _key2, ""),
                Comp.editBox1(context,1,0, "نام انگلیسی", Icons.person_pin, _key3, ""),
                Comp.editBox1(context,1,0, "نام خانوادگی انگلیسی", Icons.person_pin, _key4, ""),
                Comp.editBox1(context,1,0, "نام پدر فارسی", Icons.person_pin_outlined, _key5, ""),
                Comp.editBox1(context, 1,0,"نام پدر انگلیسی", Icons.person_pin_outlined, _key6, ""),
                Comp.editBox1(context,1,10,"شماره شناسنامه", Icons.card_membership, _key7, ""),
                Comp.editBox1(context,2,10, "کد ملی", Icons.card_membership, _key8, ""),
                Comp.editBox2(context,2,3,8, "پیش شماره","تلفن ثابت", Icons.phone, _key9, _key10, ""),
                Comp.editBox2(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key11, _key12, ""),


                Stack(
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
                              _key13 = newVal;
                              _controller1 = TextEditingController(text: _gender_Value);
                              setState(() {});
                            }))
                  ],
                ),
                GestureDetector(
                    onTap: _showDatePicker,
                    child:  Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                          child: TextFormField(
                            textAlign: TextAlign.center,
                         //   initialValue: _datetime == "-" ? "-" : _datetime.replaceAll("-", "/"),
                            controller: _controller2,
                            enabled: false,
                            cursorColor: Colors.black,
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                            decoration: InputDecoration(
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
                    )),
                Comp.fullBtn(size, "ثبت امضا کننده", Icons.save_outlined , fun ),
                SizedBox(height: 20,)

              ],
            ),)
      );
  }

  void fun(){
    if (_key1.currentState!.value
        .toString()
        .length > 1 &&
        _key2.currentState!.value
            .toString()
            .length > 1 &&
        _key3.currentState!.value
            .toString()
            .length > 1 &&
        _key4.currentState!.value
            .toString()
            .length > 1 &&
        _key5.currentState!.value
            .toString()
            .length > 1 &&
        _key6.currentState!.value
            .toString()
            .length > 1 &&
        _key7.currentState!.value
            .toString()
            .length > 1 &&
        _key8.currentState!.value
            .toString()
            .length == 10 &&
        _key9.currentState!.value
            .toString()
            .length == 3 &&
        _key10.currentState!.value
            .toString()
            .length == 8 &&
        _key11.currentState!.value
            .toString()
            .length == 4 &&
        _key12.currentState!.value
            .toString()
            .length == 7 &&
        _key13.toString()
            .length > 1 &&
        _key14.toString()
            .length > 2
    )
      send_newMemberCo(widget._sanad);
    else Comp.showSnackError(context);
  }
  void send_newMemberCo(String sanad) async {
    late String today = "";
  late String datetime = "";

    String response;
    response = await (OnlineServices()).send_newMemberCo(
        { "tarikh": today, "saat": datetime, "sanad" : sanad ,
          "agentcode" : widget._Agentdata.last.agentCode ,
          "usercode" : widget._Agentdata.last.userCode ,
          "namefa": _key1.currentState!.value.toString() + " " + _key2.currentState!.value.toString(),
          "nameen": _key3.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') + " " +_key4.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),''),
          "namefirstfa": _key1.currentState!.value.toString() ,
          "namelastfa": _key2.currentState!.value.toString() ,
          "namefirsten": _key3.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),''),
          "namelasten": _key4.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,
          "namepedarfa": _key5.currentState!.value.toString() ,
          "namepedaren": _key6.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,
          "shenasname": _key7.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,
          "codemeli": _key8.currentState!.value.toString() ,
          "tellpish": _key9.currentState!.value.toString() ,
          "tell": _key10.currentState!.value.toString() ,
          "mobilepish": _key11.currentState!.value.toString() ,
          "mobile": _key12.currentState!.value.toString() ,
          "gensiat": _key13.toString() ,
          "tavalod": _key14.toString().replaceAll("-", "/") });
    //print(response);
    if (response == "ok") {
      _showDialog(context, "ثبت عضو جدید با موفقیت انجام شد\n لطفا مدارک عضو ثبت شده را بارگذاری نمایید.");
    } }

  void _showDialog(BuildContext context , String txt) {
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
                      child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){ Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) =>
                  Directionality(textDirection: TextDirection.rtl,
                      child: memberCo_page(widget._Agentdata,widget._sanad,widget.emza))));
              },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4,bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(width: 1,color: Color(0xff000000),),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text("تایید",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 13),)
                  ))
            ],
          ),
        );
      },
    );
  }

  Future _showDatePicker() async {
    String? picked = await jalaliCalendarPicker(
        context: context,
        convertToGregorian: false,
        showTimePicker: false,
        hore24Format: true);
    if (picked != null) setState(() => _datetime = picked);
    if (!_datetime.contains("انتخاب"))
    {
      _key14 = _datetime;
      _controller2= TextEditingController(text: _datetime.replaceAll("-", "/"));
    }
    setState(() {});

  }

//   void _showDatePicker() {
//     final bool showTitleActions = false;
//     DatePicker.showDatePicker(context,
//         minYear: 1310,
//         maxYear: 1385,
// /*      initialYear: 1368,
//       initialMonth: 05,
//       initialDay: 30,*/
//         confirm: Text(
//           'تایید',
//           style: TextStyle(color: Colors.red),
//         ),
//         cancel: Text(
//           'لغو',
//           style: TextStyle(color: Colors.cyan),
//         ),
//         dateFormat: _format, onChanged: (year, month, day) {
//           if (!showTitleActions) {
//             _changeDatetime(year!, month!, day!);
//           }
//         }, onConfirm: (year, month, day) {
//
//           _changeDatetime(year!, month!, day!);
//         });
//   }
//
//   void _changeDatetime(int year, int month, int day) {
//     String M = month.toString();
//     String D = day.toString();
//     setState(() {
//       if (M.length ==1)
//         M = "0$M";
//       if (D.length ==1)
//         D = "0$D";
//
//       _datetime = '$year-$M-$D';
//       if (!_datetime.contains("انتخاب"))
//         {_key14 = _datetime;
//         _controller2= TextEditingController(text: _datetime.replaceAll("-", "/"));
//
//         }
//     });
//   }
}