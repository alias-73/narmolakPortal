import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pasargad-model.dart';
import 'package:sima_portal/a_sima_app/sabt.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/Hesab/new_hesab.dart';


import '../components/Styles.dart';
import '../models/irankish-model.dart';

class em_cartableI_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  em_cartableI_page(this._Agentdata);

  @override
  State<StatefulWidget> createState() => pasargad_pageState();
}

class pasargad_pageState extends State<em_cartableI_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<IranKishModel> _data = [];
  int i = 0;

  DateTime selectedDate = DateTime.now();
  String _format = 'yyyy-mm-dd';
  bool isFree = false;
  List<IranKishModel> _data2 = [];
  late Map response;

  Future<List<IranKishModel>> _getData() async {
    i++;
    if (i < 2) {
     // response = await OnlineServices.pasargad({"agentcode": "10047", "usercode": "0"});
      response = await OnlineServices.iranKish({"agentcode" : widget._Agentdata.last.agentCode,"usercode" : widget._Agentdata.last.userCode} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].pazirande == "" || _data[i].pazirande == null)
            _data[i].pazirande = "بدون نام";
        }
        setState(() {});
      } else {
        isFree = true;
        Comp.show_short_info("لیست خالی است");

        setState(() {});
      }
    }
    return _data;
  }

  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;
    return Scaffold(
      backgroundColor: Color(0xfff0f0f0),
      key: _scaffoldKey,
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("کارتابل Em","assets/images/irankish.png", Icons.edit, (){})),

      body: Stack(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(right: 20),
                  width: size.width * .9,
                  child: TextFormField(
                    onChanged: (txt) {
                      if (txt.length > 0) {
                        _data.clear();
                        _data.addAll(response['data']);
                        for (int i = 0; i < _data.length; i++) {
                          if (_data[i].pazirande == "" ||
                              _data[i].pazirande == null)
                            _data[i].pazirande = "بدون نام";
                        }
                        _data.removeWhere((element) =>
                            !element.pazirande.contains(txt.toString()));
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
                  child: FutureBuilder<List<IranKishModel>>(
                future: _getData(),
                builder:
                    (context, AsyncSnapshot<List<IranKishModel>> snapshot) {
                  // print("-----"+snapshot.data!.toString());
                  if (snapshot.hasData) {
                    //  List<News> _news2 = snapshot.data!;
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                        });
                  } else if (snapshot.hasError) {
                    return Container();
                  } else
                    return Container();
                },
              ))
            ],
          ),
          _data2.length < 1 && isFree == false
              ? Comp.showLoading(size.height , size.width) : Center()
        ],
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
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Expanded(
                    child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.drive_file_rename_outline,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                            _data[index].shenase == null
                                ? "-"
                                : _data[index].shenase,
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
                      children: [
                        Icon(
                          Icons.credit_card,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),

                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.edit,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(_data[index].serial,
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
                          Icons.store,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Text(
                              _data[index].foroshgah == null
                                  ? "-"
                                  : _data[index].foroshgah,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                  letterSpacing: .3)),
                        ),
                      ],
                    ),
                  ],
                )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                        Text("",
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
                      children: [
                        Icon(
                          Icons.title_sharp,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Flexible(
                            child: Text(
                                _data[index].terminal == null
                                    ? "-"
                                    : _data[index].terminal,
                                style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                    letterSpacing: .3))),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.person,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(_data[index].pazirande,
                            style: TextStyle(
                                color: primary,
                                fontSize: 13,
                                letterSpacing: .3)),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                  ],
                )),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 10),
                  width: size.width * 0.35,
                  height: size.height * .06,
                  child: ElevatedButton(
                      onPressed: () { Comp.show_short_info( _data[index].mobile);  },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 9)),backgroundColor: MaterialStateProperty.all(Color(0xfffac80a))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("موبایل", style: TextStyle(color: Colors.black, fontSize: 15)),
                          Icon(Icons.phone_iphone, color: Colors.black, size: 20,)
                        ],
                      )),
                ),
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 10),
                  width: size.width * 0.35,
                  height: size.height * .06,
                  child: ElevatedButton(
                      onPressed: () { Comp.show_short_info( _data[index].address);  },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 9)),backgroundColor: MaterialStateProperty.all(Color(0xfffac80a))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("آدرس", style: TextStyle(color: Colors.black, fontSize: 15)),
                          Icon(Icons.location_on, color: Colors.black, size: 20,)
                        ],
                      )),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 10),
                  width: size.width * 0.35,
                  height: size.height * .06,
                  child: ElevatedButton(
                      onPressed: () {_showDialog( _data[index].darkhast);  },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 9)),backgroundColor: MaterialStateProperty.all(Color(0xffE2E2E2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("شرح درخواست", style: TextStyle(color: Colors.black, fontSize: 13)),
                          Icon(Icons.drive_file_rename_outline, color: Colors.black, size: 20,)
                        ],
                      )),
                ),
                Container(
                  //padding: EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: 10),
                  width: size.width * 0.35,
                  height: size.height * .06,
                  child: ElevatedButton(
                      onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sabt_page(_data[index].shenase,widget._Agentdata,"ایران کیش"))));
                      },
                      style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 9)),backgroundColor: MaterialStateProperty.all(Color(0xffE2E2E2))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("انجام شد", style: TextStyle(color: Colors.black, fontSize: 15)),
                          Icon(Icons.adjust, color: Colors.black, size: 20,)
                        ],
                      )),
                ),
              ],
            ),
          ],
        ));
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
                    "        مطالعه کردم        ",
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
