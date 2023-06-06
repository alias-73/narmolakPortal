// ignore_for_file: dead_code

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/jaygozini/jaygozini-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';
import 'new_jaygozini.dart';

class list_jaygozini_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  list_jaygozini_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => pos_jaygozini_pageState();
}

class pos_jaygozini_pageState extends State<list_jaygozini_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<JaygoziniModel> _data = [];
  List<JaygoziniModel> _data2 = [];
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
  late Map response;
  Future<List<JaygoziniModel>> _getData() async {
    i++;
    if (i < 2) {
      response = await OnlineServices.getReplaceList({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": widget._Agentdata.last.userCode
      });
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
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
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Comp.appBarHeight),
          child: Comp.app_bar("لیست جایگزینی", "", Icons.edit, () {})),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  width: size.width * .9,
                  child: TextFormField(
                    /// مرادی
                    onChanged: (txt) {
                      if (txt.length > 0) {
                        _data.clear();
                        _data.addAll(response['data']);
                        for (int i = 0; i < _data.length; i++) {
                          if (_data[i].name == "" || _data[i].name == null)
                            _data[i].name = "بدون نام";
                        }
                        _data.removeWhere((element) =>
                            !element.name.contains(txt.toString()));
                        setState(() {});
                      } else {
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
                            borderSide: BorderSide(color: Colors.white)),
                        hintText: "جستجو",
                        hintStyle: const TextStyle(
                            color: Color(0x55000000), fontSize: 16),
                        contentPadding: const EdgeInsets.only(
                            top: 11, right: 0, bottom: 10, left: 5)),
                  )),
              Expanded(
                  child: FutureBuilder<List<JaygoziniModel>>(
                future: _getData(),
                builder:
                    (context, AsyncSnapshot<List<JaygoziniModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 375),
                            child: SlideAnimation(
                              verticalOffset: 44.0,
                              child: FadeInAnimation(
                                child: buildList(context, index),
                              ),
                            ),
                          );
                        });
                  } else if (snapshot.hasError) {
                    return Container();
                  } else
                    return Container();
                },
              )),
            ],
          ),
          _data2.length < 1 && isFree == false
              ? Comp.loadingList_shimmer3(size.height, size.width)
              : Center()
        ],
      ),
      floatingActionButton: widget._Agentdata[0].userModel == "0"
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Directionality(
                            textDirection: TextDirection.rtl,
                            child: newReplace_page(widget._Agentdata))));
              },
            )
          : Center(),
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
              border: Border.all(color: Colors.black, width: 1),
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
                    Text(_data[index].name == null ? "-" : _data[index].name,
                        style: TextStyle(color: primary, fontSize: 13)),
                  ],
                ),
                Divider(thickness: .7, color: Color(0xff565656)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                                _data[index].serialold == null
                                    ? "-"
                                    : _data[index].serialold,
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3)),
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
                            Flexible(
                                child: Text(
                                    _data[index].serialnew == null
                                        ? "-"
                                        : _data[index].serialnew,
                                    style: TextStyle(
                                        color: primary,
                                        fontSize: 13,
                                        letterSpacing: .3))),
                          ],
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.edit,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                                _data[index].sanad == null
                                    ? "-"
                                    : _data[index].sanad,
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3)),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                  _data[index].vaziat == null
                                      ? "-"
                                      : _data[index].vaziat,
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 13,
                                      letterSpacing: .3)),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            )),
        Positioned(
          child: ElevatedButton(
              onPressed: () {
                terminal(_data[index].sanad);
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal)),
              child: Text("ترمینال")),
          left: 20,
          bottom: 8,
        ),
        Positioned(
          child: RotatedBox(
              quarterTurns: 2,
              child: SvgPicture.asset(
                "assets/images/arrow1.svg",
                color: Colors.teal,
                height: 53,
              )),
          right: 5,
          bottom: 15,
        ),
      ],
    );
  }

  Future terminal(String serial) async {
    String response = await (OnlineServices()).getTerminal({"serial": serial});
    String ter;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 5)
      ter = "ترمینالی پیدا نشد";
    else
      ter = "سریال: " +
          response.split(",")[0] +
          "     برند: " +
          response.split(",")[1] +
          "\n"
              "مدل: " +
          response.split(",")[2] +
          "    ترمینال: " +
          response.split(",")[3] +
          "\n"
              "فروشگاه: " +
          response.split(",")[4];
    _showDialog(ter);
  }

  void _showDialog(String txt) {
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
                      textDirection: TextDirection.rtl, child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
                  },
                  child: Text(
                    "           تایید           ",
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
}
