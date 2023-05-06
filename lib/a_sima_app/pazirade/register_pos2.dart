
// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/rasteModel.dart';
import 'package:sima_portal/a_sima_app/models/senfModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos1.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos3.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class register_pos_page2 extends StatefulWidget {
  String melli ;
  String tavalod ;
  String name ;
  List<AgentModel> _Agentdata = [];
  register_pos_page2(this._Agentdata,this.melli,this.tavalod,this.name);
  @override
  State<StatefulWidget> createState() => register_pos_pageState2();

}

class register_pos_pageState2 extends State<register_pos_page2> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key12 = GlobalKey<FormFieldState>();
  final _key13 = GlobalKey<FormFieldState>();
  String _key14 = "";
  String _key29 = "";
  bool isAllow2 = false;
  bool isAllow3 = false;
  String _key15 = "";
  List<String> _Noe = ["پروانه کسب" , "استشهاد"];
  List<String> _Senf = [];
  List<String> _SenfT = [];
  String _Noee = "نوع";
  String _Senff = "صنف";
  String _SenfTt = "صنف تکمیلی";
  List<SenfModel> _data1 = [];
  List<SenfModel> _data2 = [];
  List<RasteModel> _data3 = [];
  late List<String> _data4;
  late List<String> ss = [];
  bool loading = false;
  bool isallow = false;
 late TextEditingController _controller1 = TextEditingController(text: "صنف");
 late TextEditingController _controller2 = TextEditingController(text: "نوع");

  void getSenfList2(int type) async {
     isallow = true;
    Map response = {};
    type == 1 ? response = await OnlineServices.getSenfListEsteshhad() : type == 2 ? response = await OnlineServices.getSenfListMojavez() : null;
    ss.clear();
    for (int i = 0 ; i < response["data"].length ; i++)
      {
        ss.contains(response["data"][i]["name"] + "##") ? null : ss.add(response["data"][i]["name"] + "##" );
        ss.add(response["data"][i]["name"] + "*" + response["data"][i]["raste"]);
      }
    isallow == false ? ss.clear() : null;

    setState(() {});

  }

  // void getSenfList() async {
  //   Map response = await OnlineServices.getSenfList();
  //   _data1.clear();
  //   _Senf.clear();
  //   _data1.addAll(response['data']);
  //
  //   for (int i = 0 ; i< _data1.length ; i++)
  //   {
  //     _Senf.add(_data1[i].senfName);
  //   }
  //   setState(() {
  //   });
  //
  // }


  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString( key , value);
  //  print("seted: " + prefs.getString( key ));
  }

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color cl = Color(0xff000000);
    return
      Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات فروشگاه","", Icons.edit, (){})),

        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:Container(
          margin: EdgeInsets.only(top: 20),
          height: size.height,
          // color: Colors.white,
          child:
          ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Comp.editBox1(context,1,25, "نام فروشگاه فارسی", Icons.store, _key12, ""),
              Comp.editBox1(context,1,25, "نام فروشگاه انگلیسی", Icons.store, _key13, ""),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      // initialValue: _device_Type,
                      controller: _controller2,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        prefixIcon: Icon(Icons.note_add,color: Colors.black,),

                        // prefixIcon: Icon(Icons.device_hub, color: Colors.black,),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "نوع مجوز",
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
                          items:_Noe.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _Noee = newVal!;
                            _key29 = newVal;

                            _controller2 = TextEditingController(text: _Noee);
                            // getSenfList (_Noee);
                            getSenfList2(_Noee == "استشهاد" ? 1 : _Noee == "پروانه کسب" ? 2 : 0);
                            setState(() {});
                          }))
                ],
              ),

              SizedBox(height: 5,),
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
                        isAllow2 = false;
                        isAllow3 = false;
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
                          checkSenf(_key14.split("-")[0]);

                        }
                      },
                      isExpanded: true,
                    ),),

                ],
              ),

              isAllow3 ? Column(
                children: [Icon( Icons.warning_amber,color: Colors.red,size:70 ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Column(
                    children: [
                      Text("در صورت انتخاب این صنف،",
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,),
                      Text("فرم استشهاد",
                        style: TextStyle(decoration: TextDecoration.underline ,fontSize: 26,fontWeight: FontWeight.w700,color: Colors.red),textAlign: TextAlign.center,),
                      Text("مورد قبول نخواهد بود.",
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,)
                    ],
                  ),)
                ],
              ):Center(),

               SizedBox(height: 20,),
               Center(child:Text("صفحه 2 از 4",style: TextStyle(fontSize: 17),),),
                Stack(children: [
                  Comp.fullBtn(size, "مرحله بعد",Icons.arrow_back ,fun ),
                  isAllow2 == true ? Center() :Container(width: size.width,height: 70,color: Color(0x64ffffff),)
                ]),
            ],
          ),
        ),
      );
  }

  void fun(){
    if (_key12.currentState?.value.length > 1 &&
        _key13.currentState?.value.length > 1 &&
        _key13.currentState?.value.length > 1 &&
        _key14.length > 2 &&
        _key15.length > 2
        //&& response2 == "allow"
    )
    {
      setPrefs("key12" , _key12.currentState!.value.toString().trim() );
      setPrefs("key13" , _key13.currentState!.value.toString().trim() );
      setPrefs("key14" , _key14.toString() );
      setPrefs("key15" , _key15.toString() );
      setPrefs("key29" , _key29.toString() );
      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
         register_pos_page3(widget._Agentdata,widget.melli,widget.tavalod,_key12.currentState!.value.toString().trim(),widget.name))));
     }
    else
    {
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
    }
  }
///دردسرت ندم
  void checkSenf(String split) async {
    String response = await (OnlineServices()).checkSenf(
        {  "code" : split });
    if(response == "yes")
      {
        isAllow2=true;
        isAllow3=true;
      }
    else if(response == "no")
      {
        isAllow2=true;
      }
    setState(() {});
    // print(response);
  }
}
