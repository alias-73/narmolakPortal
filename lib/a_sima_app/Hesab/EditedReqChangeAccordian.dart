import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/changeModel2.dart';

class EditedReqAccordion extends StatefulWidget {
  int index;
  var size;
  List<ChangeModel2> _data = [];
  List<AgentModel> _Agentdata = [];

  EditedReqAccordion(this._data, this.index, this.size, this._Agentdata);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<EditedReqAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
   double fontSize1 = 15;
  var iconSize1 = 28;
   double fontSize2 = 13;

  var iconSize2 = 20;

  // var size = MediaQuery.of(widget.context).size;

  @override
  Widget build(BuildContext context) {
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
                      width: (widget.size.width - 10) * .45,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.person),
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
                            color: widget._data[widget.index].status
                                    .toString()
                                    .contains("حال")
                                ? Colors.deepOrange
                                : widget._data[widget.index].status
                                        .toString()
                                        .contains("رد")
                                    ? Colors.red
                                    : widget._data[widget.index].status
                                            .toString()
                                            .contains("تایید")
                                        ? Colors.green
                                        : primary),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget._data[widget.index].status,
                            style: TextStyle(
                                color: widget._data[widget.index].status
                                        .toString()
                                        .contains("حال")
                                    ? Colors.deepOrange
                                    : widget._data[widget.index].status
                                            .toString()
                                            .contains("رد")
                                        ? Colors.red
                                        : widget._data[widget.index].status
                                                .toString()
                                                .contains("تایید")
                                            ? Colors.green
                                            : primary,
                                fontSize: fontSize1))
                      ],
                    )
                  ],
                )),
                _showContent
                    ? Column(
                        children: [
                          Padding(
                            child: Divider(
                              height: 0,
                              color: Color(0xff000000),
                            ),
                            padding:
                                EdgeInsets.only(right: 20, left: 20, bottom: 4),
                          ),
                          Row(
                            children: [
                              Expanded(child: Padding(child: Text("اطلاعات قبلی",
                                  style: TextStyle(decoration: TextDecoration.underline,
                                      color: primary,
                                      fontSize: fontSize2)),padding: EdgeInsets.only(right: 22),),),
                              Expanded(child: Text("اطلاعات جدید",
                                  style: TextStyle(decoration: TextDecoration.underline,
                                  color: primary,
                                      fontSize: fontSize2)),),
                            ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        child:  Column(
                                            children: [
                                              items(
                                                  widget._data[widget.index]
                                                      .bankaold,
                                                  Icons.store),
                                              h(),
                                              items2(
                                                  widget._data[widget.index]
                                                      .shobeold,
                                                  Icons.store),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .hesabold,
                                                  Icons.phone_iphone),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                      .shebaold,
                                                  Icons.phone_iphone),
                                            ],
                                          )
                                       ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              items(
                                                  widget._data[widget.index]
                                                      .banknew,
                                                  Icons.store),
                                              h(),
                                              items2(
                                                  widget._data[widget.index]
                                                      .shobenew,
                                                  Icons.store),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .hesabnew,
                                                  Icons.phone_iphone),
                                              h(),
                                              items(
                                                  widget._data[widget.index]
                                                          .shebanew,
                                                  Icons.phone),
                                            ],
                                          )
                                        ),
                                    ],
                                  ),
                                  SizedBox(height: 9),
                                ],
                              ))
                        ],
                      )
                    : Container()
              ]),
            ],
          )),
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

  Widget h() {
    double s = 12;
    return SizedBox(height: s);
  }

  Widget items(String txt, IconData ic) {
     double fontSize2 = 14;

    return Row(
      children: [
        Icon(
          ic,
          size: 20,
        ),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }
  Widget items2(String txt, IconData ic) {
     double fontSize2 = 14;

    return Row(
      children: [
        Icon(
          ic,
          size: 19,
        ),
        //92847716
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(color: primary, fontSize: fontSize2))),
      ],
    );
  }
}
