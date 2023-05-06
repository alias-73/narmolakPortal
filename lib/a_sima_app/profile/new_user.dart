
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/components/InputFields.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/profile/list_users.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos2.dart';

import 'package:sima_portal/a_sima_app/models/pazirandeModel3.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';

import '../appbar_home.dart';

class newUser extends StatefulWidget {List<AgentModel> _Agentdata = [];newUser(this._Agentdata);@override State<StatefulWidget> createState() =>  register_pos_pageState();}

class register_pos_pageState extends State<newUser> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  final _key8 = GlobalKey<FormFieldState>();
  String _key9= "";
  TextEditingController? _controller2;

  List<String> _genderValue = ['کاربر' , 'نماینده'];
  String _gender_Value = "نماینده یا کاربر";
  bool loading = false;

  @override
  void initState()  {
    super.initState();
   }
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    Color bcTextColor = Color(0x22000000);
    Color cl = Color(0xff000000);
    ///0385957531
    return
       Scaffold(
           appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ثبت نماینده یا کاربر جدید","", Icons.edit, (){})),
           key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:SingleChildScrollView(child:
            Column(
              children: <Widget>[
                SizedBox(height: 10,),

                Stack(
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
                            Icons.person_pin_outlined,
                            color: Colors.black,
                          ),
                          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: cl,width: 1.0)),
                          labelText: "نماینده یا کاربر",
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
                              _key9 = newVal;
                              _controller2 = TextEditingController(text: _gender_Value);
                              setState(() {});
                            }))
                  ],
                ),

                Comp.editBox1(context,1,0, "نام نماینده یا کاربر", Icons.person_outline, _key1, ""),
                Comp.editBox1(context,0,10, "کد ملی", Icons.drive_file_rename_outline, _key2, ""),
                Comp.editBox1(context,0,11, "تلفن", Icons.phone, _key3, ""),
                Comp.editBox1(context,0,11, "موبایل", Icons.phone_iphone, _key4, ""),
                Comp.editBox1(context,1,0, "آدرس", Icons.location_on, _key5, ""),
                Comp.editBox13(context,1,0, "نام کاربری", Icons.person, _key6, ""),
                Comp.editBox13(context,1,0, "رمز عبور", Icons.lock, _key7, ""),
                Comp.editBox13(context,1,0, "تکرار رمز عبور", Icons.lock, _key8, ""),

                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Comp.miniBtn1(context ,size, "ذخیره", Colors.teal , fun , 1),
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
    users_page(widget._Agentdata))));

  }
  void fun(){
    if (
    _key9.toString().length > 2 &&
    _key1.currentState!.value.toString().length > 2 &&
        _key2.currentState!.value.toString().length == 10 &&
        _key3.currentState!.value.toString().length == 11 &&
        _key4.currentState!.value.toString().length == 11 &&
        _key5.currentState!.value.toString().length > 2 &&
        _key6.currentState!.value.toString().length > 2 &&
        _key7.currentState!.value.toString().length > 2 &&
        _key8.currentState!.value.toString().length > 2 &&
        (_key8.currentState!.value.toString() == _key7.currentState!.value.toString())
    )
    {
      CoolAlert.show(
        context: context,
        confirmBtnText: "   تایید میکنم  ",
        cancelBtnText: "لغو",
        type: CoolAlertType.confirm,
        title: "",
        backgroundColor: Colors.white,
        onConfirmBtnTap: (){
          sendDataForNewUser();
          loading = true;
          setState(() {});        },
        text: "\nآیا از ایجاد کاربر \n" + _key1.currentState!.value.toString() + "\nبا نام کاربری "  + "\n" + _key6.currentState!.value.toString() +"\n" + "و رمز عبور \n" + _key7.currentState!.value.toString() + "\n اطمینان دارید؟",
      );

    } else
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  void sendDataForNewUser() async {
    String response = await (OnlineServices()).addUser(_key9.toString(),{
      "agentcode": widget._Agentdata.last.agentCode,
      "name": _key1.currentState!.value.toString(),
      "meli": _key2.currentState!.value.toString(),
      "tell": _key3.currentState!.value.toString(),
      "mobile": _key4.currentState!.value.toString(),
      "address": _key5.currentState!.value.toString(),
      "username": _key6.currentState!.value.toString(),
      "password": _key7.currentState!.value.toString()
    });
    //   print(response);
    if (response == "ok") {
      loading = false;
      setState(() {});
      Navigator.pop(context);
      _showDialog(context);
    } else if (response == "repeat"){
      Navigator.pop(context);
      CoolAlert.show(
        context: context,cancelBtnText: "",
        confirmBtnText: "   ویرایش  ",
        type: CoolAlertType.confirm,
        title: "",
        backgroundColor: Colors.white,
        onConfirmBtnTap: (){
          Navigator.pop(context);
        },
        text: "این نام کاربری قبلا ایجاد شده است."
      );}

  }
  void _showDialog(BuildContext context) {
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
                      child: Text('با موفقیت ثبت شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);

                  },
                  child: Text(
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