import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/bankModel.dart';
import 'package:sima_portal/a_sima_app/models/shobeModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../appbar_home.dart';
import '../models/pazirandeModel2.dart';


class sheba_register2_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  sheba_register2_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => sheba_register2_pageState();
}

class sheba_register2_pageState extends State<sheba_register2_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  late String today = "";
  late String datetime = "";

  String PSP = "";
  String _key1 = "";
  String _key2 = "";
  String _key3 = "";
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  List<String> _bankValue = [];
  List<String> _shobeValue = [];
  List<String> _pazirandeValue = [];
  String _pazirande_Value = "پذیرنده";
  String _bank_Value = "بانک";
  String _shobe_Value = "شعبه";
  List<BankModel> _data = [];
  List<ShobeModel> _data2 = [];
  late  String hesab;
  late String sheba;
  List<PazirandeModel2> _data3 = [];
  late TextEditingController _controller1 = TextEditingController(text: "پذیرنده");
  late TextEditingController _controller2 = TextEditingController(text: "بانک");
  late TextEditingController _controller3 = TextEditingController(text: "شعبه");
  late TextEditingController _controller4 = TextEditingController(text: "");
  late TextEditingController _controller5 = TextEditingController(text: "");

  late AnimationController _loginButtonController;

  int counter = 0;
  double balance = 0;
  bool isLoading = false;
  void getBalance() async {
    String response = await OnlineServices.getBalance(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode
          //   "agentcode": "10004",
          //  "usercode": "0"
        });
    balance = double.parse(response);
 // balance = 1000;
  }

  // void _getBanks() async {
  //   Map response = await OnlineServices.getBankList();
  //   _data.clear();
  //   _bankValue.clear();
  //   _data.addAll(response['data']);
  //   for (int i = 0; i < _data.length; i++) {
  //     _bankValue.add(_data[i].bankName);
  //   }
  //   setState(() {});
  // }

  void _getPSP(String sanad) async {
    String response = await OnlineServices.getPSP2({"sanad": sanad,});
    PSP = response;
    setState(() {});
    getBankList(PSP);
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

  void getPazirandeList() async {
    Map response = await OnlineServices.getPazirandeList2({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode
    });
    _data3.clear();
    _pazirandeValue.clear();
    //  print("********22 " + response[0]);
    _data3.addAll(response['data']);

    for (int i = 0; i < _data3.length; i++) {
      _pazirandeValue.add(_data3[i].pazirande);
    }
    //print("***" + _pazirandeValue.first.toString().split("-").first.toString() + "***" );
    setState(() {});
    //  print(_shobeValue);
  }

  @override
  void initState() {
    _loginButtonController = AnimationController(vsync: this, duration: Duration(milliseconds: 6000));
    getBalance();
    getPazirandeList();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _loginButtonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;

    Color cl = Color(0xff000000);
    Color bcTextColor = Color(0xbb000000);
    Color textColor = Color(0xbb000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Comp.appBarHeight),
        child: Comp.app_bar("اطلاعات حساب پذیرنده","", Icons.edit, (){})),

      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 10),
          height: size.height,
          // color: Colors.white,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[

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

                        prefixIcon:
                        PSP.contains("پرداخت نوین") ? Padding(child:Image.asset("assets/images/novin.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) :
                        PSP.contains("سپهر") ? Padding(child:Image.asset("assets/images/sepehr.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) :
                        PSP.contains("پاسارگاد") ? Padding(child:Image.asset("assets/images/pasargad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) :PSP.contains("پرداخت") ? Padding(child:Image.asset("assets/images/behpardakht.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),): PSP.contains("سداد") ? Padding(child:Image.asset("assets/images/sadad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)  : PSP.contains("ایران") ?  Padding(child:Image.asset("assets/images/irankish.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) : Icon(Icons.person,color: cl,),

                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl,width: 1.0)),
                        labelText: "پذیرنده",
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
                          items:_pazirandeValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _pazirande_Value = newVal!;
                            _key1 = newVal;
                            _controller1 = TextEditingController(text: _pazirande_Value);
                            _getPSP(_pazirande_Value.split("-").first);

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
                      controller: _controller3,
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
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 13),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _controller4,
                  keyboardType: TextInputType.number,
                  cursorColor: cl,
                  textAlign: TextAlign.center,
                  key: _key4,
                  style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                  decoration: InputDecoration(
                    counterText: "",
                    prefixIcon: Icon(
                      Icons.edit,
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

                    labelText: "شماره حساب",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: cl)),
                    // errorText: 'Error message',
                    border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 30, right: 30, top: 13),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  maxLength: 24,
                  controller: _controller5,
                  keyboardType: TextInputType.number,
                  cursorColor: cl,
                  textAlign: TextAlign.center,
                  key: _key5,
                  style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                  decoration: InputDecoration(
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
contentPadding: EdgeInsets.zero,
                    //errorText: _errorText1,
                    labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: cl)),

                    labelText: "شماره شبا",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: cl)),
                    // errorText: 'Error message',
                    border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                  ),
                ),
              ),
            //  Comp.editBox1(context,2,0, "شماره حساب", Icons.edit, _key4, ""),
             // Comp.editBox1(context,2,24, "شماره شبا", Icons.drive_file_rename_outline, _key5, ""),

              Padding(padding: EdgeInsets.only(right: 35,left: 35,top: 6,bottom: 7),child: ElevatedButton(onPressed: () {
                if (_key1.toString().length >1)
                {
                  balance >= 11000 ? _showDialog() :
                  CoolAlert.show(
                    context: context,
                    confirmBtnText: "   بله  ",
                    type: CoolAlertType.warning,
                    title: '!عدم موجودی کافی',
                    onConfirmBtnTap: (){
                      Comp.showSnack(context,Icons.phone,"لطفا با مدیر برنامه تماس بگیرید" );},
                    text: "آیا مایل به شارژ کیف پول هستید؟",
                    backgroundColor: Colors.white,
                  );
                }
                else Comp.showSnackError(context); },
                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 10,horizontal: 8 )),textStyle: MaterialStateProperty.all(TextStyle(fontSize: 17,fontWeight: FontWeight.w600)),backgroundColor: MaterialStateProperty.all( balance >= 11000 ? Colors.blue : Colors.red) ),
                  child: isLoading ? Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                    Text("لطفا منتظر بمانید", style: TextStyle(color: Colors.white, fontSize: 16)),
                    CircularProgressIndicator(color: Colors.red,backgroundColor: Colors.white),
                  ],) : Text("دریافت خودکار شماره شبا و حساب",
                      style: TextStyle(
                          color: Colors.white, fontSize: 18)))),

             // Comp.fullBtn(size, "دریافت شماره شبا و حساب", Icons.drive_file_rename_outline, _showDialog ),
              Container(height:size.height * .2,child: FutureBuilder<String>(
                future: getImgBank(_bank_Value),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return CachedNetworkImage(
                      height: 30,
                     // fit: BoxFit.fitHeight,
                      imageUrl: snapshot.data!.toString(),
                      placeholder: (context, url) =>
                          Container(height: 30,width: 30,),
                      errorWidget: (context, url, error) =>
                          Image.asset("assets/images/Markazi.jpg"),
                    );
                  } else if (snapshot.hasError) {
                    return Container();} else return Container();
                },
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Comp.miniBtn1(context ,size, "ثبت اطلاعات", Colors.teal , fun , 1),
                  Comp.miniBtn1(context , size, "انصراف", Colors.teal , (){} , 2),

                ],
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
        isLoading == true ? Comp.showLoading(size.height , size.width) : Center()
      ]),
    );
  }

  void reduce_money() async {
    // print("_______________________reduce money ${type}");

    
    
    
    
    String datetime ="";
  //  print("reducing");
     OnlineServices.shebs_reduce_money({"tarikh" : today.toString() , "saat" : datetime.toString() ,"agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode ,"name" : _key1.toString() }) ;
  }

  void sheba_req(String cardNo) async {
    //  print("_______________________reunnnn");
    
    
    
    
    String datetime ="";
    String res = await OnlineServices.sheba_estelam({"tarikh" : today.toString() , "saat" : datetime.toString() ,"card" : cardNo , "agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode
    });
    if (res == "ok")
    {
      reduce_money();
      isLoading = true;
      setState(() {});
      Future.delayed(const Duration(milliseconds: 12000), () {
        sheba_rec(cardNo);
        isLoading=false;
        setState(() {});
      });
    } else Comp.Alert1(context,"خطا","عملیات با خطا مواجه شد",2);
  }

  void sheba_rec(String cardNo) async {
    String res = await OnlineServices.sheba_estelam2({"card": cardNo,} );
   //  print("____________________resss___${res}");

    if(res.contains(",") && res.toString().length > 10)
    {
     // print("______________");
     // print(res.split(",")[0]);
      //print(res.split(",")[1]);

      _controller4 = TextEditingController(text: res.split(",")[0].toString());
      _controller5 = TextEditingController(text: res.split(",")[1].toString().replaceAll("IR", ""));
      setState(() {});

      Comp.Alert1(context,"عملیات موفق",
          "شماره حساب: " + res.split(",")[0].toString() + "\n" +
          "شماره شبا: " + res.split(",")[1].toString() +"\n" +
          "نام صاحب حساب: " + res.split(",")[2].toString() +"\n" +
          "بانک: " + res.split(",")[3].toString()
          ,1);

      // Comp.Alert1(context,"تاییدیه","شماره ملی و شماره همراه مطابقت دارد.",1);
    }
    else
    {
      Comp.Alert1(context,"خطا در استعلام",res,2);
    }
  }


  void _showDialog() {
    var size = MediaQuery
        .of(context)
        .size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            title:Text("شماره کارت پذیرنده را وارد کنید",textAlign: TextAlign.right, style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16)),
            actions: <Widget>[
              TextFormField(
                keyboardType: TextInputType.number,
                maxLength: 16,
                key : _key6,
                // controller: _controller6,
                decoration: InputDecoration(
                    hintText: "شماره کارت"
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                   if( _key6.currentState!.value.toString().length == 16 )
                     {
                       Navigator.pop(context);

                       sheba_req(_key6.currentState!.value.toString()); }
                   else {Comp.showSnackError(context);
                   }
                  },
                  child: Text("استعلام", style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
            ],
          ),
        );
      },
    );
  }


  Future<String> getImgBank(String name) async {
    String response = await OnlineServices.getImgBank({
      "bank": name
    });
    //print (await response);
    return response;
  }

   void fun(){
    if (
     _controller1.text != "پذیرنده" &&
     _controller2.text != "بانک" &&
     _controller3.text != "شعبه" &&
        _key4.currentState!.value.toString().length > 0 &&
        _key5.currentState!.value.toString().length == 24) {
      isLoading = true;
      setState(() {});
      sendDataForSheba();
    } else {
    Comp.showSnack(context, Icons.warning_amber_rounded, "0");
    }
  }

  Future<String> sendDataForSheba() async {
    late String today = "";
  late String datetime = "";

  String response = await (OnlineServices()).sendDataForSabtSheba({
      "tarikh": today, "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "sanad": _key1.split("-").first,
      "bank": _key2,
      "shobe": _key3,
      "hesab": _key4.currentState!.value.toString(),
      "shaba": _key5.currentState!.value.toString(),
      "usercode": widget._Agentdata.last.userCode
    });
    //  print("--------------------" + response);
    if (response == "ok") {
      await (OnlineServices())
          .sendDataForSabtSheba2({"sanad": _key1.split("-").first});
      isLoading = false;
      setState(() {});
      Navigator.pop(context);
      Comp.showDialog_(context, "اطلاعات با موفقیت ثبت شد" ,appbar_home(widget._Agentdata));
    } else {
      // print("errrror");
    }
    return "";
  }

}

