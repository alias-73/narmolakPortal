//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis_Accordian.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/new_imei_check.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import 'IMEIAccordian.dart';
import 'models/imeiModel.dart';

class listIMEI extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  listIMEI(this._Agentdata);
  @override
  State<StatefulWidget> createState() => terState();

}

class terState extends State<listIMEI> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  List<IMEIModel> _data = [];
  List<IMEIModel> _data2 = [];
  int i = 0;
  bool isFree = false;
  late Map response;
  final primary = Color(0xff000000);
  //final secondary = Color(0xfff29a94);
  Future<List<IMEIModel>>_getData() async {
    i++;
    if (i < 2)
    {
      ///  ذک
      response = await OnlineServices.getIMEIList({"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
      //print(response["data"].length);

      if (response["data"] != "no") {
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
    ///  عذر

    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: newIMEI_page(widget._Agentdata))));
        },
      ),
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("طرح رجیستری","", Icons.edit, (){})),

      body:  Stack(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(right: 20),
                  width: size.width * .9,
                  child: TextFormField(
                    onChanged:(txt) {
                      if (txt.length > 0) {
                        _data.clear();
                        _data.addAll(response['data']);

                          _data.removeWhere((element) => !element.terminal.contains(txt.toString()));

                        setState(() {});
                      }///صادقز
                      else {
                        // print("________222222222_________");
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

                        hintText: "جستجو بر اساس ترمینال ",
                        hintStyle: const TextStyle(color: Color(0x55000000) , fontSize: 16),
                        contentPadding: const EdgeInsets.only(
                            top: 11 , right: 0 , bottom: 10 , left: 5
                        )
                    ),
                  )),
              Expanded(child:
              FutureBuilder<List<IMEIModel>>(future: _getData(),
                builder: (context, AsyncSnapshot<List<IMEIModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return IMEIAccordion(_data,index,size,widget._Agentdata,);
                        });
                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)      )
            ],),
          _data2.length < 1 && isFree == false ?
          Comp.loadingList_shimmer(size.height , size.width) : Center()
        ],
      ),


    );
  }

}