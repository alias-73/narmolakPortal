
// ignore_for_file: missing_return, deprecated_member_use

//import 'package:accordion/accordion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/memberCo-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'MemberCoAccordian.dart';
import 'newMemberCo.dart';

class memberCo_page extends StatefulWidget {
  final String sanad;
  final String emza;
  List<AgentModel> _Agentdata = [];
  memberCo_page(this._Agentdata,this.sanad,this.emza);
  @override
  State<StatefulWidget> createState() => poses_list_pageState();
}

class poses_list_pageState extends State<memberCo_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<MemberCoModel> _data = [];
  List<MemberCoModel> _data2 = [];
  late Map response;
  bool isOpened = false;

  Future<List<MemberCoModel>> _getData() async {
    i++;
    if (i < 2) {
      response = await OnlineServices.getMemberCoList({
        "sanad": widget.sanad,
      });
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        // print(_data.length);
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].name == "" || _data[i].name == null)
            _data[i].name = "بدون نام";
        }

        Future.delayed(const Duration(milliseconds: 1000), () {setState(() {});});
      }
      else {
        isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    //print(widget.emza);
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),

      floatingActionButton: FloatingActionButton(
        backgroundColor: widget.emza == "تایید شد" ? Color(0xffACACAC) : Colors.green,
        child: Icon(Icons.person_add),
        onPressed: (){
          widget.emza == "تایید شد" ? null : Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
           newMemberCo(widget.sanad,widget._Agentdata,widget.emza))));
        },
      ),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست امضاکنندگان شرکت","", Icons.edit, (){})),

      body: Stack(children: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(child: FutureBuilder<List<MemberCoModel>>(
                  future: _getData(),
                  builder: (context,
                      AsyncSnapshot<List<MemberCoModel>> snapshot) {
                    if (snapshot.hasData) {
                      return
                        ListView.builder(
                            itemCount: _data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return buildList(context, index);
                            });
                    }

                    else if (snapshot.hasError) {
                      return Container();
                    } else
                      return Container();
                  },)

                ),
              ],
            ),
            _data2.length < 1 && isFree == false ?
            Comp.showLoading(size.height , size.width) : Center()
          ],
        ),
      ],),);
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return
      MemberCoAccordian(_data,index,size,widget._Agentdata,widget.sanad) ;
  }

  void _showDialog(BuildContext context , String txt) {
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
              ElevatedButton(onPressed: (){ Navigator.pop(context);
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
              },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4,bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(width: 1,color: Color(0xff000000),),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text("تایید",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),)
                  ))
            ],
          ),
        );
      },
    );
  }

}
