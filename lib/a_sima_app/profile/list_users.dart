
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/usersModel.dart';
import 'package:sima_portal/a_sima_app/profile/new_user.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';

import '../models/usersModel2.dart';

class users_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  users_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() =>  register_pos_pageState();
}

class register_pos_pageState extends State<users_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late Map response;
  List<UserModel2> _data = [];
 // bool isFree = false;
  final _key1 = GlobalKey<FormFieldState>();

  int i = 0;
  @override
  void initState()  {
    super.initState();
   }
  Future _deleteImageFromCache(String URL) async {
    String url = URL;
    await CachedNetworkImage.evictFromCache(url);
  }


  Future<List<UserModel2>>_getData() async {
    //print(widget._Agentdata.last.agentCode + "8" + widget._Agentdata.last.userCode);
    i++;
    if (i <2) {
      response = await OnlineServices.getUserList2({"agentcode" : widget._Agentdata.last.agentCode} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
          setState(() { });
      }
      else
      {
        //isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: newUser(widget._Agentdata)))
            );
          },
        ),
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست کاربران فعال","", Icons.edit, (){})),

        key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      body: Stack(

        children: [
          FutureBuilder<List<UserModel2>>(future: _getData(),
            builder: (context, AsyncSnapshot<List<UserModel2>> snapshot) {
              if (snapshot.hasData) {
                return
                  ListView.builder(
                      itemCount: _data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return buildList(context , index);
                      });
              }

              else if (snapshot.hasError) {return Container();} else return Container() ;},),

        ],
      )
    );
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 5;
    _deleteImageFromCache("https://sima-pay.com//upload/Image/Agent/${widget._Agentdata.last.agentCode}${_data[index].usercode}.jpg");

    //print("https://pos.sima-pay.com//upload/Image/Agent/${widget._Agentdata.last.agentCode}${_data[index].usercode}.jpg");
    return
      Container(
          alignment: Alignment.topRight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            //      color: Color(0xffffffff),
          ),
          width: size.width * 0.7,
          // height: 110,
          margin: EdgeInsets.only(right: 8 ,top: 0),
          padding: EdgeInsets.only(right: 5, left: 5,top: 10, bottom: 10),
          child: ListTile(

            contentPadding: EdgeInsets.only(right: 6),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            //isThreeLine: true,
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text("نام: " + _data[index].name,style: TextStyle(fontSize: 13,fontWeight: FontWeight.w600),),
                SizedBox(height: 6,),

                Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: size.width * .33,child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("پرونده: " + _data[index].takhsis,style: TextStyle(fontSize: 13),),
                      SizedBox(height: 6,),
                      Text("فعال: " + _data[index].faal,style: TextStyle(fontSize: 13),),

                    ],
                  ),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("اصلاح: " +_data[index].eslah,style: TextStyle(fontSize: 13),),
                      SizedBox(height: 6,),

                      Text("آماده تخصیص: " + _data[index].takhsis,style: TextStyle(fontSize: 13),),
                    ],
                  ),
                ],
              ),
                _data[index].usercode != "0" ? ElevatedButton(onPressed: (){_SetTargetDialog(_data[index].usercode);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal),), child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("تعیین هدف"),
                    const SizedBox(width: 20,),
                    Image.asset("assets/images/target.png",height: 20, color: Colors.white,),
                    Text("  ${_data[index].target}",
                      style: TextStyle(fontSize: 13),),
                  ],
                )) : ElevatedButton(onPressed: null,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                    0x3000000)),elevation: MaterialStateProperty.all(0),), child: Center())
                //ElevatedButton(onPressed: (){},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent),foregroundColor:MaterialStateProperty.all(Colors.transparent) ), child: Center(),),
            ],
            ),

            tileColor: Color(0x11000000),
            title: Row(
              children: [
              ],
            ),
            leading: Column(
              children: [
                ClipOval(
                    child: Material(
                        child: InkWell(
                            child: SizedBox(
                                width: size.width * .16,
                                height: size.width * .16,
                                child: CachedNetworkImage(
                                  //imageUrl: _data[index].imgURL,
                                  imageUrl: "https://sima-pay.com//upload/Image/Agent/${widget._Agentdata.last.agentCode}${_data[index].usercode}.jpg",

                                placeholder: (context, url) =>
                                      Image.asset("assets/images/person.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset("assets/images/person.png"),
                                ))))),
                Text(_data[index].usercode.toPersianDigit(),style: TextStyle(color: Colors.teal,fontWeight: FontWeight.w700,fontSize: 19,decoration: TextDecoration.underline,),)
              ],
            ),
          )
      )
    ;
  }
  void _SetTargetDialog(String code) async {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Text(
                    "ثبت هدف این ماه",
                    textAlign: TextAlign.center,
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black87,
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(hintText: "تعداد"),
                          key: _key1,
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Text(
                      "     لغو     ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_key1.currentState!.value.toString().isNotEmpty ) {
                        targetSetReq(code);

                        Navigator.pop(context);
                      } else
                        Comp.showSnackError(context);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    child: Text(
                      "   ارسال   ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
              ],
            );
          },
        );
      },
    );
  }

  void targetSetReq(String code) async {
    if(_key1.currentState!.value.toString().isNotEmpty )
    {
      String response = await OnlineServices.setTargetRequest({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": code,
        "target": _key1.currentState!.value.toString(),
      });

      if (response.contains("ok")) {
        CoolAlert.show(
            context: context,
            confirmBtnText: "   بستن  ",
            type: CoolAlertType.success,
            title: "",
            backgroundColor: Colors.white,
            onConfirmBtnTap: (){
              i=0;
              _getData();

              Navigator.pop(context);},
            text: "هدف شما ثبت شد",
        );      // print("______________________");
      } else {
        // print("__________asdasd____________");
      }
    }else Comp.showSnackEmpty(context);
  }

  Future<String> getIMG(String code) async {
    String response = await OnlineServices.getIMG(
        {"agentcode" : widget._Agentdata.last.agentCode, "usercode" : code} );return response;}
}