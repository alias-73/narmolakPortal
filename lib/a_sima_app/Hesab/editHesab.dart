//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/Pazirade/EditedStore_page.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/bankModel.dart';
import 'package:sima_portal/a_sima_app/models/shobeModel.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';


import 'EditedReqChange_page.dart';

class edit_hesab extends StatefulWidget {
  List<AgentModel> _data = [];
//07031528
  edit_hesab(this._data);
//13415359
  @override
  State<StatefulWidget> createState() => list_riz_pageState();
}

class list_riz_pageState extends State<edit_hesab> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key1 = GlobalKey<FormFieldState>();
  String _key2 = "";
  String _key3 = "";
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  late String today = "";
  late String datetime = "";
  bool btnEnable = false;
  int currentPageIndex = 0;

  int i = 0;
  bool isFree = false;
  late   Map response;
  bool loading = false;
  String srch = "-";
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late  String info;

  List<String> _bankValue = [];
  List<String> _shobeValue = [];
  List<String> _pazirandeValue = [];
  String _pazirande_Value = "پذیرنده";
  String _bank_Value = "بانک";
  String _shobe_Value = "شعبه";
  List<BankModel> _data = [];
  List<ShobeModel> _data2 = [];

  String name = "0";
  String bank="0";
  String shobe="0";
  String hesab="0";
  String sheba="0";
  String sanad="0";
  String psp="0";
  late TextEditingController _controller1=TextEditingController(text:"");
 late  TextEditingController _controller2=TextEditingController(text:"");
 late  TextEditingController _controller3=TextEditingController(text:"");
 late  TextEditingController _controller4=TextEditingController(text:"");
 late  TextEditingController _controller5=TextEditingController(text:"");

  void getPrefs() async {
    _controller1 = TextEditingController(text: name);
    // _controller2 = TextEditingController(text: bank);
    // _controller3 = TextEditingController(text: shobe);
    _controller4 = TextEditingController(text: hesab);
    _controller5 = TextEditingController(text: sheba);
    setState(() {});
  }

  void _getOldInfo() async {
    String response = await OnlineServices.changeHesabReq({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "terminal": _key1.currentState!.value.toString(),
    });
    ///92988177
    ///
   // print(response);
    info = response;

      name = info.split(",") [0];
      bank = info.split(",") [1];
      shobe = info.split(",")[2];
      hesab = info.split(",")[3];
      sheba = info.split(",")[4];
      sanad = info.split(",")[5];
      psp = info.split(",")[6];

      psp.contains("کیش") ? dialogError(context) : null;

    getPrefs();
    loading = false;
    if(info.split(",")[0].length > 1)
      {
        btnEnable = true;
        setState(() {});
      }
    getBankList(psp);
  }

  void sendNewInfo() async {
    
    String response = await OnlineServices.sendChangeHesabReq({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "tarikh": today,
      "terminal": _key1.currentState!.value.toString(),
      "bankold": bank,
      "name": name,
      "banknew": _key2.toString(),
      "shobeold": shobe,
      "shobenew": _key3.toString(),
      "hesabold": hesab,
      "hesabnew": _key4.currentState!.value.toString(),
      "shabaold": sheba,
      "shabanew": _key5.currentState!.value.toString(),
    });
   // print(response);
    if(response == "ok")
      _showDialog(context);

    ///92988177
  }


  void getBankList(String psp) async {
    Map response = await OnlineServices.getBankList({"psp": psp});
    _data.clear();
    _bankValue.clear();
    _data.addAll(response['data']);
    for (int i = 0; i < _data.length; i++) {_bankValue.add(_data[i].bankName);}
    setState(() {});
  }

  void getShobeList(String bankName) async {
    Map response = await OnlineServices.getShobeList({"bankname": bankName});
    _data2.clear();
    _shobeValue.clear();
    _data2.addAll(response['data']);
    for (int i = 0; i < _data2.length; i++) {
      _shobeValue.add(_data2[i].shobeName);
    }
    setState(() {});
  }

  ///92799717
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;
    Color cl = Color(0xff000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("درخواست تغییر حساب","", Icons.edit, (){})),
      body: SingleChildScrollView(
        child: Stack(
          children: [

            Column(
              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(backgroundColor: Colors.teal,child: IconButton(
                        icon: Icon(Icons.search,color: Colors.white,),
                        onPressed: () {
                          if (_key1.currentState!.value.toString().length > 1) {
                            loading = true;
                            setState(() {});
                            i = 0;
                            _getOldInfo();
                          } else
                            Comp.showSnackError(context);
                        }),),
                    Container(width: size.width * .75,child: Comp.editBox1(context, 2,0,"ترمینال", Icons.title, _key1, "")),

                  ],
                ),
                Visibility(
                  child: Column(
                    children: [
                      Center( child: Padding(child: Text("اطلاعات فعلی",style:
                  TextStyle(fontSize: 18, color: Colors.teal,decoration: TextDecoration.underline )),padding: EdgeInsets.only(top: 10),
                          ),
                      ),
                      Comp.editBox3(context, "نام پذیرنده", Icons.person_outline, name),
                      Comp.editBox3(context, "نام بانک", Icons.location_city, bank),
                      Comp.editBox3(context, "شعبه", Icons.store,  shobe),
                      Comp.editBox3(context, "شماره حساب", Icons.drive_file_rename_outline,  hesab),
                      Comp.editBox3(context, "شماره شبا", Icons.monetization_on,  sheba),
                      Comp.editBox3(context, "سند", Icons.adjust_outlined, sanad),

                      Center(
                        child:
                        Padding(
                          child: Text("اطلاعات جدید",style:
                          TextStyle(fontSize: 18, color: Colors.teal,decoration: TextDecoration.underline )),padding: EdgeInsets.only(top: 10),
                        ),
///92988177

                      ),

                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                             // initialValue: _bank_Value,
                              controller: _controller2,
                              enabled: false,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,

                                prefixIcon: Icon(
                                  Icons.location_city,
                                  color: Colors.black,
                                ),

                                labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                                labelText: "بانک",
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
                                  items:_bankValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                                  onChanged: (newVal) {
                                    _bank_Value = newVal!;
                                    _key2 = newVal;
                                    _shobe_Value = "شعبه";
                                    _key3 ="";
                                    getShobeList(_bank_Value);
                                    _controller3 = TextEditingController(text: "");
                                    _controller2 = TextEditingController(text: _bank_Value);
                                    setState(() {});
                                  }))
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              //initialValue: _shobe_Value,
                              controller: _controller3,
                              enabled: false,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,

                                prefixIcon: Icon(
                                  Icons.store,
                                  color: Colors.black,
                                ),
                                labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                                labelText: "شعبه",
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
                                  items:_shobeValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                                  onChanged: (newVal) {
                                    _shobe_Value = newVal!;
                                    _key3 = newVal;
                                    _controller3 = TextEditingController(text: _shobe_Value);
                                    setState(() {});
                                  }))
                        ],
                      ),

                      Comp.editBox1(context,0,0, "شماره حساب", Icons.drive_file_rename_outline,_key4, ""),
                      Comp.editBox1(context,0,24, "شماره شبا", Icons.monetization_on,_key5, ""),

                      Comp.fullBtn(size, "ثبت تغییرات", Icons.drive_file_rename_outline, fun),
                      SizedBox(height: 20,)

                    ],
                  ),
                  visible: hesab.length > 1 ? true : false,
                ),

              ],
            ),
            loading == true ?
            Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
      ),
    );
  }

  void fun(){
    if (_key1.currentState!.value.length > 1 &&
        _key2.length > 1 &&
        _key3.length > 1 &&
        _key4.currentState!.value.length >1 &&
        _key5.currentState!.value.length == 24

       )
      sendNewInfo();
    else Comp.showSnackError(context);
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
                      child: Text('درخواست تغییر مشخصات با موفقیت ثبت شد.\n منتظر تایید کارشناسان ما باشید.'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: editedReqChange_page(widget._data))));
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

  void dialogError(BuildContext context) {
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
                      child: Text('امکان تغییر مشخصات حساب برای سوئیچ ایران کیش امکان پذیر نمی باشد.'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: editedReqChange_page(widget._data))));
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

}
