
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/Moaref/moaref-model.dart';
import 'package:sima_portal/a_sima_app/Moaref/new_moaref.dart';

import 'package:sima_portal/a_sima_app/Takhsis/new_takhssis.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import 'components/Styles.dart';

class tarh_page extends StatefulWidget {
  //List<AgentModel> _Agentdata = [];
  //tarh_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => pos_registered3_pageState();

}

class pos_registered3_pageState extends State<tarh_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  late Map response;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست طرح ها","", Icons.edit, (){})),

      body: SingleChildScrollView(child:
          Column(
            children: [
              buildList("100.000" , "10" , "با خرید این بسته از 10% اعتبار بیشتر برخوردار شوید"),
              buildList("200.000" , "20" , "با خرید این بسته از 15% اعتبار بیشتر برخوردار شوید"),
              buildList("500.000" , "40" , "با خرید این بسته از 40% اعتبار بیشتر برخوردار شوید"),
           //   buildList2(context),
            ],

          )
      ),


    );
  }
  Widget buildList(String price , String offer , String explain) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height-appBarHeight;
    return Container(
      padding: EdgeInsets.zero,
      height: mainHeight * .23,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
       // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                Column(children: [
                  Text("مبلغ:",style: TextStyle(fontSize: 18),),
                  Text("${price} تومان",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                ],),
                Column(children: [
                  Text("هدیه:",style: TextStyle(fontSize: 20),),
                  Text("${offer} %",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                ],),

              ],
            ),
            Container(
              child: Text(explain,style: TextStyle(fontSize: 15),),
              decoration: BoxDecoration(color: Color(0x22000000)),
            ),
            ElevatedButton(onPressed: (){Comp.showSnack(context, Icons.phone, "برای خرید، لطفا با مدیر پروژه تماس بگیرید");}, child: Text("خرید",style: TextStyle(fontSize: 23,color: Colors.white),),
            )
          ],
        )
    )  ;
  }


  Widget buildList2(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double appBarHeight = AppBar().preferredSize.height;
    var blockSize = size.width / 100;
    double mainHeight = size.height-appBarHeight;
    return Container(
        height: mainHeight * .23,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
      //  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("افزایش اعتبار به مبلغ دلخواه",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w700),)
,
            Container(padding: EdgeInsets.zero,
              child: Text("با انتخاب این گزینه میتوانید به مبل دلخواه افزایش اعتبار بدهبد",style: TextStyle(fontSize: 15),),
              decoration: BoxDecoration(color: Color(0x22000000)),
            ),
            ElevatedButton(onPressed: (){Comp.showSnack(context, Icons.phone, "برای خرید این طرح لطفا با مدیر پروژه تماس بگیرید");}, child: Text("خرید",style: TextStyle(fontSize: 23,color: Colors.white),),
            )
          ],
        )
    )  ;
  }


}
/*
Container(
                padding: EdgeInsets.only(top: 6),
                height: MediaQuery.of(context).size.height- 50,
                width: double.infinity,
                child: FutureBuilder<List<MoarefModel>>(future: _getData(),
                  builder: (context, AsyncSnapshot<List<MoarefModel>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                          });

                    }
                    else if (snapshot.hasError) {return Container();} else return Container() ;},),
              )
 */