//
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis_Accordian.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsis-model.dart';
import 'package:sima_portal/a_sima_app/Takhsis/new_takhssis.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import '../Hesab/HesabAccordian.dart';

class pos_registered3_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  pos_registered3_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => pos_registered3_pageState();

}

class pos_registered3_pageState extends State<pos_registered3_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  List<TakhsisModel> _data = [];
  List<TakhsisModel> _data2 = [];
  int i = 0;
  bool isFree = false;
 late Map response;
  final primary = Color(0xff000000);
  //final secondary = Color(0xfff29a94);
  Future<List<TakhsisModel>>_getData() async {
    i++;
    if (i < 2)
    {
      response = await OnlineServices.getTakhsisList({"agentcode" : widget._Agentdata.last.agentCode, "usercode" : widget._Agentdata.last.userCode} );
      //print(response["data"].length);

      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
      //  print (_data.length);
        for (int i = 0 ; i < _data.length ; i++)
        {
          if(_data[i].name2 == "" || _data[i].name2 == null)
            _data[i].name2 = "بدون نام";
        }
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
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست تخصیص","", Icons.edit, (){})),

      body:  Stack(
        children: [
          Column(
            children: [
              Container(
                  padding: EdgeInsets.only(right: 20),
                  width: size.width * .9,
                  child: TextFormField(
                    onChanged:(txt) {
                      // print(response["data"].length);

                     // print("_____________A:  "  + _data.length.toString());

                        if(txt.length > 0)
                        {
                          _data.clear();
                          _data.addAll(response['data']);
                         // print("_____________B:  " + _data.length.toString());
                          for (int i = 0 ; i < _data.length ; i++)
                          {
                            if(_data[i].name2 == "" || _data[i].name2 == null)
                              _data[i].name2 = "بدون نام";
                          }
                          _data.removeWhere((element) => !element.name2.contains(txt.toString())) ;
                         // print("_____________C:  " + _data.length.toString());

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
              FutureBuilder<List<TakhsisModel>>(future: _getData(),
                builder: (context, AsyncSnapshot<List<TakhsisModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TakhsisAccordion(widget._Agentdata,_data,index,size,_data[index].sanad);
                          AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 575),
                            child: SlideAnimation(
                              child: FadeInAnimation(
                                child:  TakhsisAccordion(widget._Agentdata,_data,index,size,_data[index].sanad)
                                ,
                              ),
                            ),
                          );
                        });
                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)      )
            ],),
          _data2.length < 1 && isFree == false ?
          Comp.loadingList_shimmer(size.height , size.width) : Center()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          //    Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
          new_takhsis_page(widget._Agentdata))));

        },
      ),

    );
  }



  Widget item ( FaIcon icon,String txt){
    Color C_Icon = Color(0xff7277c3);
    Color C_Line = Color(0x55e80c2b);
    return Column(children: [
        icon,
      Divider(height: 2,color: C_Line),
      Text( txt == null ? "-" : txt,
          style: TextStyle(
              color: primary, fontSize: 15, letterSpacing: .3)),
    ],);
  }


}