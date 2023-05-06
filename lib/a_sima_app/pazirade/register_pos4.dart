
// ignore_for_file: unrelated_type_equality_checks, unused_local_variable
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Pazirade/summary_registerPos_page.dart';

import '../models/brandModel.dart';
import '../models/brandModelModel.dart';

class register_pos_page4 extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  String melli ;
  String name ;
  String tavalod ;
  String forushgah;
  String posti;
  register_pos_page4(this._Agentdata,this.melli,this.tavalod,this.forushgah,this.posti,this.name);
  @override
  State<StatefulWidget> createState() => register_pos_pageState();

}

class register_pos_pageState extends State<register_pos_page4> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key21 = GlobalKey<FormFieldState>();
  final _key22 = GlobalKey<FormFieldState>();
  final _key23 = GlobalKey<FormFieldState>();
  final _key24 = GlobalKey<FormFieldState>();
  final _key25 = GlobalKey<FormFieldState>();
  String _key26 = "";
  String _key27 = "";
  String _key30 = "";
  String _key31 = "";
  List<String> _deviceType = ['Dialup' , 'GPRS' , 'LAN'];
  String _device_Type = "نوع دستگاه";
  List<String> _Soeich = [];
  String _Soeichh = "سوئیچ";
  List<SoeichModel> _data1 = [];
  List<BrandModelModel> _data3 = [];

  String eqtesadi = "";
 TextEditingController? _controller ;
  late TextEditingController _controller2 = TextEditingController(text: "سوئیچ");
  late TextEditingController _controller3 = TextEditingController(text: "نوع دستگاه");
  late TextEditingController _controller4 = TextEditingController(text: "برند");
  late TextEditingController _controller5 = TextEditingController(text: "مدل");
  List<String> _brandvalue = [];
  List<String> _modelvalue = [];
  String _brand_value = "برند";
  String _model_value = "مدل";
  double balance = 0;
  late String today = "";
  late String datetime = "";
   int counter = 0;
 //  bool estelam_loading = false;
  List<BrandModel> _data2 = [];


  bool isLoadingMal = false;
  bool isLoadingEst = false;
  bool isLoadingSave = false;

  void getSoeichList() async {
    Map response = await OnlineServices.getSoeichList({"agentcode":widget._Agentdata.last.agentCode});
    _data1.clear();
    _Soeich.clear();
    _data1.addAll(response['data']);
    for (int i = 0 ; i< _data1.length ; i++) {_Soeich.add(_data1[i].soeich_no);}
    setState(() {});
  }

  void getBrandList() async {
    Map response = await OnlineServices.getBrandList();
    _data2.clear();
    _modelvalue.clear();
    _data2.addAll(response['data']);
    print("______________");
    print(_data2[0].brandName);

    for (int i = 0 ; i< _data2.length ; i++)
    {
      _brandvalue.add(_data2[i].brandName);
    }
    setState(() {
    });

  }
  void getModelList(String v) async {
    // print("*" + v + "*");
    Map response = await OnlineServices.getBrandModelList(
        {"brand" : v }
    );
    //  print (response);
    _data3.clear();
    _modelvalue.clear();
    _data3.addAll(response['data']);

    for (int i = 0 ; i< _data3.length ; i++)
    {
      _modelvalue.add(_data3[i].modelName);
    }
    setState(() {
    });

  }

  void initState() {
    getBalance();
    getBrandList();
    reduce_money(2);
    getSoeichList();
    super.initState();
  }

  void getBalance() async {
    String response = await OnlineServices.getBalance(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode
        });
    balance = double.parse(response);
   // balance = 500;
  }

  setPrefs(String key , String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString( key , value);
  }


  void reduce_money(int type) async {

    String datetime ="";
    type == 1 ? OnlineServices.reduce_money({"tarikh" : today.toString() , "saat" : datetime.toString() ,"agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode ,"name" : widget.name } ): OnlineServices.reduce_money2({"tarikh" : today.toString() , "saat" : datetime.toString() ,"agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode ,"name" : widget.name } );}

  void maliyat_req() async {
    counter = 0;
    String response = await OnlineServices.maliyat_req(
        {  "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode,
          "meli" : widget.melli,
          //"tavalod" : widget.tavalod.replaceAll("/", ""),
          "code": widget.posti,"foroshgah": widget.forushgah ,
        //  "mobile": (_key23.currentState!.value.toString().trim() + _key24.currentState!.value.toString().trim()).substring(1 , 11),
         // "tell1": _key21.currentState!.value.toString().trim() ,
          //"tell2": _key22.currentState!.value.toString().trim()
        } );
    if(response.contains("ok"))
    {
      isLoadingMal = true; setState(() {});
      Future.delayed(const Duration(milliseconds: 12000), () {
        maliyat_rec();
        isLoadingMal=false;
        setState(() {});
      });
    }
  }

  void maliyat_rec() async {
    counter++;
    if(counter < 3)
      {
        String response = await OnlineServices.maliyat_rec({ "code": widget.posti ,"meli": widget.melli, "name" : widget.name } );
        if(response.split(",")[1].toString() == "0")
        { _controller =  TextEditingController(text: response.split(",")[0]);
        reduce_money(1);
        setState(() {});}
        else if(response.split(",")[1].toString() == "1"){
          reduce_money(1);
          _showDialog(context, response.split(",")[2].toString());
        }
        else if(response.split(",")[1].toString() == "2"){
          _showDialog(context, response.split(",")[2].toString());
        }
        else maliyat_rec();
      }
    else {
      _showDialog(context, "متاسفانه عملیات با خطا مواجه شد!\n لطفا مجددا تلاش نمایید");
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    Color hintColor = Color(0x33000000);
    Color cl = Color(0xff000000);
    return
      Scaffold(
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اطلاعات تکمیلی","", Icons.edit, (){})),
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body:Stack(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20),
              height: size.height,
              // color: Colors.white,
              child:
              ListView(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Comp.editBox2(context,2,3,8, "پیش شماره","تلفن ثابت", Icons.phone, _key21, _key22, ""),
                  Comp.editBox2(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key23, _key24, ""),

                  Padding(padding: EdgeInsets.only(right: 35,left: 35,top: 6,bottom: 7),child: ElevatedButton(onPressed: () {

                    if (
                        _key23.currentState!.value.toString().length == 4 &&
                        _key24.currentState!.value.toString().length == 7
                    )
                    {
                      balance >= 15000 ? fun2() :
                      CoolAlert.show(
                        context: context,
                        confirmBtnText: "   بله  ",
                        type: CoolAlertType.warning,
                        title: '!عدم موجودی کافی',
                        onConfirmBtnTap: (){
                          Comp.showSnack(context,Icons.phone,"لطفا با مدیر برنامه تماس بگیرید" );},
                        text: "آیا مایل به شارژ کیف پول هستید؟",
                        backgroundColor: Colors.white,
                      );}
                    else Comp.showSnackError(context); },
                    style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10,horizontal: 8 )),textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),backgroundColor: MaterialStateProperty.all( balance >= 15000 ? Color(0xfffac80a) : Colors.red) ),
                      child: isLoadingEst ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                        Text("لطفا منتظر بمانید", style: TextStyle(color: Colors.black, fontSize: 16)),
                        CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white),
                      ],) : Stack(
                        alignment: Alignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("استعلام شماره همراه",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 20)),
                          Align(
                            child: Icon(
                              Icons.phonelink_setup_outlined,
                              color: Colors.black,
                              size: 30,
                            ),
                            alignment: Alignment.centerRight,
                          )
                        ],
                      ))),
                  //Comp.fullBtn2(size, "استعلام شماره همراه",Icons.phonelink_setup_outlined ,fun2 ,Color(0xff8c8c8c)),


                  Row(
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: size.width * .5,
                        margin: EdgeInsets.only(left: 10, right: 30, top: 10),
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                        //  initialValue: eqtesadi,
                          controller: _controller,
                          key: _key25,
                          cursorColor: cl,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                          //   initialValue: 'Input text',
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,

                            counterText: "",
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
                            //errorText: _errorText1,
                            labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: cl)),

                            labelText: "کد اقتصادی",
                            disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: cl)),
                            // errorText: 'Error message',
                            border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                          ),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 35),child: ElevatedButton(onPressed: (){


                          balance >= 12000 ? maliyat_req() :
                          CoolAlert.show(
                            context: context,
                            confirmBtnText: "   بله  ",
                            type: CoolAlertType.warning,
                            title: '!عدم موجودی کافی',
                            onConfirmBtnTap: (){
                              Comp.showSnack(context,Icons.phone,"لطفا با مدیر برنامه تماس بگیرید" );},
                            text: "آیا مایل به شارژ کیف پول هستید؟",
                            backgroundColor: Colors.white,
                          );}

                        ,style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10,horizontal: 8 )),textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),backgroundColor: MaterialStateProperty.all( balance >= 12000 ? Colors.teal : Colors.red) ),child:isLoadingMal ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                          CircularProgressIndicator(color: Colors.black,backgroundColor: Colors.white),
                        ],) : Text("استعلام مالیات"),),),

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

                            prefixIcon:
                                  _Soeichh.contains("پاسارگاد") ? Padding(child:Image.asset("assets/images/pasargad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : _Soeichh.contains("سداد") ?  Padding(child:Image.asset("assets/images/sadad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : _Soeichh.contains("پرداخت") ?  Padding(child:Image.asset("assets/images/behpardakht.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : _Soeichh.contains("سپهر") ?  Padding(child:Image.asset("assets/images/sepehr.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : _Soeichh.contains("ایران") ?  Padding(child:Image.asset("assets/images/irankish.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : _Soeichh.contains("پرداخت نوین") ?  Padding(child:Image.asset("assets/images/novin.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)
                                : Icon(Icons.apps,color: cl,),
                       //     icon: _Soeichh.contains("پاسارگاد") ? Icons.clear  : _Soeichh.contains("ایران") ? Image.asset("assets/images/irankish.png") : Icons.apps,
                           // prefixIcon: _Soeichh.contains("پاسارگاد") ? Image.asset("assets/images/pasargad.png")  : _Soeichh.contains("ایران") ? Image.asset("assets/images/irankish.png") : Icons.apps,
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
                                _Soeichh != "پرداخت نوین" ? {_key30 = "0" , _key31="0"} : {_key30 = "" , _key31=""};
                                // print("______________${_key31}________________");

                                getSoeichList();
                                _key26 = newVal;
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
                         // initialValue: _device_Type,
                          controller: _controller3,
                          enabled: false,
                          cursorColor: Colors.black,
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.zero,

                            prefixIcon: _device_Type.contains("Dialup") ? Icon(Icons.phone,color: cl,)  : _device_Type.contains("GPRS") ? Icon(Icons.wifi,color: cl,) : _device_Type.contains("LAN") ? Icon(Icons.cable,color: cl,) : Icon(Icons.cable),

                           // prefixIcon: Icon(Icons.device_hub, color: Colors.black,),

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
                                getBrandList();
                                _device_Type = newVal!;
                                _key27 = newVal;
                                _controller3 = TextEditingController(text: _device_Type);
                                setState(() {});
                              }))
                    ],
                  ),
                  _Soeichh == "پرداخت نوین" ? Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              controller: _controller4,
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
                                    _key30 = newVal;
                                    _model_value = "-";
                                    _controller4 = TextEditingController(text: _brand_value);
                                    getModelList(newVal) ;
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
                              controller: _controller5,
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
                                    _key31 = newVal;
                                    _controller5 = TextEditingController(text: _model_value);
                                    setState(() {});
                                  }))
                        ],
                      ),
                    ],
                  ) : Center(),
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
            isLoadingMal == true
                ? Container(height: size.height,width: size.width,color: Color(0x00ffffff),)
                : isLoadingEst == true
                ? Container(height: size.height,width: size.width,color: Color(0x00ffffff),)
                :isLoadingSave == true
                ? Container(height: size.height,width: size.width,color: Color(0x00ffffff),) :SizedBox()

          ],
        ),
      );
  }
  void fun(){

    if (
       _key30.length > 0 &&
       _key31.length > 0 &&
       _key21.currentState!.value.toString().length == 3 &&
       _key22.currentState!.value.toString().length == 8 &&
        _key23.currentState!.value.toString().length == 4 &&
        _key24.currentState!.value.toString().length == 7 &&
        _key25.currentState!.value.toString().length == 10 &&
        _key26.length > 1 &&
        _key27.length > 1
    )
    {
      //print("ok");
      setPrefs("key21" , _key21.currentState!.value.toString().trim() );
      setPrefs("key22" , _key22.currentState!.value.toString().trim() );
      setPrefs("key23" , _key23.currentState!.value.toString().trim() );
      setPrefs("key24" , _key24.currentState!.value.toString().trim() );
      setPrefs("key25" , _key25.currentState!.value.toString().trim() );
      setPrefs("key26" , _key26.toString() );
      setPrefs("key27" , _key27.toString() );
      setPrefs("key30" , _key30.toString() );
      setPrefs("key31" , _key31.toString() );

      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
         summary_registerPos(widget._Agentdata))));
    }
    else Comp.showSnackError(context);

  }

  void fun2() async {

    String datetime ="";
    String res = await OnlineServices.estelam_mobile({"tarikh" : today.toString() , "saat" : datetime.toString() ,"meli" : widget.melli ,"mobile": (_key23.currentState!.value.toString().trim() + _key24.currentState!.value.toString().trim()).substring(1 , 11),
      "agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode
    });
    if (res == "ok")
    {
//      print("_______________________ok");

      reduce_money(2);
      isLoadingEst = true;
      setState(() {});
      Future.delayed(const Duration(milliseconds: 12000), () {
       // print("_______________________finish");

        fun3();
        isLoadingEst=false;
        setState(() {});
      });
    } else Comp.Alert1(context,"خطا","عملیات با خطا مواجه شد",2);
}

  void fun3() async {
    String res = await OnlineServices.estelam_mobile2({"mobile": (_key23.currentState!.value.toString().trim() + _key24.currentState!.value.toString().trim()).substring(1 , 11),
    //  "agentcode": "111", "usercode": "1"
      "agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode
    } );
    // print("____________________resss___${res}");

    if(res.contains("True"))
      {
        Comp.Alert1(context,"تاییدیه","شماره ملی و شماره همراه مطابقت دارد.",1);
      }
    else
      {
        Comp.Alert1(context,"خطا","شماره ملی و شماره همراه مطابقت ندارد.",2);
      }
}

  void _showDialog(BuildContext context, String txt) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(18)) ),

          child: AlertDialog(
            title: Text(txt,textAlign: TextAlign.right,),
            content: const SingleChildScrollView(

            ),
            actions: <Widget>[
              Row(
                children: [
                  ElevatedButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      child: Text("تایید",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),)),],
              )
            ],
          ),
        );
      },
    );
  }

}

