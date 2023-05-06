
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/video_services/filterVideosModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/video_services/singleVideo.dart';
import '../models/agentModel.dart';
import '../dashboard.dart';
import 'viedoModel.dart';

class list_videos extends StatefulWidget {
  List<AgentModel> _AgentData = [];
  list_videos(this._AgentData);
  @override
  State<StatefulWidget> createState() => pos_registered3_pageState();

}

class pos_registered3_pageState extends State<list_videos> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<VideoModel> _data = [];
  List<VideoModel> _data2 = [];
  List<VideoModel> _products = [];
  List<String> _basket = [];



  List<VideoFilterModel> _filters = [];
  int i = 0;
  int j = 0;
  int? val = -1;

  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late  Map response;
  late  Map response2;

  @override
  initState() {
    getFilters();
    super.initState();
  }

  Future<List<VideoModel>>_getData() async {
    i++;
    if (i <2) {
      response = await OnlineServices.getVideoList();

      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        setState(() {});
      }else if (response["data"] == "free") {
        isFree = true;
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

    return Scaffold(
      floatingActionButton: _basket.length > 0 ? FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.save),
        onPressed: () {
          sendBasket();

        },
      ) : Center(),

      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),

      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                        padding: EdgeInsets.only(right: 20),
                        width: size.width * .9,
                        child: TextFormField(
                          onChanged: (txt) {
                            //srch = txt;
                            // print(txt);
                            ///ناظ
                            //_getData2();
                            if (txt.length > 0) {
                              _data2.clear();
                              _data2.addAll(response['data']);
                              _data2.removeWhere((element) => !element.title.contains(txt.toString()));

                              setState(() {});
                            }
                            else {
                              // print("________222222222_________");
                              _data2.clear();
                              _data2.addAll(response['data']);
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
                              hintStyle: const TextStyle(
                                  color: Color(0x55000000), fontSize: 16),
                              contentPadding: const EdgeInsets.only(
                                  top: 11, right: 0, bottom: 10, left: 5
                              )
                          ),
                        )),
                    IconButton(icon: Icon(_data.length > _data2.length ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,size: 35,color: _data.length > _data2.length ? Colors.red : Colors.black,),onPressed: ()async{  filter(context);setState(() {

                    });},)
                  ],
                ),
                SizedBox(height: size.height - Comp.appBarHeight - 80, child:
                 FutureBuilder<List<VideoModel>>(future: _getData(),
                  builder: (context, AsyncSnapshot<List<VideoModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: _data2.length,
                          itemBuilder: (BuildContext context, int index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child:  videoList( index)
                                ),
                              ),
                            );
                          });

                    }
                    else if (snapshot.hasError) {return Container();} else return Container() ;},)),

              ],
            ),
            _data2.length < 1 && isFree == false ?
            Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
      ),
    );
  }

  void sendBasket() async {
    late String today = "";
  late String datetime = "";

    String response = "";
    for (int i = 0 ; i< _basket.length ;i++){
       response = await OnlineServices.sendBasket({"agentcode" : widget._AgentData.last.agentCode,"usercode" : widget._AgentData.last.userCode , "onvan" : _basket[i] , "tarikh" : today } );
    }
    if (response == "ok")
    {
      CoolAlert.show(
        onConfirmBtnTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl,
              child: dashboard(widget._AgentData))));
        },
        context: context,
        confirmBtnText: "   بستن   ",
        type: CoolAlertType.success,
        title: "سفارش شما با موفقیت ثبت شد.",
        backgroundColor: Colors.white,
      );
    }

  }

  Widget videoList( int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
   // print(_data2[index].url);
    return _data2[index].url != "1" ? GestureDetector(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4 , vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xff444444) , width: 1)
        ),
        width: size.width * .9,
        child:
        Container(width: size.width * .73, child: ListTile(
          title: Text(_data2[index].title),
          subtitle: Text(_data2[index].decs),
          leading: CachedNetworkImage(
            imageUrl:
            _data2[index].img,
            placeholder: (context, url) => Image.asset("assets/images/pos3.png"),
            errorWidget: (context, url, error) => Image.asset("assets/images/pos3.png"),
          ),

        ),)),onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl,
          child: singleVideo(_data2[index].url))));

    },)  :   Container(
        margin: EdgeInsets.symmetric(horizontal: 4 , vertical: 2),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xff444444) , width: 1)
        ),
        width: size.width * .9,
        child:
        Row(children: [
          ClipRRect(borderRadius: BorderRadius.circular(10.0),
              child: Container(
                margin: EdgeInsets.only(right: 3),
              //  alignment: Alignment.center,

                width: size.width * .15,
                height: size.width * .15,
                child: ElevatedButton(
                  style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero),backgroundColor: MaterialStateProperty.all(
                      _basket.contains(_data2[index].title) ? Color(0xd70c8d00) : Color(
                          0xec242842) )),
                  onPressed: (){
                    _basket.contains(_data2[index].title)
                        ? _basket.remove(_data2[index].title)
                        : _basket.add(_data2[index].title);
                    setState(() {});
                   // print(_basket);
                  },
                  child: _basket.contains(_data2[index].title) ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.check_circle_outline,size: 19,),
                      Text("اضافه شد",textAlign: TextAlign.center, style: TextStyle(fontSize: 10),)
                    ],
                  ) :
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_box_outlined,size: 19,),
                      Text("سفارش",textAlign: TextAlign.center, style: TextStyle(fontSize: 10),)
                    ],
                  ),
                ),
              )),

          Container(
            width: size.width * .7,
            child: ListTile(
              leading: CachedNetworkImage(
                imageUrl: _data2[index].img,
                placeholder: (context, url) => Image.asset("assets/images/pos3.png"),
                errorWidget: (context, url, error) => Image.asset("assets/images/pos3.png"),
              ),
              title: Text(_data2[index].title),
              subtitle: Text(_data2[index].decs),

            ),
          ),

        ],));

  }

  Widget videoList2( int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 4 , vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xff444444) , width: 1)
        ),
        width: size.width * .9,
        height: size.height * .1,
        child:
        ListTile(
          leading: CachedNetworkImage(
            imageUrl:
            _data2[index].img,
            placeholder: (context, url) => Image.asset("assets/images/pos3.png"),
            errorWidget: (context, url, error) => Image.asset("assets/images/pos3.png"),
          ),
          title: Text(_data2[index].title),
          subtitle: Text(_data2[index].decs),

        ));

  }

  void filter(BuildContext context) async {

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
                    "انتخاب فیلتر",
                    textAlign: TextAlign.center,
                  ),
                  Divider(thickness: 2,color: Colors.black87,)
                ],
              ),
              content: SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                      itemCount: _filters.length,
                      itemBuilder: (BuildContext context, int index) {
                        return filterItem(_filters[index].title, index);
                      }),
                    height: size.height * .5,
                  width: size.width * .8,
                ),

              ),

            );
          },
        );
      },
    );
  }

  Widget filterItem(String title , int v){

    return ListTile(
      title: Text(title),
      leading: Radio(
        value: v,
        groupValue: val,
        onChanged: (value)
        {
          setState(() {
            val = value as int;
          _data2.clear();
          _data2.addAll(_data);
          _data2.addAll(_products);
          _filters[v].value == "همه" ? null : _data2.removeWhere((element) => !element.title.contains(_filters[v].value)) ;
          });
          Navigator.pop(context);
        },
        activeColor: Colors.green,
      ),
    );
  }

  void getFilters() async{
    late Map response;
    response = await OnlineServices.getVideoFilters();
    _filters.clear();
    _filters.addAll(response["data"]);
  }
}