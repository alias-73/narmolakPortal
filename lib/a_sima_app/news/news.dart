import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

import '../models/pazirandeModel2.dart';
import 'news-model.dart';


class news_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  news_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => sheba_register2_pageState();
}

class sheba_register2_pageState extends State<news_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  final _key1_1 = GlobalKey<FormFieldState>();
  final _key1_2 = GlobalKey<FormFieldState>();
  String _key2 = "";
  final _key3_1 = GlobalKey<FormFieldState>();
  final _key3_2 = GlobalKey<FormFieldState>();
  final _key4_1 = GlobalKey<FormFieldState>();
  final _key4_2 = GlobalKey<FormFieldState>();
  final _key5 = GlobalKey<FormFieldState>();
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
  List<String> _pazirandeValue = ["همه" , "جدید", "خوانده شده"];
  String _news_Value = "جدید";
  List<NewsModel> news = [];
  List<NewsModel> all = [];
  List<NewsModel> read = [];
  bool loading = false;
  late Map response;
  bool isFree = false;
  String TAG = "new";


  late TextEditingController _controller1 = TextEditingController(text: "جدید");
  int x = 0;
  int y = 0;
  int z = 0;

  Future<List<NewsModel>>_getNews() async {
    x++;
    if (x <2) {
      response = await OnlineServices.getNewsList({ "section" : "new" , "agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
      if (response["data"] != "free") {
        news.clear();
        news.addAll(response['data']);
        setState(() {});
      }
      else
      {
        isFree = true;
        Comp.showSnackEmpty(context);
        setState(() {});
      }
    }
    return news;
  }
  Future<List<NewsModel>>_getAll() async {
    y++;
    if (y <2) {
      response = await OnlineServices.getNewsList({ "section" : "all" ,"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
      if (response["data"] != "free") {
        all.clear();
        all.addAll(response['data']);
        setState(() {});
      }
      else
      {
        isFree = true;
        Comp.showSnackEmpty(context);
        setState(() {});
      }
    }
    return all;
  }
  Future<List<NewsModel>>_getRead() async {
    z++;
    if (z < 2) {
      response = await OnlineServices.getNewsList({ "section" : "read" ,"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
      if (response["data"] != "free") {
        read.clear();
        read.addAll(response['data']);
        setState(() {});
      }
      else
      {
        isFree = true;
        Comp.showSnackEmpty(context);
        setState(() {});
      }
    }
    return read;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;

    Color cl = Color(0xff000000);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("اخبار","", Icons.edit, (){})),

      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 10),
         // padding: EdgeInsets.only(bottom: 40),
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
                          Icons.app_registration_sharp,
                          color: Colors.black,
                        ),
                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl)),
                        labelText: "خبر قابل نمایش",
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
                            _news_Value = newVal!;
                            _key2 = newVal;
                            _controller1 = TextEditingController(text: _news_Value);
                            _news_Value == "جدید" ? TAG = "new" : _news_Value == "خوانده شده" ? TAG = "read" : TAG = "all";
                            setState(() {});
                          }))
                ],
              ),
          SizedBox(height: 10),
             SizedBox(height: (size.height)-appBarHeight-(size.height * 0.13),width: size.width,child:
             TAG == "new" ? FutureBuilder<List<NewsModel>>(future: _getNews(),
                builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: news.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index,news);
                         
                        });

                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)
             : TAG == "all" ?
             FutureBuilder<List<NewsModel>>(future: _getAll(),
               builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                 if (snapshot.hasData) {
                   return ListView.builder(
                       itemCount: all.length,
                       itemBuilder: (BuildContext context, int index) {
                         return buildList(context, index , all);

                       });

                 }
                 else if (snapshot.hasError) {return Container();} else return Container() ;},)
                 :
             FutureBuilder<List<NewsModel>>(future: _getRead(),
               builder: (context, AsyncSnapshot<List<NewsModel>> snapshot) {
                 if (snapshot.hasData) {
                   return ListView.builder(
                       itemCount: read.length,
                       itemBuilder: (BuildContext context, int index) {
                         return buildList(context, index , read);

                       });

                 }
                 else if (snapshot.hasError) {return Container();} else return Container() ;},)
             ),

            ],
          ),
        ),
        loading == true ? Comp.showLoading(size.height , size.width) : Center()

      ]),
    );
  }

  Widget buildList(BuildContext context, int index , List<NewsModel> _data ) {
    var size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [

        Container(
            decoration: BoxDecoration(
             // border: Border.all(color: Colors.black,width: 1),
             // borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            width: size.width,
            // height: 110,
            padding: EdgeInsets.symmetric( horizontal: 25),
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                     Icon(Icons.newspaper_outlined, color: Colors.black,size: 15,),
                    SizedBox(width: 6,),

                    Text( _data[index].title ,
                        style: TextStyle(
                            color: Colors.black, fontSize: 17))
                  ]),
                  SizedBox(height: 5,),
                  Text("       شماره: " +  _data[index].no ,
                      style: TextStyle(
                          color: Color(0x92000000), fontSize: 13)),
                  SizedBox(height: 5,),

                  Text("       تاریخ: " +  _data[index].date ,
                      style: TextStyle(
                          color: Color(0x92000000), fontSize: 13)),
                  SizedBox(height: 5,),

                  Text("       متن خبر: " +  _data[index].desc ,
                      maxLines: 1,
                      style: TextStyle(
                          color: Color(0x92000000), fontSize: 13)),
                  Divider(thickness: 1,)


                ],
              ),

        ),
        Positioned(top: 10,left: size.width * .2,
          child: ElevatedButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                0xff0f8d6b)),elevation: MaterialStateProperty.all(8),textStyle: MaterialStateProperty.all(TextStyle(fontStyle: FontStyle.italic))),
            onPressed: (){
              TAG != "read" ?
              sendDataForRead(_data[index].no) : null;
              showDialog_(context,_data[index].title,_data[index].desc,_data[index].no);

            },
            child: Row(
              children: [
                Icon(Icons.edit, size: 19,),
                SizedBox(width: 7),
                Text("ادامه خبر", style: TextStyle(fontWeight: FontWeight.w600),),
              ],
            ),
          ),)

      ],
    )  ;
  }

  Widget buildList2(BuildContext context, int index , List<NewsModel> _data ) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [

        Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 1),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            width: double.infinity,
            // height: 110,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.drive_file_rename_outline,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].no ,
                            style: TextStyle(
                                color: primary, fontSize: 13)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.title,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].title ,
                            style: TextStyle(
                                color: primary, fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                Divider(thickness: .7,color: Color(0xff565656)),
                Row(
                  mainAxisAlignment:MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text( _data[index].date ,
                            style: TextStyle(
                                color: primary, fontSize: 13)),
                      ],
                    ),
                    ElevatedButton(onPressed: (){
                      showDialog_(context,_data[index].title,_data[index].desc,_data[index].no);
                    }, child: Text("نمایش متن خبر")),
                  ],
                ),

              ],
            )
        ),
        // Positioned(child: ElevatedButton(onPressed: (){terminal(_data[index].sanad);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)), child: Text("ترمینال")),left: 20,bottom: 8,),
        // Positioned(child: RotatedBox(quarterTurns: 2, child: SvgPicture.asset("assets/images/arrow1.svg", color: Colors.teal, height: 53,)),right: 5,bottom: 15,),

      ],
    )  ;
  }


  void showDialog_(BuildContext context, String title , desc , String number) {
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
                      textDirection: TextDirection.rtl, child: Column(
                    children: [
                      Text(title),
                      Divider(thickness: 2),
                      Text(desc),
                    ],
                  ))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    // news.removeWhere((element) =>
                    // element.no.contains(number));
                    // setState(() {});
                    Navigator.pop(context);

                  },
                  child: Text(
                    "بستن",
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

  void sendDataForRead(String number) async {

    await (OnlineServices()).sendDataForRead({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "number": number,
    });
    //   print(response);

  }

  Future<String>  fus()async{
    setState(() {

    });
    return "";
  }




}