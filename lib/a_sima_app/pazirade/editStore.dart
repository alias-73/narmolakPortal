//
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';

import '../components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import '../models/senfModel.dart';
import 'EditedStore_page.dart';

class edit_store extends StatefulWidget {
  List<AgentModel> _data = [];

  edit_store(this._data);

  @override
  State<StatefulWidget> createState() => list_riz_pageState();
}

class list_riz_pageState extends State<edit_store> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  final _key8 = GlobalKey<FormFieldState>();
  late String today = "";
  late String datetime = "";
  bool btnEnable = false;
  int currentPageIndex = 0;
  late List<String> ss = [];

  int i = 0;
  bool isFree = false;
  late Map response;
  bool loading = false;
  String srch = "-";
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late String info;
  Color cl = Color(0xff000000);
  String _Senff = "صنف";
  String _key14 = "";
  String _key15 = "";
  String senf = "";
  String nameFa = "0";
  String nameEn="0";
  String telPish="0";
  String tell="0";
  String mobilePish="0";
  String mobile = "0";
  List<String> _Senf = [];
  List<String> _SenfT = [];
  bool isallow = false;
  List<SenfModel> _data1 = [];


  ///70278273
  late TextEditingController _controller1 = TextEditingController(text: "صنف");

  void getSenfList2() async {
    //await OnlineServices.check(1) == "111" ?
    // isallow = true : isallow = false;
    isallow = true;
    // print(isallow);
    Map response = await OnlineServices.getSenfList2();

    ss.clear();

    for (int i = 0 ; i < response["data"].length ; i++)
    {
      ss.contains(response["data"][i]["name"] + "##") ? null : ss.add(response["data"][i]["name"] + "##" );
      ss.add(response["data"][i]["name"] + "*" + response["data"][i]["raste"]);
    }
    isallow == false ? ss.clear() : null;

    setState(() {});
  }

  void getSenfList() async {
    Map response = await OnlineServices.getSenfList();
    _data1.clear();
    _Senf.clear();
    _data1.addAll(response['data']);

    for (int i = 0 ; i< _data1.length ; i++)
    {
      _Senf.add(_data1[i].senfName);
    }
    setState(() {
    });

  }

  void _getOldInfo() async {
    String response = await OnlineServices.getOldInfo({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "terminal": _key1.currentState!.value.toString()
      // "agentcode": "10035",
      // "usercode": "0",
      // "terminal": "91998693"
    });
    ///92847716
    //print(response);
    info = response;
    if(info.length < 10 ) {loading = false;  setState(() {
    });
    CoolAlert.show(
    context: context,
    type: CoolAlertType.warning,
    confirmBtnText: "بستن",
    onConfirmBtnTap: (){
    Navigator.pop(context);
    },
    title: "",
    backgroundColor: Colors.white,
    text: "اطلاعاتی یافت نشد"
    );
    }
    if (info.split(",")[3].length == 11) {
      telPish = info.split(",")[3].substring(0, info.split(",")[3].length - 8);
      tell = info.split(",")[3].substring(3, 11);
      mobilePish =
          info.split(",")[5].substring(0, info.split(",")[5].length - 7);
      mobile = info.split(",")[5].substring(4, 11);
    } else {
      telPish = info.split(",")[2];
      tell = info.split(",")[3];
      mobilePish = info.split(",")[4];
      mobile = info.split(",")[5];
    }
    senf = info.split(",").last;
    nameFa = info.split(",")[0];
    nameEn = info.split(",")[1];
    loading = false;
    setState(() {});

    if(info.split(",")[0].length > 1)
      {
        btnEnable = true;
        setState(() {});
      }
  }

  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString( key , value);
    //  print("seted: " + prefs.getString( key ));
  }

  void sendNewInfo() async {

    String response = await OnlineServices.sendNewInfo({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "tarikh": today,
      "terminal": _key1.currentState!.value.toString(),
      "foroshgahfaold": nameFa,
      "foroshgahfanew": _key2.currentState!.value.toString(),
      "foroshgahenold": nameEn,
      "foroshgahennew": _key3.currentState!.value.toString(),
      "tellpishold": telPish,
      "tellpishnew": _key5.currentState!.value.toString(),
      "tellold": tell,
      "tellnew": _key4.currentState!.value.toString(),
      "mobilepishold": mobilePish,
      "mobilepishnew": _key7.currentState!.value.toString(),
      "mobileold": mobile,
      "mobilenew": _key6.currentState!.value.toString(),
      "senfnew": _key14.isEmpty ? "بدون تغییر" : _key14.toString()+"-"+_key15.toString(),
    });
   // print(response);
    if(response == "ok")
      _showDialog(context);

    ///92799717
  }
  @override
  void initState() {
    getSenfList();
    getSenfList2();
    super.initState();
  }
  ///92799717
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight - 65;
    Color bcTextColor = Color(0x22000000);
    Color bcTextColor2 = Color(0x11000000);
    Color textColor = Color(0xbb000000);
    Color textColor2 = Color(0xff000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ویرایش فروشگاه","", Icons.edit, (){})),
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
                      Center(
                        child:
                          Padding(
                            child: Text("اطلاعات فعلی",style:
                  TextStyle(fontSize: 18, color: Colors.teal,decoration: TextDecoration.underline )),padding: EdgeInsets.only(top: 10),
                          ),


                      ),
                      Comp.editBox3(context, "نام قبلی فروشگاه فارسی", Icons.drive_file_rename_outline, nameFa),
                      Comp.editBox3(context, "نام قبلی فروشگاه انگلیسی", Icons.drive_file_rename_outline, nameEn),
                      Comp.editBox4(context, "پیش شماره","تلفن ثابت", Icons.phone,  tell, telPish),
                      Comp.editBox4(context, "پیش شماره","شماره همراه", Icons.phone_iphone,  mobile,mobilePish),
                      Comp.editBox3(context, "صنف قبلی فروشگاه", Icons.drive_file_rename_outline, senf),
                      Center(
                        child:
                        Padding(
                          child: Text("اطلاعات جدید",style:
                          TextStyle(fontSize: 18, color: Colors.teal,decoration: TextDecoration.underline )),padding: EdgeInsets.only(top: 10),
                        ),


                      ),
                      Comp.editBox1(context,1,0, "نام جدید فروشگاه فارسی", Icons.store,_key2, ""),

                      // Row(
                      //   children: [
                      //
                      //     Checkbox(value: true,   onChanged: (newValue) {
                      //       setState(() {
                      //
                      //       });
                      //     }, )
                      //   ],
                      // ),
                      Comp.editBox1(context,1,0, "نام جدید فروشگاه انگلیسی", Icons.store,_key3, ""),
                      Comp.editBox2(context,1,3,8, "پیش شماره","تلفن ثابت جدید", Icons.phone, _key5, _key4, ""),
                      Comp.editBox2(context,1,4,7, "پیش شماره","شماره همراه جدید", Icons.phone_iphone, _key7, _key6, ""),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            height: 110,
                            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              // initialValue: "_Senff",
                              controller: _controller1,
                              enabled: false,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,

                                prefixIcon: Icon(
                                  Icons.storefront_outlined,
                                  color: Colors.black,
                                ),

                                labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                                labelText: "صنف",
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                              ),
                            ),
                          ),
                          Container(
                            height: 110,
                            margin: EdgeInsets.only(right: 30, left: 30, bottom: 6),
                            width: size.width,
                            padding: EdgeInsets.only(right: 60,left: 20),
                            child:  SearchableDropdown.single(
                              style: TextStyle(color: Color(0x00000000)),
                              items: ss.map((String val) {
                                return DropdownMenuItem<String>(

                                  value: val,
                                  child:
                                  Container(
                                    alignment:val.contains("##") ? Alignment.topRight : Alignment.center,
                                    margin: EdgeInsets.zero,
                                    padding: EdgeInsets.all(5),
                                    child: Text( val.contains("##") ? val.toString().replaceAll("##", "") :  val.split("*")[1] , style: TextStyle(fontWeight: val.contains("##") ? FontWeight.w800 : FontWeight.w200),),
                                  )  ,
                                );
                              }).toList(),
                              underline: Container(),
                              // value: ,
                              searchHint: "انتخاب صنف",
                              onChanged: (value) {
                                _Senff = value.contains("##") ? "_ _ _" : value.split("*")[1];
                                if (value.toString().contains("##"))
                                {
                                  Comp.showSnack(context, Icons.warning_amber_rounded, "لطفا زیر دسته مورد نظر را انتخاب کنید");
                                }
                                else {
                                  setPrefs("key14" , value.split("*")[0] );
                                  _controller1 = TextEditingController(text: value.split("*")[1]);
                                  // print(value);
                                  _key14 = value.split("*")[0];
                                  _key15 = value.split("*")[1];

                                }
                              },
                              isExpanded: true,
                            ),),

                        ],
                      ),

                      Comp.fullBtn(size, "ثبت تغییرات", Icons.drive_file_rename_outline, fun),
                      SizedBox(height: 20,)

                    ],
                  ),
                  visible: mobile.length > 1 ? true : false,
                ),

              ],
            ),
            loading == true ? Comp.showLoading(size.height , size.width) : Center()

          ],
        ),
      ),
    );
  }

  void fun(){

    if (_key1.currentState!.value.length > 1 &&
        _key2.currentState!.value.length > 1 &&
        _key3.currentState!.value.length > 1 &&
        _key4.currentState!.value.length == 8 &&
        _key5.currentState!.value.length == 3 &&
        _key6.currentState!.value.length == 7 &&
        _key7.currentState!.value.length == 4)
      {
        loading = true;
        setState(() {});
        sendNewInfo();
      }
    else {
      loading = false;
      setState(() {});
      Comp.showSnackError(context);}
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: editedStore_page(widget._data))));
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
