
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

class device_register_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  device_register_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => device_register_pageState();

}

class device_register_pageState extends State<device_register_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  late TextEditingController _controller1 = TextEditingController(text: "برند");
  late TextEditingController _controller2 = TextEditingController(text: "مدل");
  late TextEditingController _controller3 = TextEditingController(text: "سوئیچ");
  late TextEditingController _controller4 = TextEditingController(text: "");

  bool enableSerial = false;

  List<String> _brandvalue = [];
  List<String> _modelvalue = [];
  List<String> _soeichvalue = [];
  String _brand_value = "برند";
  String _soeich_value = "سوئیچ";
  String _model_value = "مدل";
  List<BrandModel> _data2 = [];
  List<BrandModelModel> _data1 = [];
  List<SoeichModel> _data3 = [];
  final _key2 = GlobalKey<FormFieldState>();
  String PSP = "-";
  String _key3 = "";
  String _key4 = "";
  String _key5 = "";
  bool loading = false;
  late String today = "";
  late String datetime = "";
  @override
  void initState() {
    // getBrandList();
    getSoeichList();
    super.initState();
  }
  void getSoeichList() async {
    Map response = await OnlineServices.getSoeichList({"agentcode":widget._Agentdata.last.agentCode});
    _data3.clear();
    _soeichvalue.clear();
    _data3.addAll(response['data']);
    // print(_data1);

    for (int i = 0 ; i< _data3.length ; i++)
    {
      _soeichvalue.add(_data3[i].soeich_no);
    }
    setState(() {
    });

  }
  void getBrandList() async {
    Map response = await OnlineServices.getBrandList2({"psp":_soeich_value});
    _data2.clear();
    _modelvalue.clear();
    _data2.addAll(response['data']);

    for (int i = 0 ; i< _data2.length ; i++)
    {
      _brandvalue.add(_data2[i].brandName);
    }
    setState(() {
    });

  }
  void getModelList(String v) async {
   // print("*" + v + "*");
    Map response = await OnlineServices.getBrandModelList2(
        {"brand" : v ,"psp" : _soeich_value}
    );
  //  print (response);
    _data1.clear();
    _modelvalue.clear();
    _data1.addAll(response['data']);

    for (int i = 0 ; i< _data1.length ; i++)
    {
      _modelvalue.add(_data1[i].modelName);
    }
    setState(() {
    });

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var maskFormatter = new MaskTextInputFormatter(
     // formatter: MaskTextInputFormatter(mask: "###-###-###"),

    );
    var blockSize = size.width / 100;
    String edt = "";
    Color cl = Colors.black;

    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ورود دستگاه به انبار","", Icons.edit, (){})),

      body:Stack(
          children: [
      Container(
        margin: EdgeInsets.only(top: 20),
        height: size.height,
        // color: Colors.white,
        child:
        ListView(
        //  mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
           Container(height:  size.height * .3, width: size.width ,child:  FutureBuilder<String>(
              future: getImg(),
              builder:
                  (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return
                    CachedNetworkImage(
                      imageUrl: snapshot.data!.toString(),
                      placeholder: (context, url) =>
                          Image.asset("assets/images/pos3.png"),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/pos3.png"),
                    );
                } else if (snapshot.hasError) {
                  return Container();
                } else
                  return Container();
              },
            )),
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

                      prefixIcon:
                      _controller3.text.contains("پرداخت نوین") ? Image.asset("assets/images/novin.png",height: 60,width: 60,) :
                      _controller3.text.contains("سپهر") ? Image.asset("assets/images/sepehr.png",height: 60,width: 60,) :
                      _controller3.text.contains("سداد") ? Image.asset("assets/images/sadad.png",height: 60,width: 60,) :
                      _controller3.text.contains("پرداخت") ? Image.asset("assets/images/behpardakht.png",height: 60,width: 60,) :
                      _controller3.text.contains("پاسارگاد") ? Image.asset("assets/images/pasargad.png",height: 60,width: 60,) :
                      _controller3.text.contains("ایران") ? Image.asset("assets/images/irankish.png",height: 60,width: 60,) :
                      Icon(Icons.account_tree_outlined,color: Colors.black),
                      labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: cl)),
                      labelText: "سوئیچ",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: cl)),
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
                        items: _soeichvalue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                        onChanged: (newVal) {
                          _soeich_value = newVal!;
                          _data2.clear();
                          _brandvalue.clear();
                          _modelvalue.clear();
                          getBrandList();
                          _key5 = newVal;
                          _controller3 = TextEditingController(text: _soeich_value);
                          setState(() {});
                        }))
              ],
            ),

            _data2.isNotEmpty ? Stack(
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
                        Icons.device_hub,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: cl)),
                      labelText: "برند",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: cl)),
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
                        items:_brandvalue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                        onChanged: (newVal) {
                          _brand_value = newVal!;
                          _key3 = newVal;
                           _model_value = "-";
                          _controller1 = TextEditingController(text: _brand_value);
                          _controller2 = TextEditingController(text: _model_value);
                          _controller4 = TextEditingController(text: "");
                          enableSerial = true;
                          getModelList(newVal) ;
                          setState(() {});
                        }))
              ],
            ): Center(),
            _data2.isNotEmpty ? Stack(
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
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: cl)),
                      labelText: "مدل",
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: cl)),
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
                        items:_modelvalue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                        onChanged: (newVal) {
                          _model_value = newVal!;
                          _key4 = newVal;
                          _controller2 = TextEditingController(text: _model_value);
                          setState(() {});
                        }))
              ],
            ): Center(),
            _data2.isNotEmpty ? Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 13),
              child: TextFormField(
                inputFormatters:_brand_value.contains("Verifon") ? [MaskTextInputFormatter(mask: "###-###-###")] : null,
                textInputAction: TextInputAction.next,
                controller: _controller4,
                enabled: enableSerial,

                keyboardType: TextInputType.text,
                cursorColor: cl,
                textAlign: TextAlign.center,
                key: _key2,
                style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.drive_file_rename_outline,
                    color: cl,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: cl,
                      width: 1.0,
                    ),
                  ),
                  fillColor: cl,
                  focusColor: cl,
                  hoverColor: cl,
contentPadding: EdgeInsets.zero,
                  //errorText: _errorText1,
                  labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: cl)),

                  labelText: "سریال",
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  // errorText: 'Error message',
                  border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                ),
              ),
            ): Center(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Comp.miniBtn1(context ,size, "ثبت اطلاعات", Colors.teal , fun , 1),
                Comp.miniBtn1(context , size, "انصراف", Colors.red , (){} , 2),

              ],
            ),

          ],
        ),
      ),
            loading == true ?
            Comp.showLoading(size.height , size.width) : Center()
          ]),
    );
  }

  Future<String> getImg() async {
    String response = await OnlineServices.getDeviceImg({
      "brand": _brand_value,
      "model": _model_value
    });
    //print (await response);
    return response;
  }
  void fun2(String newVal){

  }

  void fun(){
    bool isVerifoneTrue = true;
    if( _brand_value.contains("Verifon") && _key2.currentState!.value.toString().length != 11 )
      isVerifoneTrue = false;

    if (
        _key3.length > 2 &&
        _key5.length > 2 &&
        _key4.length > 0 &&
        isVerifoneTrue
    )
    {
      checkSerial();
      loading = true;
      setState(() {});}
    else {
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");}
  }

  Widget imgDevice (String img){
    var size = MediaQuery.of(context).size;
    return Image(image: AssetImage(img),height: size.height * .3,);
  }

  void checkSerial() async {
    String response = await (OnlineServices()).checkSerial(
        {"serial": _key2.currentState!.value.toString().replaceAll(" ", "") , "soeich": _key5.toString()});

    if (response == "no")
  {
    //print("okkkkkkkkkkkkkkkkkkkkkkkk");
    sendDataForSave();
  loading = false;
  setState(() {});}

    //sendDataForSave();
    else if (response=="yes") {
      loading = false;
      setState(() {});
      Comp.showSnack(context, Icons.drive_file_rename_outline, "شماره سریال تکراری است");
    }
    else Comp.showSnack(context, Icons.warning_amber_rounded, "خطا");
  }

  void sendDataForSave() async {

    String response = await (OnlineServices()).deviceRegister(
        {"agentcode" : widget._Agentdata.last.agentCode , "brand": _key3.toString() , "model": _key4.toString() , "serial" : _controller4.value.text.toString(), "soeich": _key5.toString() ,"usercode" : widget._Agentdata.last.userCode, "tarikh": today, "saat": datetime });

    if (response=="ok")
    {
      loading = false;
      setState(() {});
      _showDialog(context);
    }
    else{
      print("errrror");
    }
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
                      child: Text('با موفقیت ثبت شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
//                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));

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