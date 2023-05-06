
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/questionModel.dart';
import 'QuestionAccordian.dart';

class support_center extends StatefulWidget {
  List<AgentModel> _data = [];support_center(this._data);
  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<support_center> {
  bool _showContent1 = false;
  bool _showContent2 = false;
  final primary = Color(0xff000000);
  late String today = "";
  late String datetime = "";

  final secondary = Color(0xff26A1FF);
  double fontSize1 = 15;
  double fontSize2 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
  int i = 0;

  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  List<QuestionModel> _data = [];
  List<QuestionModel> _data2 = [];
  late Map response;
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        // Here you can write your code for open view
      });
    });
    _getQuestions();
    super.initState();
  }

  Future<List<QuestionModel>>_getQuestions() async {
    //print(widget._Agentdata.last.agentCode + "8" + widget._Agentdata.last.userCode);
    i++;
    if (i <2) {
      response = await OnlineServices.getQuestions();
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);

      }
    }
    return _data;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xffe3e3e3),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("مرکز پشتیبانی","", Icons.edit, (){})),
      body:
      SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10,),
          Container(
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
              ),
              width: double.infinity,
              // height: 110,
              margin: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
              padding: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
              child: Column(
                children: [

                  Align(child: Text( "   ارتباط با پشتیبانی",
                      textAlign: TextAlign.right,style: TextStyle(
                          color: primary, fontSize: fontSize1+2, fontWeight: FontWeight.w500)),alignment: Alignment.centerRight,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      item("تماس تلفنی", Icons.call, Color(0xff1684fc)),
                      item("ثبت شکایت", Icons.message, Color(0xff09cc55)),
                    ],
                  ),
                  SizedBox(height: 10,),

                ],
              ),
          ),

          SizedBox(height: 10,),
          SizedBox(height: (_data.length+1 ) * size.height * .11,child:
          FutureBuilder<List<QuestionModel>>(future: _getQuestions(),
            builder: (context, AsyncSnapshot<List<QuestionModel>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: _data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return QuestionAccordian(_data, index, size);
                    });

              }
              else if (snapshot.hasError) {return Container();} else return Container() ;},)),
          SizedBox(height: 10,),



        ],
      ),
      ),

    );
  }


  Widget item(String title, IconData ic , Color c){
    var size = MediaQuery.of(context).size;
    String tel = "";
    widget._data.last.agentCode == "10070" ? tel = "09393768532" :
    widget._data.last.agentCode == "10145" ? tel = "09051178297" :
                                             tel = "05136108585" ;

    return SizedBox(
      width: size.width * .4,
      child: Column(children: [
        FloatingActionButton(backgroundColor: c,onPressed: (){
          title.contains("تماس")?
          UrlLauncher.launch("tel://${tel}") :
          _enteqadDialog();
        },
          child: Icon(ic,color: Colors.white,),),
        SizedBox(height: 10,),

        Text( title,
            textAlign: TextAlign.right,style: TextStyle(
                color: primary, fontSize: fontSize1+2, fontWeight: FontWeight.w500)),
      ]),
    );
  }

  void _enteqadDialog() async {
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
                    "ثبت شکایت، پیشنهاد و انتقاد",
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
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "موضوع"),
                          key: _key1,
                        )),
                    SizedBox(height: 30),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          maxLines: 2,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "توضیحات"),
                          key: _key2,
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
                      if (_key1.currentState!.value.toString().isNotEmpty &&
                          _key2.toString().length > 1) {
                        Navigator.pop(context);
                        shekayatReq();
                      } else
                        Comp.showSnackError2(context);
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

  void shekayatReq() async {
    
    if(_key1.currentState!.value.toString().length > 1 && _key1.currentState!.value.toString().length > 1 )
      {
        String response = await OnlineServices.shekayatRequest({
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode,
          "tarikh": today,
          "onvan": _key1.currentState?.value.toString(),
          "sharh": _key2.currentState!.value.toString(),
        });
        if (response.contains("ok")) {
          CoolAlert.show(
              context: context,
              confirmBtnText: "   بستن  ",
              type: CoolAlertType.success,
              title: "پیام شما ارسال شد",
              backgroundColor: Colors.white,
              onConfirmBtnTap: (){
                Navigator.pop(context);},
              text: "با تشکر از ثبت نظر شما"
          );      // print("______________________");
        } else {
          // print("__________asdasd____________");
        }
      }else Comp.showSnackEmpty(context);
  }

  Widget questions2(){
    var size = MediaQuery.of(context).size;

    return GestureDetector(onTap:(){
      setState(() {
        _showContent2 = !_showContent2;
      });},child: Card(
      margin: EdgeInsets.only(bottom: 5,top: 10, right: 10, left: 10),
      child: Column(children: [
        ListTile(
            title:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: (size.width-10) * .49,
                  child: Text( "پرسشهای متداول",
                      textAlign: TextAlign.center,style: TextStyle(
                          color: primary, fontSize: fontSize1, fontWeight: FontWeight.w500)),),
                Row(
                  children: [
                    RotatedBox(
                        quarterTurns: _showContent2 ? 1 : 2,
                        child: Icon(Icons.arrow_back_ios_rounded))

                  ],
                )
              ],
            )
        ),
        _showContent2
            ? Column(children: [
          Padding(child: Divider(height: 0,color: Color(0xff000000),),padding: EdgeInsets.only(right: 20,left: 20,bottom: 4),),
          Container(
            height: _data.length * (size.height * .1),
              alignment: Alignment.topRight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.white,
              ),
              width: double.infinity,
              // height: 110,
              margin: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
              padding: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
              child: FutureBuilder<List<QuestionModel>>(future: _getQuestions(),
                builder: (context, AsyncSnapshot<List<QuestionModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return itmQuestion( index);
                        });

                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)
          )
        ])
            : Container()
      ]),
    ),);
  }

  Widget itmQuestion(int index){
    var size = MediaQuery.of(context).size;

    return Container(
      height: size.height * .1,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text( _data[index].title,
                textAlign: TextAlign.right,style: TextStyle(
                    color: primary, fontSize: fontSize1+2, fontWeight: FontWeight.w500)),
            SizedBox(height: 10,),
            Text(_data[index].desc,
                textAlign: TextAlign.right,style: TextStyle(
                    color: primary, fontSize: fontSize1, fontWeight: FontWeight.w300)),
            Divider(thickness: 0.4,color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}