
// ignore_for_file: missing_return, deprecated_member_use

//import 'package:accordion/accordion.dart';
//////صفحه ای که برای مالیات طراحی شده بود
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/Pazirade/PazirandeAccordian.dart';
import 'package:sima_portal/a_sima_app/Pazirade/PazirandeMaliyatAccordian.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos1.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos11.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeMaliyat-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Pazirade/edit_Pazirande.dart';

import 'EditedStore_page.dart';

class maliyat_list_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  int i;
  maliyat_list_page(this._Agentdata,this.i);
  @override
  State<StatefulWidget> createState() => maliyat_list_pageState();

}

class maliyat_list_pageState extends State<maliyat_list_page> with SingleTickerProviderStateMixin {
  final _headerStyle = TextStyle(
      color: Color(0xffffffff), fontSize: 15, fontWeight: FontWeight.bold);
  final _headerStyleSmall = TextStyle(
      color: Color(0xffffffff), fontSize: 12, fontWeight: FontWeight.bold);
  final _contentStyleHeader = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.w700);
  final _contentStyle = TextStyle(
      color: Color(0xff999999), fontSize: 14, fontWeight: FontWeight.normal);
  final _loremIpsum =
  '''In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available. It is also used to temporarily replace text in a process called greeking, which allows designers to consider the form of a webpage or publication, without the meaning of the text influencing the design.''';
  final _loremIpsum2 =
  '''Lorem ipsum is typically a corrupted version of 'De finibus bonorum et malorum', a 1st century BC text by the Roman statesman and philosopher Cicero, with words altered, added, and removed to make it nonsensical and improper Latin.''';


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<PazirandeMaliyatModel> _data = [];
  List<PazirandeMaliyatModel> _data2 = [];
  final _key4 = GlobalKey<PopupMenuButtonState>();

//  List<PazirandeMaliyatModel> _data3 = [];
  late Map response;
  bool isOpened = false;
late  AnimationController _animationController;
late  Animation<Color> _buttonColor;
late  Animation<double> _animateIcon;
late  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )) as Animation <Color>;
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<List<PazirandeMaliyatModel>> _getData() async {
    //print(widget._Agentdata.last.agentCode + "8" + widget._Agentdata.last.userCode);
    i++;
    if (i < 2) {
      response = await OnlineServices.getMaliyatList({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": widget._Agentdata.last.userCode
      }, widget.i  );
      //  response = await OnlineServices.getPazirandeList({"agentcode" : "10004","usercode" : "0"} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
     //   print(_data[i].emza);

        for (int i = 0; i < _data.length; i++) {

          if (_data[i].name == "" || _data[i].name == null)
            _data[i].name = "بدون نام";
        }
        setState(() {});
        // Future.delayed(const Duration(milliseconds: 1000), () {
        //   setState(() {});});
      }
      else {
        isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar(widget.i == 1 ? "لیست فوری" : "لیست خیلی فوری","", Icons.edit, (){})),

      body: Stack(children: [
        Stack(
          children: [
            Column(
              children: [

                Expanded(child: FutureBuilder<List<PazirandeMaliyatModel>>(
                  future: _getData(),
                  builder: (context,
                      AsyncSnapshot<List<PazirandeMaliyatModel>> snapshot) {
                    if (snapshot.hasData) {
                      return
                        ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PazirandeMaliatAccordion(_data,index,size,widget._Agentdata);
                            });
                    }

                    else if (snapshot.hasError) {
                      return Container();
                    } else
                      return Container();
                  },)

                ),
              ],
            ),
            _data2.length < 1 && isFree == false ?
            Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
        // RaisedButton(onPressed: (){
        //   menu.show (widgetKey: _key4);
        // },key: _key4 ,),

         ],),);
  }




  Future terminal(String sanad) async {
    String response = await (OnlineServices()).terminal({"sanad" : sanad} );
    String ter;
     response = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") ;
     if(response.length < 5)
       ter = "ترمینالی پیدا نشد";
     else
     ter =
         "سریال: " + response.split(",")[0] + "     برند: " + response.split(",")[1] + "\n"
         "مدل: " + response.split(",")[2] + "    ترمینال: " + response.split(",")[3] + "\n"
         "فروشگاه: " + response.split(",")[4];
    _showDialog(context,ter);
  }

  Future hesab(String sanad) async {
    String response = await (OnlineServices()).hesab({"sanad" : sanad} );
    String hes;
    response = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") ;
    if(response.length < 4)
      hes = "حساب پیدا نشد";
    else
      hes =
          "بانک: " + response.split(",")[0] + "     شعبه: " + response.split(",")[1] + "\n"
              "حساب: " + response.split(",")[2] + "\n"
              "شبا: " + response.split(",")[3];
    _showDialog(context,hes);
  }

  Future khata(String sanad) async {
 //   print (sanad);

    String response = await (OnlineServices()).khata({"sanad" : sanad} );
    print("-" +response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") + "-");
    _showDialog(context,response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "").toString());
   //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}

  }

  void _showDialog(BuildContext context , String txt) {
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
                      child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){ Navigator.pop(context);
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
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

/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/register_pos1.dart';
import 'package:sima_portal/a_sima_app/register_pos11.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/edit_Pazirande.dart';

import 'edit_PazirandeH.dart';

class poses_list_page extends StatefulWidget {
  final Function() onPressed;
  final String tooltip;
  final IconData icon;

//  FancyFab({this.onPressed, this.tooltip, this.icon});
  List<AgentModel> _Agentdata = [];
  poses_list_page(this._Agentdata,{this.onPressed, this.tooltip, this.icon});
  @override
  State<StatefulWidget> createState() => poses_list_pageState();

}

class poses_list_pageState extends State<poses_list_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<PazirandeMaliyatModel> _data = [];
  List<PazirandeMaliyatModel> _data2 = [];
//  List<PazirandeMaliyatModel> _data3 = [];
  Map response;
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget add() {
    return Container(
      child: FloatingActionButton(
        heroTag: 2,

        backgroundColor: Color(0x00000000),
        onPressed: null,
        elevation: 0,
        tooltip: 'Add',
        //child: Icon(Icons.add),
      ),
    );
  }

  Widget image() {
    return Container(
      child: FloatingActionButton(
        heroTag: 1,
        backgroundColor: Colors.orangeAccent,

        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: register_pos_page11(widget._Agentdata))));},
        tooltip: 'پذیرنده حقوقی',
        child: Icon(Icons.account_box_outlined,size: 30,),
      ),
    );
  }

  Widget inbox() {
    return Container(
      child: FloatingActionButton(
        heroTag: 3,

        backgroundColor: Color(0xff898989),
        onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: register_pos_page1(widget._Agentdata))));},
        tooltip: 'پذیرنده حقیقی',
        child: Icon(Icons.person,size: 30,),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 4,

        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Future<List<PazirandeMaliyatModel>>_getData() async {
    //print(widget._Agentdata.last.agentCode + "8" + widget._Agentdata.last.userCode);
    i++;
    if (i <2) {
       response = await OnlineServices.getPazirandeList({"agentcode" : widget._Agentdata.last.agentCode,"usercode" : widget._Agentdata.last.userCode} );
    //  response = await OnlineServices.getPazirandeList({"agentcode" : "10004","usercode" : "0"} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        // print(_data.length);
        for (int i = 0 ; i < _data.length ; i++)
        {
          if(_data[i].name == "" || _data[i].name == null)
            _data[i].name = "بدون نام";
        }
        setState(() {});
      }
      else
      {
        isFree = true;
        showInSnackBar();
        setState(() {});
      }
    }
    return _data;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize3 = blockSize * 3;
    double fontSize4 = blockSize * 4;
    double fontSize5 = blockSize * 5;
    double fontSize6 = blockSize * 6;
    double fontSize7 = blockSize * 7;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height-appBarHeight-65;
    double itemHeight = mainHeight * .45;
    double itemWidth = size.width * .45;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: (){
      //      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
      //         register_pos_page1(widget._Agentdata))));
      //   },
      // ),
      appBar: AppBar(
        backgroundColor: Color(0xffffad42),
        brightness: Brightness.light,
        elevation: 6,
        automaticallyImplyLeadingss: false,
        title: ListTile(
          title: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon(Icons.person_outline),
                Text("پذیرنده")
              ],
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: 3,bottom: 3),
            child: CircleAvatar(
              // maxRadius: 30,

              backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
      body: Stack(children: [
        Stack(
          children: [
            Column(
              children: [
                Container(
                    padding: EdgeInsets.only(right: 20),
                    width: size.width * .9,
                    child: TextFormField(
                      onChanged:(txt) {
                        //srch = txt;
                        //_getData2();
                        if(txt.length > 0)
                        {
                          _data.clear();
                          _data.addAll(response['data']);
                          for (int i = 0 ; i < _data.length ; i++)
                          {
                            if(_data[i].name == "" || _data[i].name == null)
                              _data[i].name = "بدون نام";
                          }
                          _data.removeWhere((element) => !element.name.contains(txt.toString())) ;
                          setState(() {});
                        }

                      },
                      style: const TextStyle(
                        color: Color(0xbb000000),
                      ),
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white
                              )
                          ),

                          hintText: "جستجو",
                          hintStyle: const TextStyle(color: Color(0x55000000) , fontSize: 16),
                          contentPadding: const EdgeInsets.only(
                              top: 11 , right: 0 , bottom: 10 , left: 5
                          )
                      ),
                    )),
                Expanded(child: FutureBuilder<List<PazirandeMaliyatModel>>(future: _getData(),
                  builder: (context, AsyncSnapshot<List<PazirandeMaliyatModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                          });

                    }
                    else if (snapshot.hasError) {return Container();} else return Container() ;},)

                ),
              ],
            ),
            _data2.length < 1 && isFree == false ?
            Center(child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height*.4,),
SpinKitThreeBounce(color: Color(0xffffa625)),
                SizedBox(height: 10,),
                Text("لطفا صبر کنید" , style: TextStyle(fontSize: fontSize4,color: Colors.black),)
              ],
            ) )
                : SizedBox()
          ],
        ),

       Padding(padding: EdgeInsets.only(right: 20,bottom: 20), child:
       Column(
         mainAxisAlignment: MainAxisAlignment.end,
         children: <Widget>[
           Transform(
             transform: Matrix4.translationValues(
               0.0,
               _translateButton.value * 3.0,
               0.0,
             ),
             child: add(),
           ),
           Transform(
             transform: Matrix4.translationValues(
               0.0,
               _translateButton.value * 2.0,
               0.0,
             ),
             child: image(),
           ),
           Transform(
             transform: Matrix4.translationValues(
               0.0,
               _translateButton.value,
               0.0,
             ),
             child: inbox(),
           ),
           toggle(),
         ],
       ),)

        // Container(
        //   child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
        //     Buttons("مشتری حقیقی" , register_pos_page1(widget._Agentdata)),
        //     Buttons("مشتری حقوقی" , register_pos_page1(widget._Agentdata)),
        //   ],),
        //   height: size.height , width: size.width,
        //   decoration: BoxDecoration(
        //     color: Color(0xbb000000)
        //   ),
        // )
      ],),);
  }

  Widget Buttons(String title, Widget page){
    var size = MediaQuery.of(context).size;

    return Container(

      margin: EdgeInsets.only(
          top: 0, right: size.width * .1, left: size.width * .1),
      padding: const EdgeInsets.only(
          top: 20, right: 50, left: 50),
      width: double.infinity,
      child: RaisedButton(
        padding: const EdgeInsets.symmetric(
            vertical: 30.0),
        color: const Color(0x77ffffff),
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: page)));
        },
        elevation: 11,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(10.0))),
        child: Text(title,
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w800
            )),
      ),
    );
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return
      Container(
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Expanded(child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].name == null ? "-" : _data[index].name,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(child: Text( _data[index].name2 == null ? "-" :  _data[index].name2,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3))),

                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone_iphone,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(_data[index].mobile == null ? "-" : _data[index].mobile,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),

                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.album,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text( _data[index].senf,
                              style: TextStyle(
                                  color: primary, fontSize: 13, letterSpacing: .3)),
                        ),
                      ],
                    ),

                  ],

                )),
                 Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].status,
                            style: TextStyle(
                                color: _data[index].status.toString().contains("اصلاح") ? Colors.red : primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.local_atm,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].sanad,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(_data[index].soeich == null ? "-" : _data[index].soeich ,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(child: Text( "نوع پذیرنده: " +  _data[index].noe,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3))),

                      ],
                    ),
                  ],

                )),

              ],
            ),
          //  SizedBox(height: 6),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(child: ElevatedButton(onPressed: (){

                khata(_data[index].sanad);
                },
                    child: Container(
                        padding: EdgeInsets.only(top:5,bottom: 5,right: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xaa00b831),
                          border: Border.all(width: 1,color: Color(0xff00b831),),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  border: Border(color: Colors.black, width: 1.0),
                        ),
                        //  color: Colors.lightBlueAccent,
                        width: size.width * .3,
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 4),child: Icon(Icons.warning,color: Colors.white,),) ,
                            Text("نمایش خطا",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),)
                          ],
                        )
                    )),
                  visible: _data[index].status.toString().contains("اصلاح") ? true : _data[index].status.toString().contains("بررسی") ? true : false,),
                Visibility(child: ElevatedButton(onPressed: (){
                  _data[index].noe == "حقیقی" ?
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: edit_registerPos(_data[index].sanad.toString(),widget._Agentdata))))
                  : Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: edit_registerPosH(_data[index].sanad.toString(),widget._Agentdata))));

                },
                      child: Container(
                          padding: EdgeInsets.only(top:5,bottom: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xaaff6e54),
                            border: Border.all(width: 1,color: Color(0xffff6e54),),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            //  border: Border(color: Colors.black, width: 1.0),
                          ),
                          //  color: Colors.lightBlueAccent,
                          width: size.width * .3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(padding: EdgeInsets.only(left: 0),child: Icon(Icons.edit,color: Colors.white,),) ,
                              Text("ویرایش",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 16),)
                            ],
                          )
                      )),
                  visible: _data[index].status.toString().contains("اصلاح")  ? true : _data[index].status.toString().contains("بررسی") ? true : false,),

              ],
            ),
            SizedBox(height: 6),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Visibility(child: ElevatedButton(onPressed: (){

                  terminal(_data[index].sanad);
                },
                    child: Container(
                        padding: EdgeInsets.only(top:5,bottom: 5,right: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xaa00b831),
                          border: Border.all(width: 1,color: Color(0xff00b831),),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  border: Border(color: Colors.black, width: 1.0),
                        ),
                        //  color: Colors.lightBlueAccent,
                        width: size.width * .3,
                        child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 4),child: Icon(Icons.title,color: Colors.white,),) ,
                            Text("ترمینال",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),)
                          ],
                        )
                    )), visible: true),
                Visibility(child: ElevatedButton(onPressed: (){
                  hesab(_data[index].sanad);

                },
                    child: Container(
                        padding: EdgeInsets.only(top:5,bottom: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Color(0xaaff6e54),
                          border: Border.all(width: 1,color: Color(0xffff6e54),),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          //  border: Border(color: Colors.black, width: 1.0),
                        ),
                        //  color: Colors.lightBlueAccent,
                        width: size.width * .3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(padding: EdgeInsets.only(left: 0),child: Icon(Icons.arrow_drop_down_circle,color: Colors.white,),) ,
                            Text("حساب",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 16),)
                          ],
                        )
                    )), visible: true),

              ],
            ),

          ],
        )
    );
  }
  Future terminal(String sanad) async {
    String response = await (OnlineServices()).terminal({"sanad" : sanad} );
    String ter;
     response = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") ;
     if(response.length < 5)
       ter = "ترمینالی پیدا نشد";
     else
     ter =
         "سریال: " + response.split(",")[0] + "     برند: " + response.split(",")[1] + "\n"
         "مدل: " + response.split(",")[2] + "    ترمینال: " + response.split(",")[3] + "\n"
         "فروشگاه: " + response.split(",")[4];
    _showDialog(context,ter);
  }

  Future hesab(String sanad) async {
    String response = await (OnlineServices()).hesab({"sanad" : sanad} );
    String hes;
    response = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") ;
    if(response.length < 4)
      hes = "حساب پیدا نشد";
    else
      hes =
          "بانک: " + response.split(",")[0] + "     شعبه: " + response.split(",")[1] + "\n"
              "حساب: " + response.split(",")[2] + "\n"
              "شبا: " + response.split(",")[3];
    _showDialog(context,hes);
  }

  Future khata(String sanad) async {
 //   print (sanad);

    String response = await (OnlineServices()).khata({"sanad" : sanad} );
    print("-" +response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "") + "-");
    _showDialog(context,response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "").toString());
   //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}

  }

  void _showDialog(BuildContext context , String txt) {
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
                      child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){ Navigator.pop(context);
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
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

  void showInSnackBar() {
    _scaffoldKey.currentState!.removeCurrentSna();
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
        content: Row(
          children: [
            Icon(Icons.warning),
            SizedBox(width: 6),
            Text("اطلاعاتی برای نمایش وجود ندارد")
          ],
        )
    ));
  }
}

 */