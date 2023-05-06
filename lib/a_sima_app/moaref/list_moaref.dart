
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/Moaref/MoarefAccordian.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Moaref/moaref-model.dart';
import 'package:sima_portal/a_sima_app/Moaref/new_moaref.dart';
import 'package:sima_portal/a_sima_app/Takhsis/new_takhssis.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class list_moaref_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  list_moaref_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => pos_registered3_pageState();

}

class pos_registered3_pageState extends State<list_moaref_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<MoarefModel> _data = [];
  List<MoarefModel> _data2 = [];
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late  Map response;
  Future<List<MoarefModel>>_getData() async {
   // print(widget._Agentdata.last.agentCode+"="+widget._Agentdata.last.userCode);
    i++;
    if (i <2) {
     response = await OnlineServices.getMoarefList({"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      _data2.addAll(response['data']);
      setState(() {});
    } else {
      isFree = true;
      Comp.showSnackEmpty(context);

      setState(() {});
    }}return _data;
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
    final primary = Color(0xff000000);
    final secondary = Color(0xfff29a94);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست معرفین پذیرنده ها","", Icons.edit, (){})),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                width: size.width * .9,
                child: TextFormField(
                  onChanged:(txt) {
                      if (txt.length > 0)
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
                      /// عذرا
                      else {
                        //  print("________222222222_________");
                        _data.clear();
                        _data.addAll(response['data']);
                        setState(() {});
                      }
                  },/// رمز
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
                FutureBuilder<List<MoarefModel>>(future: _getData(),
                builder: (context, AsyncSnapshot<List<MoarefModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return MoarefAccordion(_data, index, size);
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child:  MoarefAccordion(_data, index, size)
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
          Comp.loadingList_shimmer(size.height , size.width) : Center()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
            new_moaref_page(widget._Agentdata))));

        },
      ),

    );
  }
  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return Container(
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
                      height: 8,
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
                        Flexible(child: Text( _data[index].tell == null ? "-" :  _data[index].tell,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3))),

                      ],
                    ),
                    SizedBox(
                      height: 8,
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
                        Text( _data[index].namepazirande == null ? "-" : _data[index].namepazirande,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
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
                        Text( _data[index].sanadpazirande == null ? "-" : _data[index].sanadpazirande,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),

                  ],

                )),

              ],
            ),
            SizedBox(height: 10,),
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
                  child: Text( _data[index].address == null ? "-" : _data[index].address,
                      style: TextStyle(
                          color: primary, fontSize: 13, letterSpacing: .3)),
                ),
              ],
            ),

          ],
        )
    )  ;
  }


}