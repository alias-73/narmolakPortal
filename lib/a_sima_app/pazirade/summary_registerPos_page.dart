// ignore_for_file: unnecessary_statements, await_only_futures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/Moaref/new_moaref.dart';
import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos1.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';

import '../appbar_home.dart';
import '../components/Styles.dart';



class summary_registerPos extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  summary_registerPos(this._Agentdata);
  @override
  State<StatefulWidget> createState() => summary_registerPosState();
}

class summary_registerPosState extends State<summary_registerPos> {
  String _key1 = "";String _key2 = "";String _key3 = "";String _key4 = "";String _key5 = "";String _key6 = "";String _key7 = "";String _key8 = "";String _key9 = "";String _key10 = "";String _key11 = "";String _key12 = "";String _key13 = "";String _key14 = "";String _key15 = "";String _key16 = "";String _key17 = "";String _key18 = "";String _key19 = "";String _key20 = "";String _key21 = "";String _key22 = "";String _key23 = "";String _key24 = "";String _key25 = "";String _key26 = "";String _key27 = "";String _key28 = "";String _key29 = "";String _key30 = "";String _key31 = "";

  Color bcTextColor = Color(0x22000000);
  Color textColor = Color(0xbb000000);
  late String Access ;
  bool showLoading = false;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(child: Scaffold(
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
                          color: Color(0xff000000),fontSize: 20,
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
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام پذیرنده فارسی",ic: Icons.person_outline,Key: "key1"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام خانوادگی پذیرنده فارسی",ic: Icons.person_outline,Key: "key2"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام پذیرنده انگلیسی", ic: Icons.person_pin,Key: "key3"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام خانوادگی پذیرنده انگلیسی", ic: Icons.person_pin,Key: "key4"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام پدر فارسی", ic: Icons.account_box,Key: "key5"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام پدر انگلیسی", ic: Icons.account_box,Key: "key6"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "شماره شناسنامه", ic: Icons.card_membership,Key: "key7"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "کد ملی", ic: Icons.card_membership,Key: "key8"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "تاریخ تولد", ic: Icons.cake,Key: "key11"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "جنسیت", ic: Icons.wc,Key: "key10"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "ملیت", ic: Icons.flag_outlined,Key: "key9"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام فروشگاه فارسی", ic: Icons.store,Key: "key12"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "نام فروشگاه انگلیسی", ic: Icons.store,Key: "key13"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "صنف", ic: Icons.storefront,Key: "key14"),
                      summaryForm(color: Color(0xcc859dff),txtTitle: "صنف تکمیلی", ic: Icons.line_weight,Key: "key15"),
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
                          color: Color(0xff000000),fontSize: 20,
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
                      //summaryForm(color: Color(0xcc18c440),txtTitle: "کشور", ic: Icons.map,Key: "key13"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "استان", ic: Icons.location_city,Key: "key16"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "شهر", ic: Icons.location_city,Key: "key17"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "کد پستی", ic: Icons.code,Key: "key18"),
                      summaryForm(color: Color(0xcc18c440),txtTitle: "آدرس فارسی", ic: Icons.location_on,Key: "key19"),

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
                          color: Color(0xff000000),fontSize: 20,
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
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "کد شهر", ic: Icons.phone,Key: "key21"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "تلفن", ic: Icons.phone,Key: "key22"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "پیش شماره", ic: Icons.phone_iphone,Key: "key23"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "موبایل", ic: Icons.phone_iphone,Key: "key24"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "سوئیچ", ic: Icons.apps,Key: "key26"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "کد اقتصادی", ic: Icons.drive_file_rename_outline,Key: "key25"),
                      summaryForm(color: Color(0xaa8285ba),txtTitle: "نوع دستگاه", ic: Icons.edit,Key: "key27"),
                    ],
                  ),
                ),
                SizedBox(height: 12,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //   GestureDetector( child:
                    Flexible(child: ElevatedButton(onPressed: (){
                      showLoading = true;
                      setState(() {});
                      sendDataForPazirande();
                      // _showDialog(context);
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
                  ],
                ),
                SizedBox(height: 13,),

              ],
            ),
          ),
          showLoading ? Comp.showLoading(size.height , size.width) : Center()
        ],
      ),
    ));
  }
  Future<String> sendDataForPazirande() async {
    late String today = "";
  late String datetime = "";

    SharedPreferences prefs = await SharedPreferences.getInstance();
    {_key1 =await prefs.getString("key1".trim())!;
    _key2 =await prefs.getString("key2".trim())!;
    _key3 =await prefs.getString("key3".trim())!;
    _key4 =await prefs.getString("key4".trim())!;
    _key5 =await prefs.getString("key5".trim())!;
    _key6 =await prefs.getString("key6".trim())!;
    _key7 =await prefs.getString("key7".trim())!;
    _key8 =await prefs.getString("key8".trim())!;
    _key9 =await prefs.getString("key9".trim())!;
    _key10 =await prefs.getString("key10".trim())!;
    _key11 =await prefs.getString("key11".trim())!;
    _key12 =await prefs.getString("key12".trim())!;
    _key13 =await prefs.getString("key13".trim())!;
    _key14 =await prefs.getString("key14".trim())!;
    _key15 =await prefs.getString("key15".trim())!;
    _key16 =await prefs.getString("key16".trim())!;
    _key17 =await prefs.getString("key17".trim())!;
    _key18 =await prefs.getString("key18".trim())!;
    _key19 =await prefs.getString("key19".trim())!;
    _key20 =await prefs.getString("key20".trim())!;
    _key21 =await prefs.getString("key21".trim())!;
    _key22 =await prefs.getString("key22".trim())!;
    _key23 =await prefs.getString("key23".trim())!;
    _key24 =await prefs.getString("key24".trim())!;
    _key25 =await prefs.getString("key25".trim())!;
    _key26 =await prefs.getString("key26".trim())!;
    _key27 =await prefs.getString("key27".trim())!;
    _key28 =await prefs.getString("key28".trim())!;
    _key29 =await prefs.getString("key29".trim())!;
    _key30 =await prefs.getString("key30".trim())!;
    _key31 =await prefs.getString("key31".trim())!;
    }
    String response;
     response = await (OnlineServices()).sendDataForSabtPazirande(
        {"agentcode" : widget._Agentdata.last.agentCode ,
          "namepazirandefa": _key1 + " " + _key2  ,
          "namepazirandeen": _key3.replaceAll(RegExp(r'[^\w\s]+'),'') +" " + _key4.replaceAll(RegExp(r'[^\w\s]+'),''),
          "namepedar": _key5 ,
          "namepedaren": _key6.replaceAll(RegExp(r'[^\w\s]+'),'') ,
          "namefirstfa": _key1,
          "namelastfa": _key2,
          "namefirsten": _key3.replaceAll(RegExp(r'[^\w\s]+'),''),
          "namelasten": _key4.replaceAll(RegExp(r'[^\w\s]+'),''),
          "shenasname": _key7 ,
          "codemel": _key8 ,
          "meliat": _key9 ,
          "gensiat": _key10 ,
          "tavlod": _key11.replaceAll("-" , "/") ,
          "nameforoshgahfa": _key12 ,
          "nameforoshgahen": _key13.replaceAll(RegExp(r'[^\w\s]+'),'') ,
          "senf": _key14 ,
          "senfakmili": _key15 ,
          "ostan": _key16 ,
          "shahr": _key17 ,
          "codeposti": _key18 ,
          "addressfa": _key19 ,
          "keshvar": "ایران" ,
          "tellpish": _key21,
          "tell": _key22 ,
          "mobilepish": _key23,
          "mobile": _key24 ,
          "soeich": _key26 ,
          "eqtesadi": _key25 ,
          "noe": _key27 ,
          "usercode" : widget._Agentdata.last.userCode,
          "tarikh": today,
          "saat": datetime,
          "mojavez": _key29,
          "dastgah": _key30+"-"+_key31,
        });
 //  print(response);
    if (response== "ok")
    {
      setState(() {showLoading =false;   });
      _showDialog("پذیرنده جدید با موفقیت ثبت شد");
  //    print("alisssssssssssssssssssssssssss");
    }
    else{
      setState(() {showLoading =false;   });
      _showDialog2("خطا در ثبت اطلاعات، لطفا مجددا گزینه ثبت نهایی را انتخاب کنید");
    }
return "";
    }

  void _showDialog(String txt) {
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
                      child:  Text( txt))
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
                Navigator.pop(context);

              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));
              },
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
  void _showDialog2(String txt) {
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
                      child:  Text( txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
              //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));
              },
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
