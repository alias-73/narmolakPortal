import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/device/new_device.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/senfReq/reqterminal-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';
import 'new_senfReq.dart';

class listReqTerminal extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  listReqTerminal(this._Agentdata);

  @override
  State<StatefulWidget> createState() => listReqTerminalState();
}

class listReqTerminalState extends State<listReqTerminal> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  List<ReqTerminalModel> _data = [];
  int i = 0;

  Color cl = const Color(0xff000000);
  List<String>  arayTXT= [];

  bool isFree = false;
  List<ReqTerminalModel> _data2 = [];
  late Map response;
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();

  Future<String> getImg(String _brand_value, String _model_value) async {
    String response = await OnlineServices.getDeviceImg({
      "brand": _brand_value,
      "model": _model_value
    });
    //print (await response);
    return response;
  }

  Future<List<ReqTerminalModel>> _getData() async {
    i++;
    if (i < 2) {
      response = await OnlineServices.getReqTeminal_list({
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
    double mainHeight = size.height - appBarHeight - 65;
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Directionality(
                        textDirection: TextDirection.rtl,
                        child: senfReq_list(widget._Agentdata))));
          },
        ),
        backgroundColor: const Color(0xfff0f0f0),
        key: _scaffoldKey,
        appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست درخواست های ترمینال","", Icons.edit, (){})),

        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 20),
                    width: size.width * .9,
                    child: TextFormField(
                      onChanged: (txt) {
                        if (txt.length > 0) {

                          _data.clear();
                          _data.addAll(response['data']);

                          _data.removeWhere((element) => !element.name.contains(txt.toUpperCase().toString()));
                          setState(() {});
                        }
                        else {
                          _data.clear();
                          _data.addAll(response['data']);
                          setState(() {});
                        }
                      },
                      style: const TextStyle(
                        color: Color(0xbb000000),
                      ),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: "جستجو بر اساس نام",
                          hintStyle: TextStyle(
                              color: Color(0x55000000), fontSize: 16),
                          contentPadding: EdgeInsets.only(
                              top: 11, right: 0, bottom: 10, left: 5)),
                    )),
                Expanded(
                    child: FutureBuilder<List<ReqTerminalModel>>(
                  future: _getData(),
                  builder:
                      (context, AsyncSnapshot<List<ReqTerminalModel>> snapshot) {
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
            ),///ناظ
            _data2.length < 1 && isFree == false
                ? Comp.loadingList_shimmer4(size.height , size.width) : Center()
          ],
        ));
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    final primary = const Color(0xff000000);
    final secondary = const Color(0xff000000);
    return Container(
   //   height: (size.height * .1) + 60,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: _data[index].vaziat == "تایید شد" ? Color(0x244aff00) : _data[index].vaziat == "رد شد" ? Color(
              0x2aff0000) : Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(alignment: Alignment.centerLeft ,children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Flexible(
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.numbers_outlined,
                                color: secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(_data[index].shomare,
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: 13,))),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                  child: Text(_data[index].vaziat,
                                      style: TextStyle(
                                        color: primary,
                                        fontSize: 13,))),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.date_range,
                                color: secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text( _data[index].tarikh,
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 13)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                        ],
                      )),
                  Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.person,
                                color: secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(_data[index].name,
                                  style: TextStyle(
                                    color: primary,
                                    fontSize: 13,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                              Icon(
                                Icons.drive_file_rename_outline_sharp,
                                color: secondary,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(_data[index].sanad,
                                  style: TextStyle(
                                      color: primary,
                                      fontSize: 13)),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          Row(
                            children: [
                             _data[index].vaziat == "رد شد" || _data[index].vaziat == "تایید شد"  ? TextButton(
                                 onPressed: (){_showDialog(context, _data[index].tozihat);}, child:
                             Text("توضیحات",style: TextStyle(color: Colors.white)),
                              style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all(Colors.white),
                                backgroundColor: MaterialStateProperty.all(Colors.teal)
                              )) : Center(),

                            ],
                          ),

                          const SizedBox(
                            height: 8,
                          ),
                         // Image.asset("assets/images/empty.png", height: 50) ,

                        ],
                      )),
                ],
              ),
            ],)
          ],
        ));
  }


  Widget txt(String txt) {
    Color c = Colors.white;
    double s = 15;
    return Align(
      child: Column(
        children: [
          Text(txt,textAlign: TextAlign.center, style: TextStyle(fontSize: s, color: c)),
          const Divider(
            color: Colors.white,
            height: 2,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    );
  }
  void _showDialog(BuildContext context, String txt) {
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
                      child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(onPressed: (){
                Navigator.pop(context);

              },
                  child: Text("بستن",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),))
            ],
          ),
        );
      },
    );
  }


}
