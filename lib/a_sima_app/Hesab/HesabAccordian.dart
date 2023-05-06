import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'shaba-model.dart';

class HesabAccordion extends StatefulWidget {
  int index;
  var size;
  List<ShebaModel> _data = [];

  HesabAccordion(this._data, this.index, this.size);

  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<HesabAccordion> {
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
              title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: (widget.size.width - 10) * .49,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 40,child: FutureBuilder<String>(
                      future: getImgBank(widget._data[widget.index].bank),
                      builder: (context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.hasData) {
                          return CachedNetworkImage(
                            height: 30,
                            imageUrl: snapshot.data!.toString(),
                            placeholder: (context, url) =>
                                Container(height: 30,width: 30,),
                            errorWidget: (context, url, error) =>
                                Image.asset("assets/images/Markazi.jpg"),
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        } else
                          return Container();
                      },
                    ),),
                    SizedBox(width: 5,),
                    Flexible(
                        child: Text(
                      widget._data[widget.index].name == null
                          ? "-"
                          : widget._data[widget.index].name,
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
              Row(
                children: [
                  widget._data[widget.index].soeich == "پرداخت نوین" ? Image.asset(height: 25,"assets/images/novin.png") :
                  widget._data[widget.index].soeich == "ایران کیش" ? Image.asset(height: 25,"assets/images/irankish.png") :
                  widget._data[widget.index].soeich == "سداد" ?      Image.asset(height: 25,"assets/images/sadad.png") :
                  widget._data[widget.index].soeich == "پاسارگاد" ?  Image.asset(height: 25,"assets/images/pasargad.png") :
                  widget._data[widget.index].soeich == "سپهر" ?      Image.asset(height: 25,"assets/images/sepehr.png") :
                  widget._data[widget.index].soeich == "به پرداخت" ? Image.asset(height: 25,"assets/images/behpardakht.png") :
                  Center(),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget._data[widget.index].status,
                      style: TextStyle(
                          color: widget._data[widget.index].status
                                  .toString()
                                  .contains("اصلاح")
                              ? Colors.red
                              : widget._data[widget.index].status
                                      .toString()
                                      .contains("تایید")
                                  ? Colors.blue
                                  : widget._data[widget.index].status
                                          .toString()
                                          .contains("فعال")
                                      ? Colors.green
                                      : primary,
                          fontSize: fontSize1))
                ],
              )
            ],
          )),
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

                                   items2(widget._data[widget.index].bank),
                                   h(),
                                    items(widget._data[widget.index].hesab_no, Icons.edit),

                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                   items(widget._data[widget.index].shobe, Icons.storefront),
                                  h(),
                                  h(),
                                  h(),
                                //  Text("txt" , style: TextStyle(color: Color(0x00000000), fontSize: 13)),
                                //  h(),
                                //  Text("txt" , style: TextStyle(color: Color(0x00000000), fontSize: 13)),
                                ],
                              )),
                            ],
                          ),
                          h(),
                          items(widget._data[widget.index].sheba_no, Icons.drive_file_rename_outline),
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

  Widget items(String txt, IconData ic) {
    return Row(
      children: [
        Icon(ic),
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
