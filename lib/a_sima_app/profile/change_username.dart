
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
import 'package:sima_portal/snackbar/src/types.dart';

import '../../snackbar/src/animated_snack_bar.dart';

class changeUsername extends StatefulWidget {List<AgentModel> _Agentdata = [];changeUsername(this._Agentdata);@override State<StatefulWidget> createState() =>  register_pos_pageState();}

class register_pos_pageState extends State<changeUsername> with SingleTickerProviderStateMixin {
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  bool loading = false;
  setPrefs(String infoo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("info", infoo);
  }

  String info = "0,0,0";
  void getPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.remove("info");
    await prefs.getString("info").toString().contains("null") ? null : info = prefs.getString("info").toString();
    Future.delayed(const Duration(milliseconds: 3000), () {
      setState(() {});
    });
    if(info == "null" || info == "0")
    {
    }
    else
    {

    }
  }

  @override
  void initState()  {
    getPrefs();
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
           appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("تغییر نام کاربری","", Icons.edit, (){})),
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:SingleChildScrollView(child:
            Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Text("نام کاربری فعلی: " +  info.split(",")[1].toString(), style: TextStyle(fontWeight: FontWeight.w500, fontSize: 21,color: info.split(",")[1].toString()=="0" ? Colors.transparent : Colors.black),),
                Comp.editBox13(context,1,0, "نام کاربری جدید",       Icons.lock, _key2, ""),
                Comp.editBox13(context,1,0, "رمز عبور",       Icons.lock, _key3, ""),
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
    Navigator.pop(context);

  }
  void fun(){
    if (
    _key2.currentState!.value.toString().length > 1 &&
    _key3.currentState!.value.toString().length > 1
    )
    {
      CoolAlert.show(
        context: context,
        confirmBtnText: "   بلی  ",
        cancelBtnText: "لغو",
        type: CoolAlertType.confirm,
        title: "",
        backgroundColor: Colors.white,
        onConfirmBtnTap: (){
          Navigator.pop(context);

          sendDataForchangeUsername();
          loading = true;
          setState(() {});        },
        text: "آیا از تغییر نام کاربری اطمینان دارید؟"
        //text: "\nآیا از ایجاد کاربر \n" + _key1.currentState!.value.toString() + "\nبا نام کاربری "  + "\n" + _key6.currentState!.value.toString() +"\n" + "و رمز عبور \n" + _key7.currentState!.value.toString() + "\n اطمینان دارید؟",
      );

    } else{}
      Comp.showSnack2(context, Icons.warning_amber_rounded, "لطفا مقادیر را بصورت صحیح وارد نمایید");
  }

  void sendDataForchangeUsername() async {
    String response = await (OnlineServices()).changeUsername({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "passold": _key3.currentState!.value.toString(),
      "username": _key2.currentState!.value.toString(),
    });
    //   print(response);
    if (response == "yes") {
      info = info.split(",")[0].toString() + "," + _key2.currentState!.value.toString() + "," + info.split(",")[2].toString()  ;
      print(info);
      //setPrefs(info);

      loading = false;
      setState(() {});
      CoolAlert.show(
          context: context,

          confirmBtnText: "   بستن  ",
          onConfirmBtnTap: (){Navigator.pop(context);Navigator.pop(context);},
          type: CoolAlertType.success,
          title: "",
          backgroundColor: Colors.white,
          text: "نام کاربری با موفقیت تغییر کرد"
        //text: "\nآیا از ایجاد کاربر \n" + _key1.currentState!.value.toString() + "\nبا نام کاربری "  + "\n" + _key6.currentState!.value.toString() +"\n" + "و رمز عبور \n" + _key7.currentState!.value.toString() + "\n اطمینان دارید؟",
      );
    } else if (response == "no") {
      CoolAlert.show(
          context: context,
          confirmBtnText: "   بستن  ",
          type: CoolAlertType.error,
          title: "",
          onConfirmBtnTap: (){Navigator.pop(context);},
          backgroundColor: Colors.white,
          text: "رمز عبور فعلی نادرست است"
        //text: "\nآیا از ایجاد کاربر \n" + _key1.currentState!.value.toString() + "\nبا نام کاربری "  + "\n" + _key6.currentState!.value.toString() +"\n" + "و رمز عبور \n" + _key7.currentState!.value.toString() + "\n اطمینان دارید؟",
      );
      // print("errrror");
    }

  }

}