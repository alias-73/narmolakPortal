import 'package:flutter/material.dart';

import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeMaliyat-model.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'edit_Pazirande.dart';
import 'edit_PazirandeH.dart';
import 'list_memberCo.dart';
import 'list_pazirande.dart';

class PazirandeMaliatAccordion extends StatefulWidget {
  int index;
  var size;
  List<PazirandeMaliyatModel> _data = [];
  List<AgentModel> _Agentdata = [];

  PazirandeMaliatAccordion(this._data, this.index, this.size, this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<PazirandeMaliatAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
   double fontSize1 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
  final _key1 = GlobalKey<FormFieldState>();
  String _key2 = " ";
  Color cl = Color(0xff000000);
  late String today = "";
  late String datetime = "";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        setState(() {
          _showContent = !_showContent;
        });
      },
      child: Card(
          margin: EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Column(children: [
                  ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: (widget.size.width - 10) * .59,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon( Icons.person_outline),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                    flex: 1,
                                    child: Text(
                                      widget._data[widget.index].name == null
                                          ? "-"
                                          : widget._data[widget.index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: primary,
                                          fontSize: fontSize1,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 4,
                                    )),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Icon(Icons.info_outline,
                                  color:  Colors.black),
                              SizedBox(
                                width: 10,
                              ),
                              Text(widget._data[widget.index].sanad,
                                  style: TextStyle(
                                      color:  Colors.black,
                                      fontSize: fontSize1))
                            ],
                          )
                        ],
                      )),
                _showContent
                    ? Stack(
                    alignment: Alignment.centerLeft,
                    children:[Column(
                        children: [
                          Padding(
                            child: Divider(
                              height: 0,
                              color: Color(0xff000000),
                            ),
                            padding:
                                EdgeInsets.only(right: 20, left: 20, bottom: 4),
                          ),
                          Container(
                              alignment: Alignment.topRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: Colors.white,
                              ),
                              width: double.infinity,
                              // height: 110,
                              margin: EdgeInsets.only(
                                  bottom: 0, top: 3, right: 10, left: 10),
                              padding: EdgeInsets.only(
                                  bottom: 0, top: 0, right: 10, left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                          child: Column(children: [
                                          items(widget._data[widget.index].foroshgah, Icons.store),
                                          h(),
                                          items(widget._data[widget.index].mobile, Icons.phone_iphone),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          items(
                                              widget._data[widget.index].terminal,
                                              Icons.drive_file_rename_outline),
                                          h(),
                                          items(widget
                                              ._data[widget.index].tel, Icons.apps),

                                        ],
                                      )),

                                    ],
                                  ),
                                  h(),
                                  items(widget._data[widget.index].sharh, Icons.warning_amber_rounded),
                                  h(),
                                  items(widget._data[widget.index].address, Icons.location_on),
                                  h(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Container(width: size.width*.5,
                                          child: items("مهلت انجام: "+widget._data[widget.index].mohlat, Icons.timer)),
                                      ElevatedButton(onPressed: (){
                                        eqdam(widget._data[widget.index].terminal);
                                      }, child:
                                      Text("   اقدام شد    ",style: TextStyle(fontSize: 17),))

                                    ],
                                  ),
                                  h(),
                                ],
                              ))
                        ],
                      )

                ])
                    : Container ()
              ]),

            ],
          )),
    );
  }

  Future eqdam(String terminal) async {
    String response = await OnlineServices.eqdam({"terminal": terminal});
    response = response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response== "ok") {
      widget._data.removeWhere((element) => element.terminal.contains(terminal));
      setState(() {});
      _showDialog(context, "عملیات با موفقیت انجام شد");
    }
    else
    _showDialog(context, "خطا در عملیات");
  }


  void  ebtalReq(String sanad) async {

    String datetime ="";
    String response = await OnlineServices.ebtalRequest(
        {
          "agentcode": widget._Agentdata.last.agentCode,
          "usercode": widget._Agentdata.last.userCode,
          "tarikh": today,
          "saat": datetime,
          "sanad": sanad,
          "sharh": _key1.currentState!.value.toString(),
          "dalil": _key2.toString(),
        });
    if(response.contains("ok"))
      {
        _showDialogEbtal(context,"درخواست با موفقیت اسال شد");
       // print("______________________");
      }
    else
      {
       // print("__________asdasd____________");
      }

  }

  void _showDialogEbtal(BuildContext context, String txt) {
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
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: poses_list_page(widget._Agentdata))));
                  },
                  child: Container(
                    // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      )))
            ],
          ),
        );
      },
    );
  }


  Widget txt(String txt) {
    Color c = Colors.white;
    double s = 15;
    return Align(
      child: Column(
        children: [
          Text(txt, style: TextStyle(fontSize: s, color: c)),
          Divider(
            color: Colors.white,
            height: 2,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    );
  }

  Future terminal(String sanad) async {
    String response = await (OnlineServices()).terminal({"sanad": sanad});
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
    _showDialog(context, ter);
  }

  Future hesab(String sanad) async {
    String response = await (OnlineServices()).hesab({"sanad": sanad});
    String hes;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 4)
      hes = "حساب پیدا نشد";
    else
      hes = "بانک: " +
          response.split(",")[0] +
          "     شعبه: " +
          response.split(",")[1] +
          "\n"
              "حساب: " +
          response.split(",")[2] +
          "\n"
              "شبا: " +
          response.split(",")[3];
    _showDialog(context, hes);
  }

  Future khata(String sanad) async {
    //   print (sanad);

    String response = await (OnlineServices()).khata({"sanad": sanad});
    print("-" +
        response
            .replaceAll("\n", "")
            .replaceAll("\r", "")
            .replaceAll("\t", "") +
        "-");
    _showDialog(
        context,
        response
            .replaceAll("\n", "")
            .replaceAll("\r", "")
            .replaceAll("\t", "")
            .toString());
    //if (int.parse(response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "")) > version) {_showDialog(context);}
  }

  void _showDialog(BuildContext context, String txt) {
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
                  child: Container(
                      // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 13),
                      )))
            ],
          ),
        );
      },
    );
  }


  Widget h() {
    double s = 12;
    return SizedBox(height: s);
  }

  Widget items(String txt, IconData ic) {
     double fontSize2 = 14;
    return Row(
      children: [
        Icon(ic),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }

  Widget items23(String txt) {
     double fontSize2 = 14;
    return Row(
      children: [
        txt == "پاسارگاد"
            ? Image.asset("assets/images/pasargad.png", height: 30)
            : txt == "ایران کیش"
                ? Image.asset("assets/images/irankish.png", height: 30)
                : Icon(Icons.apps),
        // SizedBox(width: 5,),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }
}
