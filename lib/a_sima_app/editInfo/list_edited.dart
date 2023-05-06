
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/editInfo/changePersonalInfo.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';
import 'edited-model.dart';

class list_edited_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  list_edited_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => pos_jaygozini_pageState();

}

class pos_jaygozini_pageState extends State<list_edited_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<EditedModel> _data = [];
  List<EditedModel> _data2 = [];
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
  late Map response;
  Future<List<EditedModel>>_getData() async {
    i++;
    if (i <2) {
     response = await OnlineServices.getEditedList({"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      _data2.addAll(response['data']);
      setState(() {});

    }
    else
    {
      isFree = true;
      Comp.showSnackEmpty(context);
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
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست تغییرات هویتی","", Icons.edit, (){})),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width * .9,
                child: TextFormField(
                  /// مرادی
                  onChanged:(txt) {
                    if (txt.length > 0)
                    {
                      _data.clear();
                      _data.addAll(response['data']);
                      _data.removeWhere((element) =>
                      !element.codemeli.contains(txt.toString()));
                      setState(() {});
                    }
                    else {
                      //  print("________222222222_________");
                      _data.clear();
                      _data.addAll(response['data']);
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
              Expanded(child:
                FutureBuilder<List<EditedModel>>(future: _getData(),
                builder: (context, AsyncSnapshot<List<EditedModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 575),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child: buildList(context, index)
                                ,
                              ),
                            ),
                          );
                        });

                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)),
            ],
          ),
          _data2.length < 1 && isFree == false ?
          Comp.loadingList_shimmer2(size.height , size.width) : Center()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: changePersonalInfo(widget._Agentdata))));
        },
      ),
    );
  }
  Widget buildList(BuildContext context, int index) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.person,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_data[index].codemeli,
                          style: TextStyle(
                              color: primary, fontSize: 13)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: secondary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(_data[index].vaziyat,
                          style: TextStyle(
                              color: primary, fontSize: 13)),
                    ],
                  ),
                ]),
                Divider(thickness: .7,color: Color(0xff565656)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Expanded(child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Text("سریال شناسنامه: " + _data[index].serial,
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,

                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Flexible(child: Text("سری و حرف: " +  _data[index].seri + "-" + _data[index].harf,
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3))),
                          ],
                        ),
                      ],
                    )),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Text( "موبایل: " + _data[index].mobilepish + _data[index].mobile,
                                style: TextStyle(
                                    color: primary, fontSize: 13, letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Flexible(
                              child: Text("کد مالیاتی: " +  _data[index].maliyat,
                                  style: TextStyle(
                                      color: primary, fontSize: 13, letterSpacing: .3)),
                            ),
                          ],
                        ),

                      ],
                    )),
                  ],
                ),

              ],
            )
        ),
      //  Positioned(child: ElevatedButton(onPressed: (){terminal(_data[index].sanad);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)), child: Text("ترمینال")),left: 20,bottom: 8,),


      ],
    )  ;
  }

}
