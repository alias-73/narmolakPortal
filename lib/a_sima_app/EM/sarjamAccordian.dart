import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:sima_portal/a_sima_app/models/sarjamModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

class SarjamAccordion extends StatefulWidget {
  int index;
  var size;
  List<SarjamModel> _data = [];

  SarjamAccordion(this._data, this.index, this.size);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<SarjamAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
  double fontSize1 = 15;
  double fontSize2 = 15;
  double iconSize1 = 28;
  double iconSize2 = 20;

  // var size = MediaQuery.of(widget.context).size;
  Future<String> getImgBank(String name) async {
    String response = await OnlineServices.getImgBank({
      "bank": name
    });
    //print (await response);
    return response;
  }

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
        child: Column(children: [
          ListTile(
              title:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: (widget.size.width - 10) * .49,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.date_range, color: Colors.black,),
                        SizedBox(width: 5,),
                        Flexible(
                            child: Text(  widget._data[widget.index].mah == "1" ? "فروردین  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "2" ? "اردیبهشت  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "3" ? "خرداد  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "4" ? "تیر  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "5" ? "مرداد  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "6" ? "شهریور  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "7" ? "مهر  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "8" ? "آبان  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "9" ? "آذر  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "10" ? "دی  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "11" ? "بهمن  " + widget._data[widget.index].sal  :
                              widget._data[widget.index].mah == "12" ? "اسفند  " + widget._data[widget.index].sal  :
                            widget._data[widget.index].sal + "/" + widget._data[widget.index].mah
                              ,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: primary,
                                  fontSize: fontSize1,
                                  fontWeight: FontWeight.w500),
                              maxLines: 2,
                            )),
                      ],
                    ),
                  ),
                  Image.asset("assets/images/pasargad.png",height: 33,)
                ],
              ),
          ),
          _showContent
              ? Column(children: [
                  Padding(
                    child: Divider(
                      height: 0,
                      color: Color(0xff000000),
                    ),
                    padding: EdgeInsets.only(right: 20, left: 20, bottom: 4),
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
                          bottom: 0, top: 5, right: 10, left: 10),
                      padding: EdgeInsets.only(
                          bottom: 0, top: 5, right: 10, left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                children: [

                                   items("دارای تراکنش" , widget._data[widget.index].tarakoneshhas ),
                                   h(),
                                  items("تعداد کل", widget._data[widget.index].tedadkol),

                                  h(),
                                    items("تعداد قبض", widget._data[widget.index].qabztedad),
                                  h(),
                                    items("تعداد خرید", widget._data[widget.index].kharidtedad),
                                  h(),
                                    items("تعداد شارژ", widget._data[widget.index].sharjtedad),

                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  items("مانده گیری", widget._data[widget.index].mandetedad),
                                  h(),
                                  items("مبلغ کل", widget._data[widget.index].mablaqkol, ),

                                  h(),
                                  items("جمع قبض", widget._data[widget.index].qabzsum),
                                  h(),
                                  items("جمع خرید", widget._data[widget.index].kharidsum),
                                  h(),
                                  items("جمع شارژ", widget._data[widget.index].sharjsum),

                                  //  Text("txt" , style: TextStyle(color: Color(0x00000000), fontSize: 13)),
                                //  h(),
                                //  Text("txt" , style: TextStyle(color: Color(0x00000000), fontSize: 13)),
                                ],
                              )),
                            ],
                          ),
                          h(),
                          //  SizedBox(height: 6),
                        ],
                      ))
                ])
              : Container()
        ]),
      ),
    );
  }





  Widget h() {
    double s = 12;
    return SizedBox(height: s);
  }

  Widget items(String title,String txt) {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * .19,child: Text(title+":" + " ",
        style: TextStyle(
            color: primary, fontSize: 12)),),

        Flexible(
            child: Text(txt == null ? "-" : txt.toPersianDigit(),
                style: TextStyle(
                    color: primary, fontSize: 14, fontWeight: FontWeight.w600))),
      ],
    );
  }


  Widget items2(String txt) {
    return Row(
      children: [
        Icon(Icons.account_balance),
        SizedBox(
          width: 5,
        ),
        Flexible(
            child: Text(txt == null ? "-" : txt,
                style: TextStyle(
                    color: primary, fontSize: 13, letterSpacing: .3))),
      ],
    );
  }
}
