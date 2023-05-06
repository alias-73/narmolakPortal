import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

class edit_registerPosH extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  String sanad;
  edit_registerPosH(this.sanad, this._Agentdata);
  @override
  State<StatefulWidget> createState() => edit_registerPosState();
}

class edit_registerPosState extends State<edit_registerPosH> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  final _key3 = GlobalKey<FormFieldState>();
  final _key4 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final _key6 = GlobalKey<FormFieldState>();
  final _key7 = GlobalKey<FormFieldState>();
  final _key8 = GlobalKey<FormFieldState>();
  final _key9 = GlobalKey<FormFieldState>();
  String data = "0" ;


  Color bcTextColor = Color(0x22000000);
  Color textColor = Color(0xbb000000);
  @override
  void initState() {
  //  print(widget.sanad);
    get_editPazirandeh();
    super.initState();
  }
  void get_editPazirandeh() async {
    String response = await OnlineServices.get_editPazirandeH({"sanad": widget.sanad});
    data = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    double widthItem = size.width * .8;
    return SafeArea(child: Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("ویرایش پذیرنده حقوقی","", Icons.edit, (){})),

     // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              //width: size.width * .8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 15,),
                  data.length > 1 ? Comp.editBox5(context, 1, 14, "شناسه ملی", Icons.drive_file_rename_outline, _key1, data.split(",")[0].isEmpty ? "-" : data.split(",")[0]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام شرکت فارسی", Icons.title, _key2, data.split(",")[1].isEmpty ? "" : data.split(",")[1]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 1, 0, "نام شرکت انگلیسی", Icons.title, _key3, data.split(",")[2].isEmpty ? "" : data.split(",")[2]) : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 12, "کد اقتصادی", Icons.drive_file_rename_outline, _key4, data.split(",")[3].isEmpty ? "" : data.split(",")[3]) : Center(),
                  data.length > 1 ? Comp.editBox6(context,2,3,8, "کد شهر","تلفن ثابت", Icons.phone, _key5, _key6,data.split(",")[5].isEmpty ? "": data.split(",")[5], data.split(",")[4].isEmpty ? "" : data.split(",")[4])  : Center(),
                  data.length > 1 ? Comp.editBox6(context,2,4,7, "پیش شماره","شماره همراه", Icons.phone_iphone, _key7, _key8, data.split(",")[7].isEmpty ? "" : data.split(",")[7],data.split(",")[6].isEmpty ? "" : data.split(",")[6])  : Center(),
                  data.length > 1 ? Comp.editBox5(context, 2, 10, "کد پستی", Icons.drive_file_rename_outline, _key9, data.split(",")[8].isEmpty ? "" : data.split(",")[8]) : Center(),

                  // buildList(context, "کد شهر", TextInputType.number, 4, _key5, 3),
                  // buildList(context, "تلفن", TextInputType.number, 5,_key6, 8),
                  // buildList(context, "پیش شماره", TextInputType.number,6 , _key7, 4),
                  // buildList(context, "موبایل", TextInputType.number,7 , _key8, 7),
                  // buildList(context, "کد پستی", TextInputType.number,8 , _key9, 10),
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
/*
      print(_key1.currentState!.value.toString().length);
      print(_key2.currentState!.value.toString().length);
      print(_key3.currentState!.value.toString().length);
      print(_key4.currentState!.value.toString().length);
      print(_key5.currentState!.value.toString().length);
      print(_key6.currentState!.value.toString().length);
      print(_key7.currentState!.value.toString().length);
      print(_key8.currentState!.value.toString().length);
      print(_key9.currentState!.value.toString().length);
      print(_key10.currentState!.value.toString().length);
      print(_key11.currentState!.value.toString().length);
      print(_key12.currentState!.value.toString().length);
      print(_key13.currentState!.value.toString().length);
      print(_key14.currentState!.value.toString().length);
 */
  void fun(){
    print(_key1.currentState!.value.toString().length);
    print(_key2.currentState!.value.toString().length);
    print(_key3.currentState!.value.toString().length);
    print(_key4.currentState!.value.toString().length);
    print(_key5.currentState!.value.toString().length);
    print(_key6.currentState!.value.toString().length);
    print(_key7.currentState!.value.toString().length);
    print(_key8.currentState!.value.toString().length);
    print(_key9.currentState!.value.toString().length);
    if (_key1.currentState!.value.toString().length > 3 &&
        _key2.currentState!.value.toString().length > 1 &&
        _key3.currentState!.value.toString().length > 1 &&
        _key4.currentState!.value.toString().length > 4 &&
        _key5.currentState!.value.toString().length == 3 &&
        _key6.currentState!.value.toString().length == 8 &&
        _key7.currentState!.value.toString().length == 4 &&
        _key8.currentState!.value.toString().length == 7 &&
        _key9.currentState!.value.toString().length == 10
    ) send_editPazirande();
    else Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  void send_editPazirande() async {
    String response ;
    response = await (OnlineServices()).send_editPazirandeH(
        {"sanad" : widget.sanad , "meli": _key1.currentState!.value.toString(), "namefa": _key2.currentState!.value.toString()  ,"nameen": _key3.currentState!.value.toString().replaceAll(RegExp(r'[^\w\s]+'),'') ,"eqtesadi": _key4.currentState!.value.toString() ,"tellpish": _key5.currentState!.value.toString() ,"tell": _key6.currentState!.value.toString() ,"mobilepish": _key7.currentState!.value.toString() ,"mobile": _key8.currentState!.value.toString() ,"codeposti": _key9.currentState!.value.toString()  });
  //  print(response);
    if (response== "ok")
    {
      _showDialog(context);
    }
    else{
     // print("errrror");
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: poses_list_page(widget._Agentdata))));
              },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4,bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(width: 1,color: Color(0xff000000),),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text("تایید",style: TextStyle(
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
}
