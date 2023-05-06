import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/Moaref/new_moaref.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos1.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';

import '../components/Styles.dart';


class summary_registerPosh extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  summary_registerPosh(this._Agentdata);
  @override
  State<StatefulWidget> createState() => summary_registerPosState();
}

class summary_registerPosState extends State<summary_registerPosh> {
  String _key1 = "";String _key2 = "";String _key3 = "";String _key4 = "";String _key5 = "";String _key9 = "";String _key10 = "";String _key11 = "";String _key12 = "";String _key13 = "";String _key14 = "";String _key15 = "";String _key16 = "";String _key17 = "";String _key19 = "";String _key20 = "";String _key21 = "";String _key22 = "";String _key23 = "";String _key27 = "";String _key28 = "";
  bool showLoading = false;

  Color bcTextColor = Color(0x22000000);
  Color textColor = Color(0xbb000000);

  Future<String> getPrefs(String key ) async {
    String value = "---";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value =await prefs.getString( key )!;
  //  print(await value);
    return "";
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize1 = blockSize * 1;
    double fontSize2 = blockSize * 2;
    double fontSize3 = blockSize * 3;
    double fontSize4 = blockSize * 4;
    double fontSize5 = blockSize * 5;
    double fontSize6 = blockSize * 6;
    double fontSize7 = blockSize * 7;
    double widthItem = size.width * .8;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            //width: size.width * .8,
            alignment: Alignment.center,
            child: ListView(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 7,bottom: 7),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xcc859dff),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      border: Border.all(color:  Color(0xcc859dff))
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.info_outline),
                      Padding(
                        child:  Text("مشخصات پذیرنده",style: TextStyle(
                          color: Color(0xff000000),fontSize: fontSize6,
                        )),padding: EdgeInsets.only(right: 10),
                      )
                    ],
                  ),
                ),
                Container(
                  //width: size.width * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      summaryForm(color: Color(0xcc859dff),txtTitle: "شناسه ملی",ic: Icons.drive_file_rename_outline,Key: "key1"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "تاریخ ثبت شرکت",ic: Icons.date_range_sharp,Key: "key2"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "شماره ثبت", ic: Icons.person_pin,Key: "key3"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام شرکت فارسی", ic: Icons.person_pin,Key: "key4"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام شرکت انگلیسی", ic: Icons.account_box,Key: "key5"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام فروشگاه فارسی", ic: Icons.store,Key: "key9"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام فروشگاه انگلیسی", ic: Icons.store,Key: "key10"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "صنف", ic: Icons.storefront,Key: "key11"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "صنف تکمیلی", ic: Icons.line_weight,Key: "key12"),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 7,bottom: 7),
                  margin: EdgeInsets.only(top: 13),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xcc18c440),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      border: Border.all(color:  Color(0xcc18c440))
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on),
                      Padding(
                        child:  Text("اطلاعات آدرس",style: TextStyle(
                          color: Color(0xff000000),fontSize: fontSize6,
                        )),padding: EdgeInsets.only(right: 10),
                      )

                    ],
                  ),
                ),
                Container(
                  //width: size.width * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      //  summaryForm(color: Color(0xcc18c440),txtTitle: "کشور", ic: Icons.flag_outlined,Key: "key13"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "استان", ic: Icons.location_city,Key: "key14"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "شهر", ic: Icons.location_city,Key: "key15"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "کد پستی", ic: Icons.code,Key: "key16"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "آدرس فارسی", ic: Icons.location_on,Key: "key17"),

                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 10,left: 10,top: 7,bottom: 7),
                  margin: EdgeInsets.only(top: 13),
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Color(0xcc8285ba),
                      borderRadius: BorderRadius.all(Radius.circular(0)),
                      border: Border.all(color:  Color(0xcc8285ba))
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.call),
                      Padding(
                        child:  Text("اطلاعات تماس",style: TextStyle(
                          color: Color(0xff000000),fontSize: fontSize6,
                        )),padding: EdgeInsets.only(right: 10),
                      )

                    ],
                  ),
                ),
                Container(
                  //width: size.width * .8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "تلفن", ic: Icons.phone,Key: "key27"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "تلفن", ic: Icons.phone,Key: "key19"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "موبایل", ic: Icons.phone_iphone,Key: "key28"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "موبایل", ic: Icons.phone_iphone,Key: "key20"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "سوئیچ", ic: Icons.apps,Key: "key21"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "کد اقتصادی", ic: Icons.code,Key: "key22"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "نوع دستگاه", ic: Icons.developer_board,Key: "key23"),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //   GestureDetector( child:
                    Flexible(child: ElevatedButton(onPressed: (){
                      setState(() {showLoading =true;   });
                      sendDataForPazirande();
                    },
                        child: Container(
                            padding: EdgeInsets.only(top: 7,bottom: 7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xaa00b831),
                              border: Border.all(width: 1,color: Color(0xff00b831),),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              //  border: Border(color: Colors.black, width: 1.0),
                            ),
                            //  color: Colors.lightBlueAccent,
                            width: size.width * .45,
                            child: Text("ثبت نهایی",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),)
                        ))),
                    Flexible(child: ElevatedButton(onPressed: (){
                      Navigator.pop(context); },
                        child: Container(
                            padding: EdgeInsets.only(top: 7,bottom: 7),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xaaff6e54),
                              border: Border.all(width: 1,color: Color(0xffff6e54),),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              //  border: Border(color: Colors.black, width: 1.0),
                            ),
                            //  color: Colors.lightBlueAccent,
                            width: size.width * .45,
                            child: Text("ویرایش اطلاعات",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),)
                        ))),

                  ],
                ),
                SizedBox(height: 13,),

              ],
            ),
          ),
          showLoading ? Comp.showLoading(size.height , size.width) : Center()
        ],
      ),
    );
  }
  Future<String> sendDataForPazirande() async {
    late String today = "";
  late String datetime = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    _key1 =await prefs.getString("key1".trim())!;
    _key2 =await prefs.getString("key2".trim())!;
    _key3 =await prefs.getString("key3".trim())!;
    _key4 =await prefs.getString("key4".trim())!;
    _key5 =await prefs.getString("key5".trim())!;
    _key9 =await prefs.getString("key9".trim())!;
    _key10 =await prefs.getString("key10".trim())!;
    _key11 =await prefs.getString("key11".trim())!;
    _key12 =await prefs.getString("key12".trim())!;
    _key13 =await prefs.getString("key13".trim())!;
    _key14 =await prefs.getString("key14".trim())!;
    _key15 =await prefs.getString("key15".trim())!;
    _key16 =await prefs.getString("key16".trim())!;
    _key17 =await prefs.getString("key17".trim())!;
    _key19 =await prefs.getString("key19".trim())!;
    _key20 =await prefs.getString("key20".trim())!;
    _key21 =await prefs.getString("key21".trim())!;
    _key22 =await prefs.getString("key22".trim())!;
    _key23 =await prefs.getString("key23".trim())!;
    _key27 =await prefs.getString("key27".trim())!;
    _key28 =await prefs.getString("key28".trim())!;

    String response = await (OnlineServices()).sendDataForSabtPazirandeH(
        {   "tarikh": today, "saat": datetime,"agentcode" : widget._Agentdata.last.agentCode , "shenasemeli": _key1  ,"sherkattarikh": _key2.replaceAll("-" , "/") ,"sherkatsabt": _key3 ,"sherkatnamefa": _key4 ,"sherkatnameen": _key5.replaceAll(RegExp(r'[^\w\s]+'),'') ,"nameforoshgahfa": _key9 ,"nameforoshgahen": _key10.replaceAll(RegExp(r'[^\w\s]+'),'') ,"senf": _key11 ,"senfakmili": _key12 ,"keshvar": "ایران" ,"ostan": _key14 ,"shahr": _key15 ,"codeposti": _key16 ,"addressfa": _key17 ,"tell": _key27 ,"mobile": _key28 ,"soeich": _key21,"eqtesadi": _key22 ,"noe": _key23 ,"tellpish": _key19,"mobilepish": _key20,"usercode" : widget._Agentdata.last.userCode });
   // print(response);
   // response="00";
    if (response== "ok")
    {
      setState(() {showLoading =false;   });
      _showDialog(context);

    }
    else{
     // print("errrror");
    }
return "";
    // return _news;
    // if (response.trim() != "0") {
    //   Navigator.pushReplacement(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(response))));
    // }
    // else{
    //   //_key2=""();
    //   showInSnackBar("نام کاربری یا کلمه عبور اشتباه است");
    // }
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
                      child:  Text( 'پذیرنده جدید با موفقیت ثبت شد\nبنا بر مقررات شرکت، ثبت معرف الزامی میباشد. در صورت عدم ثبت معرف، امکان ثبت شماره حساب وجود نخواهد داشت.' ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);   },
                  child: Text("    تایید    ",style: TextStyle(
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
