import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import '../models/pazirandeModel2.dart';
import 'nesbat_model.dart';


class new_moaref_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  new_moaref_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => newMoaref_pageState();
}

class newMoaref_pageState extends State<new_moaref_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  bool isComplete = false;
  late String nameM1 = "M";
  late String codemelli1;
  late String tel1;
  late String phone1;
  late String nesbat1;
  String forushgah1="";
  String address1="";

  late String nameM2="M";
  late String codemelli2;
  late String tel2;
  late String phone2;
  late String nesbat2;
  String forushgah2 ="";
  String address2   ="";
  
  // final _key5 = GlobalKey<FormFieldState>();
  String _key1     = "";

  final  _keyA = GlobalKey<FormFieldState>();
  final  _keyC = GlobalKey<FormFieldState>();
  final  _keyD = GlobalKey<FormFieldState>();
  final  _keyE = GlobalKey<FormFieldState>();
  final  _keyF = GlobalKey<FormFieldState>();
  final  _keyG = GlobalKey<FormFieldState>();
  final  _keyH = GlobalKey<FormFieldState>();
  final  _keyI = GlobalKey<FormFieldState>();

  List<String> _pazirandeValue = [];
  List<String> nesbatList = [];
  String _pazirande_Value = "پذیرنده";
  List<String> _nesbatValue = [];
  String _nesbat_Value = "پذیرنده";
  List<PazirandeModel2> _data3 = [];
  bool loading = false;
  bool isPasargad = false;
  late TextEditingController _controller1 = TextEditingController(text: "پذیرنده");
  late TextEditingController _controller2 = TextEditingController(text: "نسبت");
  late TextEditingController _controller3 = TextEditingController(text: "نسبت");

  void getPazirandeList() async {
    Map response = await OnlineServices.getPazirandeList4({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode
    });
    _data3.clear();
    _pazirandeValue.clear();
    _data3.addAll(response['data']);

    for (int i = 0; i < _data3.length; i++) {
      _pazirandeValue.add(_data3[i].pazirande);
    }
    setState(() {});
  }
  void getNesbatList() async {
    Map response = await OnlineServices.getNesbatList();
    nesbatList.clear();
    _nesbatValue.clear();
    // nesbatList = (response['data']);
    for (int i = 0; i < response["data"].length; i++) {
      nesbatList.add(response['data'][i]);
    }
    setState(() {});
  }

  void _getPSP(String sanad) async {
    String response = await OnlineServices.getPSP2(
        {
          "sanad": sanad,
        });
    isPasargad = false;
    response.contains("پاسارگاد") ? isPasargad = true  : null;
    setState(() {});
    print(response + isPasargad.toString());
    // return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
  }

  @override
  void initState() {
    getPazirandeList();
    getNesbatList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var size = MediaQuery.of(context).size;
    Color cl = Color(0xff000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ثبت معرف پذیرنده","", Icons.edit, (){})),
      resizeToAvoidBottomInset: true,
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 20),
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

                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl)),
                        labelText: "پذیرنده",
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
                          items:_pazirandeValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            _getPSP(newVal!.split("-")[0]);
                            _pazirande_Value = newVal;
                            _key1 = newVal;
                            _controller1 = TextEditingController(text: _pazirande_Value);
                            setState(() {});
                          }))
                ],
              ),
              SizedBox(height: 20,),
              header("اول"),
              nameM1 !="M" ? SizedBox(
                child: Column (
                  children: [
                    txt("نام معرف: " + nameM1),
                    txt("کد ملی: " + codemelli1),
                    txt("نسبت: " + nesbat1),
                    txt("ثابت: " + tel1 +"\nهمراه: "+ phone1),
                    !isPasargad ? txt("نام فروشگاه: " + forushgah1) : Center(),
                    !isPasargad ? txt("آدرس: " + address1) : Center(),

                  ],
                ),
              ) : Center(),
              nameM1 !="M" ? header("دوم"): Center(),
              nameM2 !="M" ? SizedBox(
                child: Column (
                  children: [
                    txt("نام معرف: " + nameM2),
                    txt("کد ملی: " + codemelli2),
                    txt("نسبت: " + nesbat2),
                    txt("ثابت: " + tel2 +" - همراه: "+ phone2),
                    !isPasargad ? txt("نام فروشگاه: " + forushgah2) : Center(),
                    !isPasargad ? txt("آدرس: " + address2) : Center(),
                  ]
                ),
              ) : Center(),
              nameM2 == "M" ? SizedBox(child: Column(
               children: [
                 Comp.editBox1(context,1, 0,"نام و نام خانوادگی معرف", Icons.person_pin_outlined, _keyA, ""),
                 Comp.editBox1(context,0, 10,"کدملی معرف", Icons.person_pin_outlined, _keyC, ""),
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
                             Icons.person,
                             color: Colors.black,
                           ),
                           labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                           focusedBorder: OutlineInputBorder(
                               borderSide: BorderSide(color: cl)),
                           labelText: "نسبت",
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
                             items:nesbatList.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                             onChanged: (newVal) {
                               _nesbat_Value = newVal!;
                               _controller2 = TextEditingController(text: _nesbat_Value);
                               setState(() {});
                             }))
                   ],
                 ),
                 Comp.editBox2(context,2,3,8, "پیش شماره","تلفن ثابت", Icons.phone, _keyD, _keyE, ""),
                 Comp.editBox2(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _keyF, _keyG, ""),
                 !isPasargad ? Comp.editBox1(context,1, 30,"نام فروشگاه", Icons.store, _keyH, "") : Center(),
                 !isPasargad ? Comp.editBox1(context,1, 0,"آدرس", Icons.location_on_outlined, _keyI, "") : Center(),
               ],
             )) : Center(),
              ///##################################
              SizedBox(height: 10,),
              nameM1 == "M" || nameM2 == "M" ? ElevatedButton(onPressed: (){print(nameM1); nameM1 == "M" ? fun1() : fun2();}, child: nameM1 != "M" ? Text("ثبت معرف دوم"): Text("ثبت معرف اول")) : Center(),

              isComplete ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Comp.miniBtn1(
                      context, size, "ثبت اطلاعات", Colors.teal, fun3, 1),
                  Comp.miniBtn1(
                      context, size, "انصراف", Colors.teal, () {}, 2),
                ],
              ) : Center(),
              SizedBox(height: 30,)
            ],
          ),
        ),
        loading == true ? Comp.showLoading(size.height , size.width) : Center()

      ]),

    );
  }
  
  Widget txt(String textF)
  {
    var size =MediaQuery.of(context).size;

    return  Container(
      // width: !textF.contains( "آدرس"  ) ?size.width * .7: null,
        padding: EdgeInsets.symmetric(vertical: 7,horizontal: 20),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 2),
        decoration: BoxDecoration(
            color: Color(0xffd3d3d3),
            borderRadius: BorderRadius.all( Radius.circular(5))
        ),
        child: Text(textF ,style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 16)));
  }

  Widget header (String i){
    var size =MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.symmetric(vertical: 4,horizontal: 4),
      decoration: BoxDecoration(
          color: Color(0xff4fbbff),
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15))
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        SizedBox(child: Divider(thickness: .9,color: Colors.black,), width: size.width * .2,),
        Text("مشخصات معرف ${i}", style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(child: Divider(thickness: .9,color: Colors.black,), width: size.width * .2,),
      ]),
    );
  }

  void fun1() {
    bool aa = true;
    bool bb = true;
    if (!isPasargad)
      {
        _keyH.currentState!.value.toString().length > 2 ? aa=true : aa=false;
        _keyH.currentState!.value.toString().length > 2 ? bb=true : bb=false;
      }
    if (
    (_controller2.text !="نسبت" &&
        _keyA.currentState!.value.toString().length > 1 &&
        _keyC.currentState!.value.toString().length == 10 &&
        _keyD.currentState!.value.toString().length == 3 &&
        _keyE.currentState!.value.toString().length == 8 &&
        _keyF.currentState!.value.toString().length == 4 &&
        _keyG.currentState!.value.toString().length == 7 ) &&
        aa   &&
        bb
    )
    {
      nameM1 = _keyA.currentState!.value.toString();
      codemelli1 = _keyC.currentState!.value.toString();
      nesbat1 = _controller2.text;
      tel1 = _keyD.currentState!.value.toString() + _keyE.currentState!.value.toString();
      phone1 = _keyF.currentState!.value.toString() + _keyG.currentState!.value.toString();
      !isPasargad ? forushgah1 = _keyH.currentState!.value.toString() : null;
      !isPasargad ? address1 = _keyI.currentState!.value.toString() : null;

      _keyA.currentState!.reset();
      _keyC.currentState!.reset();
      _keyD.currentState!.reset();
      _keyE.currentState!.reset();
      _keyF.currentState!.reset();
      _keyG.currentState!.reset();
      !isPasargad ? _keyH.currentState!.reset():null;
      !isPasargad ? _keyI.currentState!.reset():null;
      _controller2.clear();

      setState(() {});
      // sendDataForMoaref();

    } else
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  void fun2() {
    bool aa = true;
    bool bb = true;
    if (!isPasargad)
    {
      _keyH.currentState!.value.toString().length > 2 ? aa=true : aa=false;
      _keyH.currentState!.value.toString().length > 2 ? bb=true : bb=false;
    }
    if (
    (_controller2.text !="نسبت" &&
        _keyA.currentState!.value.toString().length > 1 &&
        _keyC.currentState!.value.toString().length == 10 &&
        _keyD.currentState!.value.toString().length == 3 &&
        _keyE.currentState!.value.toString().length == 8 &&
        _keyF.currentState!.value.toString().length == 4 &&
        _keyG.currentState!.value.toString().length == 7 ) &&
        aa   &&
        bb
    )

    {
      nameM2 = _keyA.currentState!.value.toString();
      codemelli2 = _keyC.currentState!.value.toString();
      nesbat2 = _controller2.text;
      tel2 = _keyD.currentState!.value.toString() + _keyE.currentState!.value.toString();
      phone2 = _keyF.currentState!.value.toString() + _keyG.currentState!.value.toString();
      !isPasargad ? forushgah2 = _keyH.currentState!.value.toString():null;
      !isPasargad ? address2 = _keyI.currentState!.value.toString():null;
      isComplete = true;
      setState(() {});
      // sendDataForMoaref();

    } else
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  void fun3() {
   // print(_controller1.text);
    if (
        _controller1.text !="پذیرنده"
    )
    {
      loading = true;
      setState(() {});
      sendDataForMoaref();

    } else
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  Future<String> sendDataForMoaref() async {
    late String today = "";
  late String datetime = "";

    String response = await (OnlineServices()).sendDataForSabtMoaref({
      "tarikh": today, "saat": datetime,
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "sanadpazirande": _key1.split("-").first,
      "namepazirande": _key1.split("-").last,
      "name": nameM1,
      "nametwo": nameM2,
      "tell": tel1,
      "telltwo": tel2,
      "mobile": phone1,
      "mobiletwo": phone2,
      "codemeli": codemelli1,
      "codemelitwo": codemelli2,
      "nesbat": nesbat1,
      "nesbattwo": nesbat2,
       "address": address1,
       "addresstwo": address2,
       "foroshgah": forushgah1,
       "foroshgahtwo": forushgah2,
    });
    //   print(response);
    if (response == "ok") {
      loading = false;
      setState(() {});
      Navigator.pop(context);
      _showDialog(context);
    } else {
      // print("errrror");
    }

    return "";

  }

  void _showDialog(BuildContext context) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('با موفقیت ثبت شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                   // Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (BuildContext context) => Directionality(
                    //             textDirection: TextDirection.rtl,
                    //             child: appbar_home(widget._Agentdata))));
                  },
                  child: Text(
                    "تایید",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ))
            ],
          ),
        );
      },
    );
  }
}