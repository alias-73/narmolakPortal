
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;


import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/ostanModel.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos44.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class register_pos_page33 extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  register_pos_page33(this._Agentdata);
  @override
  State<StatefulWidget> createState() => register_pos_pageState();

}

class register_pos_pageState extends State<register_pos_page33> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key13 = GlobalKey<FormFieldState>();
  String _key14 = "";
  String _key15 = "";
  final _key16 = GlobalKey<FormFieldState>();
  final _key17 = GlobalKey<FormFieldState>();
  List<String> _Ostan = [];
  List<String> _Shahr = [];
  String _Shahrr = "شهرستان";
  String _Ostann = "استان";
  List<OstanModel> _data1 = [];
  List<OstanModel> _data2 = [];
  bool loading = false;
  late TextEditingController _controller1 = TextEditingController(text: "استان");
  late TextEditingController _controller2 = TextEditingController(text: "شهرستان");

  @override
  void initState() {
    getOstanList();
    super.initState();
  }
  void getOstanList() async {
    Map response = await OnlineServices.getOstanList();
    _data1.clear();
    _Ostan.clear();
    _data1.addAll(response['data']);

    for (int i = 0 ; i< _data1.length ; i++)
    {
      _Ostan.add(_data1[i].ostanName);
    }
    setState(() {
    });

  }
  void getShahrList() async {
    Map response = await OnlineServices.getShahrList(
        {"ostan" : _Ostann }
    );
    _data2.clear();
    _Shahr.clear();
    _data2.addAll(response['data']);

    for (int i = 0 ; i< _data2.length ; i++)
    {
      _Shahr.add(_data2[i].ostanName);
    }
    setState(() {
    });

  }

  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString( key , value);
   // print(prefs.getString( key ));
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    var size = MediaQuery.of(context).size;
    Color cl = Color(0xff000000);
    return
      Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات محلی","", Icons.edit, (){})),

        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:Container(
          margin: EdgeInsets.only(top: 20),
          height: size.height,
          // color: Colors.white,
          child:
          ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Comp.editBoxIran(context,2,2, "کشور", Icons.flag_outlined, _key13, "ایران"),
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
                          Icons.flag_outlined,
                          color: Colors.black,
                        ),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "استان",
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
                      child:
                      SearchableDropdown.single(
                        style: TextStyle(color: Color(0x00000000)),
                        items: _Ostan.map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        underline: Container(),
                        value: "value",
                        searchHint: "انتخاب استان",
                        onChanged: (value) {
                          _Ostann = value;
                          getShahrList();
                          _key14 = value;
                          setPrefs("key14" , value );
                          _controller2 = TextEditingController(text: "");
                          _key15 = "";

                          _controller1 = TextEditingController(text: _Ostann);
                          setState(() {
                            loading = true;
                          });
                        },
                        isExpanded: true,
                      ))

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
                          Icons.flag_outlined,
                          color: Colors.black,
                        ),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "شهر",
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
                      child:
                      SearchableDropdown.single(
                        style: TextStyle(color: Color(0x00000000)),
                        items: _Shahr.map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        underline: Container(),
                        onChanged: (value) {
                          _Shahrr = value;
                          _key15 = value;
                          setPrefs("key15" , value );
                          _controller2 = TextEditingController(text: _Shahrr);

                          setState(() {});
                        },
                        isExpanded: true,
                      )),

                ],
              ),
              Comp.editBox1(context,2,10, "کد پستی", Icons.store, _key16, ""),
              Comp.editBox1(context,1,0, "آدرس فارسی", Icons.store, _key17, ""),
              SizedBox(height: 20,),
              Center(child:Text("صفحه 3 از 4",style: TextStyle(fontSize: 17),),),
              Comp.fullBtn(size, "مرحله بعد",Icons.arrow_back ,fun ),


            ],
          ),
        ),
      );
  }
  void fun() {
    if (_key13.currentState!.value.length > 0 &&
        _key14.length > 1 &&
        _key15.length > 1 &&
        _key16.currentState!.value.toString().length == 10 &&
        _key17.currentState!.value.toString().length > 0)

    {
      // print("ok");
      setPrefs("key13" , _key13.toString() );
      setPrefs("key14" , _key14.toString() );
      setPrefs("key15" , _key15.toString() );
      setPrefs("key16" , _key16.currentState!.value.toString() );
      setPrefs("key17" , _key17.currentState!.value.toString() );
      //Navigator.pop(context);

      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
      register_pos_page44(widget._Agentdata))));
      //
    }
    else Comp.showSnackError(context);
    }
}


