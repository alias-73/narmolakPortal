import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';

import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class edit_registerPos extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  String sanad;

  edit_registerPos(this.sanad, this._Agentdata);

  @override
  State<StatefulWidget> createState() => edit_registerPosState();
}

class edit_registerPosState extends State<edit_registerPos> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key1  = GlobalKey<FormFieldState>();
  final _key2  = GlobalKey<FormFieldState>();
  final _key3  = GlobalKey<FormFieldState>();
  final _key4  = GlobalKey<FormFieldState>();
  final _key5  = GlobalKey<FormFieldState>();
  final _key6  = GlobalKey<FormFieldState>();
  final _key7  = GlobalKey<FormFieldState>();
  final _key8  = GlobalKey<FormFieldState>();
  final _key9  = GlobalKey<FormFieldState>();
  final _key10 = GlobalKey<FormFieldState>();
  final _key11 = GlobalKey<FormFieldState>();
  final _key12 = GlobalKey<FormFieldState>();
  final _key13 = GlobalKey<FormFieldState>();
  final _key14 = GlobalKey<FormFieldState>();
  final _key15 = GlobalKey<FormFieldState>();
  final _key17 = GlobalKey<FormFieldState>();
  final _key18 = GlobalKey<FormFieldState>();

  TextEditingController? _controller1;
  TextEditingController? _controller2;
  List<String> _deviceType = ['Dialup' , 'GPRS' , 'LAN'];
  String _device_Type = "نوع دستگاه";
  List<String> _genderValue =      ['مذکر' , 'مونث'];
  String _gender_Value = "جنسیت";
  TextEditingController? _controller3;

  String data = "0" ;
  String _datetime = 'تاریخ تولد';
  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  Color bcTextColor = Color(0x22000000);
  Color textColor = Color(0xbb000000);

  @override
  void initState() {
    get_editPazirandeh();
    super.initState();
  }


  void get_editPazirandeh() async {
    String response = await OnlineServices.get_editPazirande({"sanad": widget.sanad});
    data = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    _controller3 = TextEditingController(text: data.split(",")[15]);
    _controller2 = TextEditingController(text: data.split(",")[17]);
    _controller1 = TextEditingController(text: data.split(",")[18]);
    setState(() {});

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    Color cl = Color(0xff000000);

    double widthItem = size.width * .8;
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ویرایش پذیرنده حقیقی","", Icons.edit, (){})),

      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //width: size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام پذیرنده فارسی", Icons.person, _key1, data.split(",")[0].isEmpty ? "" : data.split(",")[0]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام خانوادگی پذیرنده فارسی", Icons.person, _key2, data.split(",")[1].isEmpty ? "" : data.split(",")[1]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام پذیرنده انگلیسی", Icons.person, _key3, data.split(",")[2].isEmpty ? "" : data.split(",")[2]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام خانوادگی پذیرنده انگلیسی", Icons.person, _key4, data.split(",")[3].isEmpty ? "" : data.split(",")[3]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام پدر فارسی", Icons.person_pin_outlined, _key5, data.split(",")[4].isEmpty ? "" : data.split(",")[4]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام پدر انگلیسی", Icons.person_pin_outlined, _key17, data.split(",")[16].isEmpty ? "" : data.split(",")[16]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام فروشگاه(فارسی)", Icons.store, _key6, data.split(",")[5].isEmpty ? "" : data.split(",")[5]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام فروشگاه(انگلیسی)", Icons.store, _key7, data.split(",")[6].isEmpty ? "" : data.split(",")[6]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 10, "کد ملی", Icons.card_membership, _key8, data.split(",")[7].isEmpty ? "" : data.split(",")[7]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 0, "شماره شناسنامه", Icons.card_membership, _key15, data.split(",")[14].isEmpty ? "" : data.split(",")[14]) : Center(),
                  data.length > 1 ? Comp.editBox6(context,2,3,8, "کد شهر","تلفن ثابت", Icons.phone, _key9, _key10,data.split(",")[9].isEmpty ? "": data.split(",")[9], data.split(",")[8].isEmpty ? "" : data.split(",")[8])  : Center(),
                  data.length > 1 ? Comp.editBox6(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key11, _key12, data.split(",")[11].isEmpty ? "" : data.split(",")[11],data.split(",")[10].isEmpty ? "" : data.split(",")[10])  : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 10, "کد اقتصادی", Icons.drive_file_rename_outline, _key13, data.split(",")[12].isEmpty ? "" : data.split(",")[12]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 10, "کد پستی", Icons.drive_file_rename_outline, _key14, data.split(",")[13].isEmpty ? "" : data.split(",")[13]) : Center(),
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
                              Icons.account_tree,
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
                                _controller2 = TextEditingController(text: _device_Type);
                                setState(() {});
                              }))
                    ],
                  ),
                  GestureDetector(
                      onTap: _showDatePicker,
                      child:  Stack(
                        alignment: Alignment.center,
                        children: <Widget>[

                          Container(
                            margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                           //   initialValue: _datetime == "-" ? "-" : _datetime.replaceAll("-", "/"),
                              controller: _controller3,
                              enabled: false,
                              cursorColor: Colors.black,
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.zero,

                                prefixIcon: Icon(
                                  Icons.cake,
                                  color: Colors.black,
                                ),
                                labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                                labelText: "تاریخ تولد",
                                disabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: cl,width: 1.0)),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                              Icons.wc,
                              color: Colors.black,
                            ),
                            labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: cl,width: 1.0)),
                            labelText: "جنسیت",
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
                              items:_genderValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                              onChanged: (newVal) {
                                _gender_Value = newVal!;
                                _controller1 = TextEditingController(text: _gender_Value);
                                setState(() {});
                              }))
                    ],
                  )

                ],
              ),
            ),
            SizedBox(height: 12,),
            data.length > 1 ? Comp.fullBtn(size, "ثبت اصلاحات",Icons.save_outlined, fun ) : Center(),
            SizedBox(height: 13,),

          ],
        ),
      ),
    ));
  }

  void fun(){
   // send_editPazirande();
    if (_key1.currentState!.value
        .toString()
        .length > 1 &&
        _key2.currentState!.value
            .toString()
            .length > 1 &&
        _key3.currentState!.value
            .toString()
            .length > 1 &&
        _key4.currentState!.value
            .toString()
            .length > 1 &&
        _key5.currentState!.value
            .toString()
            .length > 1 &&
        _key6.currentState!.value
            .toString()
            .length > 1 &&
        _key7.currentState!.value
            .toString()
            .length > 1 &&
        _key8.currentState!.value
            .toString()
            .length == 10 &&
        _key9.currentState!.value
            .toString()
            .length == 3 &&
        _key10.currentState!.value
            .toString()
            .length == 8 &&
        _key11.currentState!.value
            .toString()
            .length == 4 &&
        _key12.currentState!.value
            .toString()
            .length == 7 &&
        _key13.currentState!.value
            .toString()
            .length >2 &&
        _key14.currentState!.value
            .toString()
            .length == 10 &&
        _key15.currentState!.value
            .toString().isNotEmpty

    ) {
      send_editPazirande();
    } else {
      Comp.showSnackError(context);
    }
  }

  void send_editPazirande() async {
    String response;
    response = await (OnlineServices()).send_editPazirande(
    { "sanad" : widget.sanad , "namefa": _key1.currentState!.value.toString() + " " + _key2.currentState!.value.toString(),
      "nameen": _key3.currentState!.value.toString() + " " +_key4.currentState!.value.toString(),
      "namefirstfa": _key1.currentState!.value.toString(),
      "namelastfa": _key2.currentState!.value.toString() ,"namefirsten": _key3.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),''),
      "namelasten": _key4.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,"namepedarfa": _key5.currentState!.value.toString() ,
      "foroshgahfa": _key6.currentState!.value.toString() ,"foroshgahen": _key7.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,
      "codemeli": _key8.currentState!.value.toString() ,"tellpish": _key9.currentState!.value.toString() ,
      "tell": _key10.currentState!.value.toString() ,"mobilepish": _key11.currentState!.value.toString(),
      "mobile": _key12.currentState!.value.toString() ,"maliyat": _key13.currentState!.value.toString() ,
      "codeposti": _key14.currentState!.value.toString() , "shenasname": _key15.currentState!.value.toString() ,
      "tavalod": _controller3?.value.text.toString().replaceAll("-", "/") ,"namepedaren": _key17.currentState!.value.toString() ,
      "noe": _controller2?.value.text.toString() ,"gender": _controller1?.value.text.toString()  });
   // print(response);
    if (response == "ok") {
      _showDialog(context);
    }
    else {
      // print("errrror");
    }
  }

  void _showDialog(BuildContext context) {
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
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(textDirection: TextDirection.rtl,
                      child: Text('با موفقیت ثبت شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                    Directionality(textDirection: TextDirection.rtl,
                        child: poses_list_page(widget._Agentdata))));
              },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(width: 1, color: Color(0xff000000),),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text("تایید", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),)
                  ))
            ],
          ),
        );
      },
    );
  }
  void _showDatePicker() async {
    String m = "";
    String d = "";
    final bool showTitleActions = false;
    DatePicker.showDatePicker(context,
        minYear: 1300,
        maxYear: 1401,
        confirm: Text(
          'تایید',
          style: TextStyle(color: Colors.red),
        ),
        cancel: Text(
          'لغو',
          style: TextStyle(color: Colors.cyan),
        ),
        dateFormat: _format, onChanged: (year, month, day) {
          if (!showTitleActions) {
          }
        }, onConfirm: (year, month, day) {
          month! < 10 ? m = ("0$month") : m = ("$month");
          day! < 10 ? d = ("0$day") : d = ("$day");
          _datetime = '$year-$m-$d';
          if (!_datetime.contains("انتخاب"))
          {    _controller3= TextEditingController(text: _datetime.replaceAll("-", "/"));
          }
        });
  }
}
