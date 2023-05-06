
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/senfModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos33.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class register_pos_page22 extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  register_pos_page22(this._Agentdata);
  @override
  State<StatefulWidget> createState() => register_pos_pageState22();

}

class register_pos_pageState22 extends State<register_pos_page22> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key9 = GlobalKey<FormFieldState>();
  final _key10 = GlobalKey<FormFieldState>();
  String _key11 = "";
  String _key12 = "";
  List<String> _Senf = [];
  List<String> _SenfT = [];
  String _Senff = "صنف";
  String _SenfTt = "صنف تکمیلی";
  List<SenfModel> _data1 = [];
  List<SenfModel> _data2 = [];
  bool loading = false;
  late TextEditingController _controller1 = TextEditingController(text: "صنف");
  late TextEditingController _controller2 = TextEditingController(text: "صنف تکمیلی");

  void getSenfList() async {
    Map response = await OnlineServices.getSenfList();
    _data1.clear();
    _Senf.clear();
    _data1.addAll(response['data']);

    for (int i = 0; i < _data1.length; i++) {
      _Senf.add(_data1[i].senfName);
    }
    setState(() {});
  }

  void getSenfTList() async {
    Map response = await OnlineServices.getSenfTList(
        {"senf": _Senff}
    );
    _data2.clear();
    _SenfT.clear();
    _data2.addAll(response['data']);

    for (int i = 0; i < _data2.length; i++) {
      _SenfT.add(_data2[i].senfName);
    }
    setState(() {});
  }

  setPrefs(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString(key, value);
    //  print("seted: " + prefs.getString( key ));
  }

  resetPrefs(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
    await prefs.setString(key, value);
    //  print("seted: " + prefs.getString( key ));
  }


  @override
  void initState() {
    getSenfList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var blockSize = size.width / 100;
    Color cl = Color(0xff000000);

    return
      Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات شرکت","", Icons.edit, (){})),

        key: _scaffoldKey,
        backgroundColor: Theme
            .of(context)
            .primaryColor,
        resizeToAvoidBottomInset: true,
        body: Container(
          margin: EdgeInsets.only(top: 20),
          height: size.height,
          // color: Colors.white,
          child:
          ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Comp.editBox1(context,1,0,"نام فروشگاه فارسی", Icons.store, _key9, ""),
              Comp.editBox1(context,1,0, "نام فروشگاه انگلیسی", Icons.store, _key10, ""),
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
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                    width: size.width,
                    padding: EdgeInsets.only(right: 60,left: 20),
                    child:  SearchableDropdown.single(
                      style: TextStyle(color: Color(0x00000000)),
                      items: _Senf.map((String val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                        );
                      }).toList(),
                      underline: Container(),
                      // value: ,
                      searchHint: "انتخاب صنف",
                      onChanged: (value) {
                        _Senff = value;
                        setPrefs("key11" , value );
                        _SenfTt = "صنف تکمیلی";
                        _SenfT.clear();
                        _controller1 = TextEditingController(text: _Senff);
                        getSenfTList();
                        _key11 = value;
                        //_key12 = "*";
                        setState(() {
                          //setPrefs("key12" , "*" );
                          loading = true;
                        });
                      },
                      isExpanded: true,
                    ),),
                ],
              ),
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
                          Icons.storefront,
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "صنف تکمیلی",
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
                          items:_SenfT.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _SenfTt = newVal!;
                            _key12 = newVal;
                            _controller2 = TextEditingController(text: _SenfTt);
                            setState(() {});
                          }))
                ],
              ),
              SizedBox(height: 20,),
              Center(child: Text(
                "صفحه 2 از 4", style: TextStyle(fontSize: 17),),),
              Comp.fullBtn(size, "مرحله بعد",Icons.arrow_back ,fun ),


            ],
          ),
        ),
      );
  }

  void fun() {
    {
      //  print("----b" + _key9.currentState!.value.toString());
      if (_key9.currentState!.value
          .toString()
          .length > 0 &&
          _key10.currentState!.value
              .toString()
              .length > 0 &&
          _key11.length > 2 &&
          _key12.length > 2
      ) {
        setPrefs("key9", _key9.currentState!.value.toString());
        setPrefs("key10", _key10.currentState!.value.toString());
        setPrefs("key11", _key11.toString());
        setPrefs("key12", _key12.toString());
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
        Directionality(textDirection: TextDirection.rtl, child:
        register_pos_page33(widget._Agentdata))));
      }
      else {
        Comp.showSnackError(context);
  }
  }

  }
}


// Stack(
//   alignment: Alignment.center,
//   children: <Widget>[
//     Container(
//       padding: EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//           color: Color(0x22000000),
//           borderRadius: BorderRadius.all(Radius.circular(17))
//       ),
//       margin: const EdgeInsets.only(right: 35, left: 35, bottom:6),
//       child: TextFormField(
//         enabled: false,
//         obscureText: false,
//         decoration: InputDecoration(
//             icon: Icon( Icons.filter_list ,
//               color: Colors.black,),
//         ),
//       ),
//     ),
//     Container(
//         alignment: Alignment.center,
//         margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
//         width: size.width,
//         padding: EdgeInsets.only(right: 20,left: 12),
//         child: DropdownButton<String>(
//             items:_guildValue1.map((String val) {
//               return DropdownMenuItem<String>(
//                 value: val,
//                 child: Text(val),
//               );
//             }).toList(),
//             hint: Text(_guild_Value1),
//             onChanged: (newVal) {
//               _guild_Value1 = newVal;
//               _key11 = newVal;
//               setState(() {});
//             }))
//   ],
// ),
// Stack(
//   alignment: Alignment.center,
//   children: <Widget>[
//     Container(
//       padding: EdgeInsets.only(right: 10),
//       decoration: BoxDecoration(
//           color: Color(0x22000000),
//           borderRadius: BorderRadius.all(Radius.circular(17))
//       ),
//       margin: const EdgeInsets.only(right: 35, left: 35, bottom:6),
//       child: TextFormField(
//         enabled: false,
//         obscureText: false,
//         decoration: InputDecoration(
//             icon: Icon( Icons.filter_list ,
//               color: Colors.black,),
//         ),
//       ),
//     ),
//     Container(
//         alignment: Alignment.center,
//         margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
//         width: size.width,
//         padding: EdgeInsets.only(right: 20,left: 12),
//         child: DropdownButton<String>(
//             items:_guildValue2.map((String val) {
//               return DropdownMenuItem<String>(
//                 value: val,
//                 child: Text(val),
//               );
//             }).toList(),
//             hint: Text(_guild_Value2),
//             onChanged: (newVal) {
//               _guild_Value2 = newVal;
//               _key12 = newVal;
//               setState(() {});
//             }))
//   ],
// ),
