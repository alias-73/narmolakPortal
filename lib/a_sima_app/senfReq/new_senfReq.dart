
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/senfReq/sanad-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
// import 'package:shamsi_date/shamsi_date.dart';

class senfReq_list extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  senfReq_list(this._Agentdata);
  @override
  State<StatefulWidget> createState() => senfReq_listState();

}

class senfReq_listState extends State<senfReq_list> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key1 = GlobalKey<FormFieldState>();

  String name = "" ;
  String tel = "" ;
  String mobile= "" ;
  String foroshgah= "" ;
  String bank  = "" ;
  String hesab = "" ;
  String sheba = "-" ;
  String senf = "" ;
  late TextEditingController _controller1 = TextEditingController(text: "سند");

  List<SanadModel> _data = [];
  List<String> _sanadList = [];

  bool loading = false;
  late String today = "";
  late String datetime = "";
  @override
  void initState() {
    super.initState();
  }

  void _getSanadList() async {
    Map response;
    response = await OnlineServices.getSanadList({
      "codemeli": _key1.currentState!.value.toString(),
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode
    });
    //  print(response);
    if (response["data"] != "no") {

      _data.clear();
      _data.addAll(response['data']);
      _sanadList.clear();
      for(int i = 0 ; i < _data.length ; i++)
        {
          _sanadList.add(_data[i].sanad);
        }
      setState(() {});
    }
    else {

    }

  }

  void _getData(String sanad) async {
    sheba = "-";
    String response;
    response = await (OnlineServices()).getPazirandeInfo2({
      "sanad": sanad
    });
     // print(response);
    if (response.contains(",")) {
      foroshgah = response.split(",")[0];
      senf = response.split(",")[1];
      tel = response.split(",")[2];
      mobile = response.split(",")[3];
      bank = response.split(",")[4];
      hesab = response.split(",")[5];
      sheba = response.split(",")[6];
      // print("___________${sheba}________");

      setState(() {});
    }
    else {

    }
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    String edt = "";
    Color cl = Colors.black;

    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("درخواست ترمینال","", Icons.edit, (){})),

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
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 13),
              child: TextFormField(
                // enabled: initial.length > 0 ? false : true,
                maxLength: 10,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                cursorColor: cl,
                // initialValue: "0830047476",
                textAlign: TextAlign.center,
                key: _key1,
                style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                decoration: InputDecoration(
                  counterText: "",
                  prefixIcon: Padding(child: FloatingActionButton(
                    child: Icon(Icons.refresh),
                    backgroundColor: Colors.teal,
                    onPressed: () {
                      _key1.currentState!.value.toString().length == 10 ?
                      _getSanadList() : Comp.showSnackError(context);},
                    mini: true,
                  ),padding: EdgeInsets.only(right: 9),),
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

                  labelText: "کد ملی",
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: cl)),
                  // errorText: 'Error message',
                  border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                ),
              ),
            ),
            _sanadList.isNotEmpty ? Stack(
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
                      labelText: "نام پذیرنده",
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
                        items:_sanadList.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                        onChanged: (newVal) {
                          _controller1 = TextEditingController(text: newVal);
                          _getData(_controller1.text.split("-")[0]);
                          setState(() {});
                        }))
              ],
            ): Center(),
            sheba !="-" ? header("اطلاعات فروشگاه") : Center(),
            sheba !="-" ? Comp.editBox9_1(context, "نام فروشگاه", Icons.store , foroshgah) : Center(),
            sheba !="-" ? Comp.editBox8(context, "صنف", Icons.menu, senf) : Center(),
            sheba !="-" ? Comp.editBox9(context, "تلفن", Icons.phone, tel) : Center(),
            sheba !="-" ? Comp.editBox9(context, "موبایل", Icons.phone_android, mobile) : Center(),
            sheba !="-" ? header("اطلاعات حساب") : Center(),
            sheba !="-" ? Comp.editBox9(context, "نام بانک", Icons.maps_home_work_outlined, bank) : Center(),
            sheba !="-" ? Comp.editBox9(context, "شماره حساب", Icons.drive_file_rename_outline, hesab) : Center(),
            sheba !="-" ? Comp.editBox9(context, "شماره شبا", Icons.drive_file_rename_outline_sharp, sheba) : Center(),


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

  void fun2(String newVal){

  }
  Widget header (String i){
    var size =MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 7),
      margin: EdgeInsets.only(right: 30,left: 30, top: 15),
      decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(15), bottomRight: Radius.circular(15))
      ),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
        SizedBox(child: Divider(thickness: .9,color: Colors.black,), width: size.width * .2,),
        Text(i, style: TextStyle(fontWeight: FontWeight.w700)),
        SizedBox(child: Divider(thickness: .9,color: Colors.black,), width: size.width * .2,),
      ]),
    );
  }

  void fun(){
    if (sheba !="-") {
      sendDataForSave();
     loading = true;
      setState(() {});
    }
    else {
      Comp.showSnack(context, Icons.warning_amber_rounded, "0");}
  }


  void sendDataForSave() async {
    DateTime dateTime = DateTime.now();
    // String datee = Jalali.fromDateTime(dateTime).year.toString()+"/"+Jalali.fromDateTime(dateTime).month.toString()+"/"+Jalali.fromDateTime(dateTime).day.toString();
    String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;
    String response = await (OnlineServices()).getPayaneSave(
        {
          "sanad": _controller1.text.split("-")[0],
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode,
          "tarikh": "0",
          "saat": datetime,
          //    "agentcode" : widget._Agentdata.last.agentCode , "brand": _key3.toString() , "model": _key4.toString() , "serial" : _controller4.value.text.toString(), "soeich": _key5.toString() ,"usercode" : widget._Agentdata.last.userCode, "tarikh": today, "saat": datetime
        });

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