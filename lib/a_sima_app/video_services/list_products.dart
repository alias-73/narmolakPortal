import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/video_services/filterVideosModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import '../appbar_home.dart';
import '../dashboard.dart';
import 'viedoModel.dart';
import '../models/agentModel.dart';

class list_products extends StatefulWidget {
  List<AgentModel> _AgentData = [];

  list_products(this._AgentData);

  @override
  State<StatefulWidget> createState() => pos_registered3_pageState();
}

class pos_registered3_pageState extends State<list_products> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<VideoModel> _data = [];
  List<VideoModel> _data2 = [];
  List<VideoModel> _products = [];
  double sumBasket = 0;
  List<String> _basket = [];

  List<VideoFilterModel> _filters = [];
  int i = 0;
  int j = 0;
  int? val = -1;

  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late Map response;
  late Map response2;
  String IsAllowStore = "-";

  @override
  initState() {
    isAllowStore();
    getFilters();
    super.initState();
  }

  void isAllowStore() async {
    String response = await OnlineServices.isAllowStore({
      "agentcode": widget._AgentData.last.agentCode,
      "usercode": widget._AgentData.last.userCode
    });
    IsAllowStore = response;
    setState(() {});

  }


  Future<List<VideoModel>> _getData2() async {
    j++;
    if (j < 2) {
      response2 = await OnlineServices.getProList();
      if (response2["data"] != "free") {
        _products.addAll(response2['data']);
        _data2.addAll(response2['data']);
        setState(() {});
      } else if (response2["data"] == "free") {
        isFree = false;
        setState(() {});
      } else {
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

    return Scaffold(
      floatingActionButton: _basket.length > 0
          ? FloatingActionButton(
              backgroundColor: Colors.teal,
              child: Icon(Icons.save),
              onPressed: () {
                show_basket();
                //sendBasket();
              },
            )
          : Center(),
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),

      body: IsAllowStore == "yes" ?
      SingleChildScrollView(
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
                            if (txt.length > 0) {
                              _data2.clear();
                              _data2.addAll(response['data']);
                              _data2.removeWhere((element) =>
                                  !element.title.contains(txt.toString()));

                              setState(() {});
                            } else {
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
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "جستجو",
                              hintStyle: const TextStyle(
                                  color: Color(0x55000000), fontSize: 16),
                              contentPadding: const EdgeInsets.only(
                                  top: 11, right: 0, bottom: 10, left: 5)),
                        )),
                    IconButton(
                      icon: Icon(
                        _data.length > _data2.length
                            ? Icons.filter_alt_rounded
                            : Icons.filter_alt_outlined,
                        size: 35,
                        color: _data.length > _data2.length
                            ? Colors.red
                            : Colors.black,
                      ),
                      onPressed: () async {
                        filter(context);
                        setState(() {});
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: size.height - Comp.appBarHeight - 80 - 56,
                  child: FutureBuilder<List<VideoModel>>(
                    future: _getData2(),
                    builder:
                        (context, AsyncSnapshot<List<VideoModel>> snapshot) {
                      if (snapshot.hasData) {
                        return GridView.builder(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                           //   childAspectRatio: 1.7,
                           // childAspectRatio: 1.9,
                            crossAxisCount: 2,
                           // crossAxisSpacing: 4.0,
                      //      mainAxisSpacing: 9,
                          ),
                          itemCount: _data2.length,
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child:  productList(index),
                                ),
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Container();
                      } else
                        return Container();
                    },
                  ),
                )
              ],
            ),
            _data2.length < 1 && isFree == false
                ? Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
      ) : IsAllowStore == "no" ? Center(
        child:
          Padding(child:    Text("نماینده گرامی\n مجوز دسترسی به فروشگاه برای شما صادر نگردیده است. برای کسب اطلاعات بیشتر با مدیر عملیات ارتباط برقرار نمایید." ,textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 21),),
            padding: EdgeInsets.symmetric(horizontal: 20),)
      ) : Center(),
    );
  }


  Widget productList(int index) {
    var size = MediaQuery.of(context).size;

    double itmH = size.height ;

    return Container(
      height: itmH,
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
            color: _basket.contains(_data2[index].title)
                ? Color(0x13FFFFFF)
                : Color(0xffffffff),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xff444444), width: 1)),
        child:
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(child: CachedNetworkImage(
              imageUrl: _data2[index].img,
              placeholder: (context, url) =>
                  Image.asset("assets/images/pos3.png"),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/pos3.png"),
            ),
              height: itmH * .11,),
            Text(_data2[index].title.replaceAll("-", "\n")),
            Text(
              _data2[index].price.seRagham() ,
              style: TextStyle(
                  fontSize: 12, decoration: TextDecoration.underline),
            ),
            ElevatedButton(
                onPressed: () {
                  if (_basket.contains(_data2[index].title)) {
                    _basket.remove(_data2[index].title);
                    sumBasket -= double.parse(_data2[index].price);
                  } else {
                    _basket.add(_data2[index].title);
                    sumBasket += double.parse(_data2[index].price);
                  }

                  setState(() {});
                },
                style: ButtonStyle(
                    minimumSize: MaterialStateProperty.all(Size(10, 28)),
                    backgroundColor: MaterialStateProperty.all(
                        _basket.contains(_data2[index].title)
                            ? Color(0xec0d4d10)
                            : Color(0xec242842))),
                child: _basket.contains(_data2[index].title)
                    ? Text("اضافه شده")
                    : Text("اضافه به سبد")),
          ],
        )
    );
  }

  void _showDialog3(String txt) {
    var size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
        MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Color(0x69bcdeff),
              body: Center(
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xFFEAEAEA)),
                  width: size.width * .85,
                  height: size.height * .5,
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "شرح فاکتور",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.w800),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 40), child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),),

                      txtBox(txt),
                      Divider(
                        color: Colors.black,
                        thickness: 3,
                      ),
                      Container(
                        width: size.width * .8,
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: Color(0xFFEAEAEA)),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "جمع فاکتور:  " ,
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  sumBasket.toString().toPersianDigit().seRagham().toString().substring(0 , sumBasket.toString().toPersianDigit().seRagham().toString().length-2 ) +"  " + "تومان",
                                  style: TextStyle(
                                      fontSize: 18, fontWeight: FontWeight.w700),
                                ),
                              ],
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "        لغو        ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              )),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.teal)),
                              onPressed: () {
                                Navigator.pop(context);
                                sendBasket();
                              },
                              child: Text(
                                "  ثبت سفارش   ",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 16),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ));
        });
  }

  Widget txtBox(String txt) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width * .8,
      padding: EdgeInsets.all(6),
      child: Directionality(
          textDirection: TextDirection.rtl,
          child: Text(
            txt,
            style: TextStyle(fontSize: 16),
          )),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(0xFFEAEAEA)),
    );
  }


  void show_basket() {
    String basket = "";
    for (int i = 0; i < _basket.length; i++) {
      i == 0 ?
      basket += "${i+1}- ${_basket[i]}" : basket += "\n${i+1}- ${_basket[i]}";
    }
    _showDialog3(basket);
  }

  void sendBasket() async {
    late String today = "";
  late String datetime = "";
    
    
    

    String response = "";
    for (int i = 0; i < _basket.length; i++) {
      response = await OnlineServices.sendBasket({
        "agentcode": widget._AgentData.last.agentCode,
        "usercode": widget._AgentData.last.userCode,
        "onvan": _basket[i],
        "tarikh": today
      });
    }
    if (response == "ok") {
      CoolAlert.show(
        onConfirmBtnTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Directionality(
                      textDirection: TextDirection.rtl,
                      child: appbar_home(widget._AgentData))));
        },
        context: context,
        confirmBtnText: "   بستن   ",
        type: CoolAlertType.success,
        title: "سفارش شما با موفقیت ثبت شد",
        backgroundColor: Colors.white,
      );
    }
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
                  Divider(
                    thickness: 2,
                    color: Colors.black87,
                  )
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

  Widget filterItem(String title, int v) {
    return ListTile(
      title: Text(title),
      leading: Radio(
        value: v,
        groupValue: val,
        onChanged: (value) {
          setState(() {
            val = value as int;
            _data2.clear();
            _data2.addAll(_data);
            _data2.addAll(_products);
            _filters[v].value == "همه"
                ? null
                : _data2.removeWhere(
                    (element) => !element.title.contains(_filters[v].value));
          });
          Navigator.pop(context);
        },
        activeColor: Colors.green,
      ),
    );
  }

  void getFilters() async {
    late Map response;
    response = await OnlineServices.getProFilters();
    _filters.clear();
    _filters.addAll(response["data"]);
  }
}
