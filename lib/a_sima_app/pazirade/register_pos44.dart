
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_pageH.dart';

class register_pos_page44 extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  register_pos_page44(this._Agentdata);
  @override
  State<StatefulWidget> createState() => register_pos_pageState();

}

class register_pos_pageState extends State<register_pos_page44> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key19 = GlobalKey<FormFieldState>();
  final _key20 = GlobalKey<FormFieldState>();
  String _key21 = "";
  final _key22 = GlobalKey<FormFieldState>();
  final _key27 = GlobalKey<FormFieldState>();
  final _key28 = GlobalKey<FormFieldState>();
  final _key29 = GlobalKey<FormFieldState>();
  String _key23 = "";
  List<String> _deviceType = ['Dialup' , 'GPRS' , 'LAN'];
  String _device_Type = "نوع دستگاه";
  List<String> _Soeich = [];
  String _Soeichh = "سوئیچ";
  List<SoeichModel> _data1 = [];
  late TextEditingController _controller2 = TextEditingController(text: "سوئیچ");
  late TextEditingController _controller3 = TextEditingController(text: "نوع دستگاه");
  void getSoeichList() async {
    Map response = await OnlineServices.getSoeichList({"agentcode":widget._Agentdata.last.agentCode});
    _data1.clear();
    _Soeich.clear();
    _data1.addAll(response['data']);
   // print(_data1);

    for (int i = 0 ; i< _data1.length ; i++)
    {
      _Soeich.add(_data1[i].soeich_no);
    }
    setState(() {
    });

  }
  void initState() {
    getSoeichList();
    super.initState();
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
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات تکمیلی","", Icons.edit, (){})),
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
              Comp.editBox2(context,2,3,8, "پیش شماره","تلفن ثابت", Icons.phone, _key19, _key27, ""),
              Comp.editBox2(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key20, _key28, ""),
              Comp.editBox1(context,2,12, "کد اقتصادی", Icons.drive_file_rename_outline, _key22, ""),
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
                          Icons.apps,
                          color: Colors.black,
                        ),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "سوئیچ",
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
                          items:_Soeich.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _Soeichh = newVal!;
                            getSoeichList();
                            _key21 = newVal;
                            _controller2 = TextEditingController(text: _Soeichh);

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
                      controller: _controller3,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        prefixIcon: Icon(
                          Icons.device_hub,
                          color: Colors.black,
                        ),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "نوع دستگاه",
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
                          items:_deviceType.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _device_Type = newVal!;
                            _key23 = newVal;
                            _controller3 = TextEditingController(text: _device_Type);

                            setState(() {});
                          }))
                ],
              ),

              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text("صفحه 4 از 4",style: TextStyle(fontSize: 17),),


                ],
              ),
              Comp.fullBtn(size, "ذخیره اطلاعات",Icons.save ,fun ),

            ],
          ),
        ),
      );
  }
  void fun(){
    if (
    _key27.currentState!.value.toString().length == 8 &&
        _key28.currentState!.value.toString().length == 7 &&
        _key19.currentState!.value.toString().length == 3 &&
        _key20.currentState!.value.toString().length == 4 &&
        _key21.length > 1 &&
        _key22.currentState!.value.toString().length > 1 &&
        _key23.length > 1
    )
    {
      //print("ok");
      setPrefs("key19" , _key19.currentState!.value.toString() );
      setPrefs("key20" , _key20.currentState!.value.toString() );
      setPrefs("key27" , _key27.currentState!.value.toString() );
      setPrefs("key28" , _key28.currentState!.value.toString() );
      setPrefs("key21" , _key21.toString() );
      setPrefs("key22" , _key22.currentState!.value.toString() );
      setPrefs("key23" , _key23.toString() );


      // Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
      summary_registerPosh(widget._Agentdata))));
    }
    else Comp.showSnackError(context);

  }
}
