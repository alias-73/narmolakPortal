
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/jaygozini/list_jaygozini.dart';
import 'package:sima_portal/a_sima_app/Moaref/list_moaref.dart';
import 'package:sima_portal/a_sima_app/list_riz.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis.dart';
import 'package:sima_portal/a_sima_app/Pazirade/list_pazirande.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Hesab/list_hesab.dart';
import 'dart:ui';

import 'models/PersonalMessageModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
class info_page extends StatefulWidget {
  List<AgentModel> _data = [];
  info_page(this._data);
  @override
  State<StatefulWidget> createState() => infoState();

}

class infoState extends State<info_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 2;
  List<PersonalMessageModel> _message = [];
  String msg = " s";
 late String add;

  @override
  void initState() {
    // TODO: implement initState

    checkIsTodayVisit();
    super.initState();
  }

  Future<String> getIMG() async {
    String response = await OnlineServices.getIMG(
        {"agentcode" : widget._data.last.agentCode, "usercode" : widget._data.last.userCode} );return response;}


  Future<String> getName() async {
    String response = await OnlineServices.getName(
        {"agentcode" : widget._data.last.agentCode, "usercode" : widget._data.last.userCode} );return response;}

    Future<String> getPazirandeAllCount() async {
    String response = await OnlineServices.getPazirandeAllCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode, "usercode" : widget._data.last.userCode} );
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response;
  }
  Future<String> getPazirandeEslahCount() async {
    print(widget._data.last.agentCode);
    print(widget._data.last.userCode);
    String response = await OnlineServices.getPazirandeEslahCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    return response;
  }
  Future<String> getPazirandeLaghvCount() async {
    String response = await OnlineServices.getPazirandeLaghvCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    return response;
  }

  Future<String> getTakhsisAllCount() async {
    String response = await OnlineServices.getTakhsisAllCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response;
  }
  Future<String> getTakhsisReadyCount() async {
    String response = await OnlineServices.getTakhsisReadyCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    return response;
  }

  Future<String> getDeviceAllCount() async {
    String response = await OnlineServices.getDeviceAllCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    //  print(response.split("-")[0] + "*" + response.split("-")[1] + "*" + response.split("-")[2] );
    return response;
  }
  Future<String> getDeviceFreeCount() async {
    String response = await OnlineServices.getDeviceFreeCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    return response;
  }
  Future<String> getDeviceNewCount() async {
    String response = await OnlineServices.getDeviceNewCount(
      //{"agentcode" : widget._data.last.agentCode } );
        {"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode} );
    return response;
  }

  @override
  Widget build(BuildContext context) {
    //print("__" + widget._data.last.userCode + "__");
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight;
    double itemHeight = mainHeight * .45;
    double itemWidth = size.width * .45;
    double h = .13;
   // print(widget._data.last.userCode);
   // print(widget._data.last.agentCode);

    return SafeArea(child: Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0x00000000),
                // image: DecorationImage(image: AssetImage("assets/images/Logo_Sima_Cart.gif"))
              ),
              height: mainHeight * .4,
              child: FutureBuilder<String>(
                future: getImg(),
                builder:
                    (context, AsyncSnapshot<String> snapshot) {
                  // print("-----"+snapshot.data!.toString());
                  if (snapshot.hasData) {
                    //  List<News> _news2 = snapshot.data!;
                    return
                      //   NetworkImage(snapshot.data!.toString());
                      CachedNetworkImage(
                        imageUrl:
                        snapshot.data!.toString(),
                        //   "http://2.180.21.222/PasargadAcc/pos/agentimg/${100040}.png",
                        placeholder: (context, url) =>
                            Image.asset("assets/images/person.png"),
                        errorWidget: (context, url, error) =>
                            Image.asset("assets/images/person.png"),
                      );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else
                    return Container();
                },
              ),

            ),
            Positioned(child: Padding(child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(" "),
                  Text("نسخه 1.3.2.1"),

                ]),padding: EdgeInsets.only(left: 0,top: 0),), top: 5,left: 0,)
          ],
        ),
        Container(padding: EdgeInsets.zero,margin: EdgeInsets.only(right: 10,top: 0),alignment: Alignment.centerRight,
          height: mainHeight * .15,
          // color: Colors.blue,
          child: FutureBuilder<String>(future: getName(),
            builder: (context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data!, style: TextStyle(
                    fontSize: 30, color: Colors.black,fontWeight: FontWeight.w600),);
              }
              else if (snapshot.hasError) {
                return Container();
              } else
                return Container();
            },)
        ),
        Container(
          height: mainHeight * .3,
          // color: Colors.blue,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              itemInfo1( 1 , "پذیرنده" , "کل" , "فعال" , "اصلاح" , getPazirandeAllCount ,getPazirandeLaghvCount, getPazirandeEslahCount ),
              itemInfo1( 2 , "تخصیص" , "کل" , "منتظر" , "" , getTakhsisAllCount ,getTakhsisReadyCount , getTakhsisReadyCount  ),
              itemInfo1( 2 , "EM" , "کل" , "باز" , "" , getDeviceAllCount ,getDeviceFreeCount , getDeviceFreeCount  ),

            ],
          ),
        ),
        widget._data.last.userCode == "0" ? Container(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          height: mainHeight * .15,
          width: size.width,
          decoration: BoxDecoration(

            color: Color(0xffffad42),
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            //border: Border.all(color: Color(0xffffffff))
          ),
          // color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(mainAxisAlignment:MainAxisAlignment.center,children: [

                Text("صورتحساب ریزتراکنش",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 20),),
                Text("جزئیات فاکتورهای درآمد نماینده",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12),),

              ],),
              Image.asset("assets/images/bag.png",height :mainHeight * .15 * .4 ,),
            ],
          ),
        ) : Container(),
      ],),
    ),
    );
  }

  Future<String> getImg() async {
    String response = await OnlineServices.getImg({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //print (await response);
    return response;
  }

  Widget itemInfo1(int tag ,String title, String title1, String title2, String title3, Function function1 , Function function2 , Function function3 ){
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double fontSize5 = blockSize * 5;
    double fontSize7 = blockSize * 7;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight;
    double itemHeight = mainHeight * .26;
    Color bcItemColor1 = Color(0xffffffff);
    Color bcItemColor2 = Color(0xaad81b60);
    Color color = Color(0xff321654);
    Widget w = Center();
    var fSize1 = fontSize4;
    var titleSize = fontSize7;
    if(tag == 1) {
      w = Container(
        alignment: Alignment.center,
        height: itemHeight,

        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 8, right: 2, left: 14),
        width: size.width * .76,
        decoration: BoxDecoration(

            color: bcItemColor1,
            borderRadius: BorderRadius.all(Radius.circular(11)),
            border: Border.all(color: Color(0xffffffff))
        ),
        child:  Column(
          //mainAxisAlignment: MainAxisAlignment.s,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
              style: TextStyle(fontSize: titleSize,fontWeight: FontWeight.w600, color: Colors.black),),
            Divider(color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [

                    Text(title1, style: TextStyle(
                        fontSize: fontSize4, color: Colors.black),),
                    FutureBuilder<String>(future: function1(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!, style: TextStyle(
                              fontSize: fSize1, color: Colors.black,fontWeight: FontWeight.w600),);
                        }
                        else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },),
                  ],
                ),
                Column(
                  children: [

                    Text(title2, style: TextStyle(
                        fontSize: fontSize4, color: Colors.black),),
                    FutureBuilder<String>(future: function2(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!, style: TextStyle(
                              fontSize: fSize1, color: Colors.black,fontWeight: FontWeight.w600),);
                        }
                        else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },),
                  ],
                ),
                Column(
                  children: [

                    Text(title3, style: TextStyle(
                        fontSize: fontSize4, color: Colors.black),),
                    FutureBuilder<String>(future: function3(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!, style: TextStyle(
                              fontSize: fSize1, color: Colors.black,fontWeight: FontWeight.w600),);
                        }
                        else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },),
                  ],
                ),


              ],
            )


          ],
        ),
      );
    }
    else if(tag == 2)
    {
      w=  Container(
        alignment: Alignment.center,
        height: itemHeight,

        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(top: 8, right: 2, left: 14),
        width: size.width * .76,
        decoration: BoxDecoration(

            color: bcItemColor1,
            borderRadius: BorderRadius.all(Radius.circular(11)),
            border: Border.all(color: Color(0xffffffff))
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.s,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(title,
              style: TextStyle(fontSize: titleSize,fontWeight: FontWeight.w600, color: Colors.black),),
            Divider(color: Colors.black,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [

                    Text(title1, style: TextStyle(
                        fontSize: fontSize4, color: Colors.black),),
                    FutureBuilder<String>(future: function1(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!, style: TextStyle(
                              fontSize: fSize1, color: Colors.black,fontWeight: FontWeight.w600),);
                        }
                        else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },),
                  ],
                ),

                Column(
                  children: [

                    Text(title2, style: TextStyle(
                        fontSize: fontSize4, color: Colors.black),),
                    FutureBuilder<String>(future: function3(),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return Text(snapshot.data!, style: TextStyle(
                              fontSize: fSize1, color: Colors.black,fontWeight: FontWeight.w600),);
                        }
                        else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },),
                  ],
                ),


              ],
            )


          ],
        ),
      );
    }
    return w;

  }


  Widget items(BuildContext, String title, String ic, Color c, Widget w) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
   // dynamic w = list_moaref_page(widget._data);
    double fontSize9 = blockSize * 9;
    double fontSize10 = blockSize * 15;
    double fontSize7 = blockSize * 7;
    double fontSize6 = blockSize * 6;
    double h = 0.2;
    double icSize = size.width * 0.15;
    double icSize2 = size.width * 0.25;

    Color bcItemColor1 = c;
    Color textColor = Color(0xbb000000);
    Color color = Color(0xff321654);
    return GestureDetector(child: Container(
    //  alignment: Alignment.center,
      height: (size.height-statusBarHeight) * .25,
      width: size.width * 0.5,
     // padding: EdgeInsets.only(top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: bcItemColor1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: c,
            alignment: Alignment.center,
            child: ic=="assets/images/takhsis.png" ?Image.asset(ic,height: icSize2, width: icSize2, ) : ic=="assets/images/replace.png" ? Image.asset(ic,height: icSize2, width: icSize2, ) : Image.asset(ic,height: icSize, width: icSize, ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: fontSize7, color: Colors.white),
          ),
          //Divider(height: 3, color: Colors.black,),
        ],
      ),
    ),onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: w)));},);
  }

  removee() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences preferences = await _prefs;
    preferences.remove("mDateKey");
  }
  checkIsTodayVisit() async {
    //await removee();
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    SharedPreferences preferences = await _prefs;
    Object? lastVisitDate = preferences.get("mDateKey");

    String toDayDate = DateTime.now().day.toString(); // Here is you just get only date not Time.

    if (toDayDate == lastVisitDate) {
      // print("++++++++++++++++++++++++++++++++++++++++++++" + toDayDate);

    } else {
      //print("____________________________________________");
      getPersonalMessage();

      preferences.setString("mDateKey", toDayDate);
    }
  }
  void _showDialog2(BuildContext context) {

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
                      child: Text(msg))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                // SystemNavigator.pop();
                //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_page(widget._Agentdata))));
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
                      child: Text("باشه",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),)
                  )),

            ],
          ),
        );
      },
    );
  }

  void getPersonalMessage() async {
    Map response;
    response = await OnlineServices.getPersonalMessagee( { "agentcode" : widget._data.last.agentCode , "usercode": widget._data.last.userCode  });
    if (response["data"] != "free") {
      _message.clear();
      _message.addAll(response['data']);
      print(_message.last.message);
      msg = _message.last.message;
      _showDialog2(context);
      setState(() {});

    }
    else
    {
      print("freeeeeee");
    }

  }
}