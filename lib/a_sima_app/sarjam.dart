
//
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/EM/sarjamAccordian.dart';

import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';


import 'models/sarjamModel.dart';


class sarjam_page extends StatefulWidget {
  List<AgentModel> _data = [];
  sarjam_page(this._data);
  @override
  State<StatefulWidget> createState() => sarjam_pageState();
}

class sarjam_pageState extends State<sarjam_page> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();
  DateTime selectedDate = DateTime.now();
  int currentPageIndex = 0;
  List<SarjamModel> _data = [];
  int i = 0;
  bool isFree = false;
  late Map response;
  bool loading = false;
  String srch = "-";
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);

  void _getData() async {

    response = await OnlineServices.checkSarjam({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "terminal": _key1.currentState!.value.toString()
    });
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      setState(() {});
    }
    else {

      CoolAlert.show(
          context: context,
          type: CoolAlertType.warning,
          confirmBtnText: "بستن",
          onConfirmBtnTap: (){
            Navigator.pop(context);
          },
          title: "",
          backgroundColor: Colors.white,
          text: "اطلاعاتی یافت نشد"
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("گزارش سرجمع تراکنش","", Icons.edit, (){})),
      body:  Stack(
        children: [
          Column(
            children: [
              SizedBox(height: 6,),
              Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(alignment: Alignment.center,height: 50,
              width: size.width * .5,
              margin: EdgeInsets.only(right: 25, top: 13),
              child: TextFormField(
                enabled: _data.isNotEmpty ? false : true,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text ,
                cursorColor: cl,
                textAlign: TextAlign.center,
                key: _key1,
                style: TextStyle(color: cl, fontWeight: FontWeight.w800),
                decoration: InputDecoration(
                  counterText: "",
                  prefixIcon: Icon(
                    Icons.adjust_outlined,
                    color: cl,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: cl,
                      width: 1.0,
                    ),
                  ),
                  fillColor: cl,
                  focusColor: cl,
                  hoverColor: cl,
                  contentPadding: EdgeInsets.zero,

                  //errorText: _errorText1,
                  labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: cl)),

                  labelText: "ترمینال",
                  disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(color: Colors.black)),
                  // errorText: 'Error message',
                  border: OutlineInputBorder(borderSide: BorderSide(color: cl)),

                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 25,top: 12),
              child: ElevatedButton(onPressed: (){
                _data.clear();
                if (_key1.currentState!.value.toString().length > 1) {
                  _getData();
                } else
                  Comp.showSnackError(context);} , child: Text("بـررسـی ترمینال",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 16),),style: ButtonStyle(shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(color: Colors.teal)
                  )
              ),minimumSize: MaterialStateProperty.all(Size(size.width * .28, 10)),elevation: MaterialStateProperty.all(10),padding: MaterialStateProperty.all(EdgeInsets.only(right: 15,left: 15,top: 5,bottom: 5)),backgroundColor: MaterialStateProperty.all(Colors.teal)),),),
          ],
        ),
              Expanded(child:
              ListView.builder(
                  itemCount: _data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SarjamAccordion(_data,index,size);
                  })
              )


            ],),
          loading == true ?
          Comp.showLoading(size.height , size.width) : Center()
        ],
      ),


    );
  }


}