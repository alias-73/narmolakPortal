import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/Pazirade/memberCo_upload.dart';
import 'package:sima_portal/a_sima_app/Takhsis/iranKish_upload.dart';
import 'package:sima_portal/a_sima_app/Takhsis/takhsis-model.dart';
import 'package:sima_portal/a_sima_app/login_page.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:flutter_icons/flutter_icons.dart';


class TakhsisAccordion extends StatefulWidget {
 // BuildContext context;
  int index;
  String sanad;
  var size;
  List<AgentModel> _Agentdata = [];

  List<TakhsisModel> _data = [];

  TakhsisAccordion(this._Agentdata, this._data,this.index,this.size,this.sanad);
  @override
  _AccordionState createState() => _AccordionState();
}

class _AccordionState extends State<TakhsisAccordion> {
  bool _showContent = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff26A1FF);
  String psp = " ";
   double fontSize1 = 15;
   double fontSize2 = 15;
  var iconSize1 = 28;
  var iconSize2 = 20;
 // var size = MediaQuery.of(widget.context).size;

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;
    return GestureDetector(onTap:(){
      setState(() {
      _showContent = !_showContent;
    });},child: Card(
      margin: EdgeInsets.only(bottom: 5,top: 10, right: 10, left: 10),
      child: Column(children: [
        ListTile(
            title:
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(width: (widget.size.width-10) * .49,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.person_pin,size: 25,),
                    SizedBox(
                      width: 5,
                    ),
                    Flexible(child: Text( widget._data[widget.index].name2 == null ? "-" : widget._data[widget.index].name2,
                      textAlign: TextAlign.center,style: TextStyle(
                            color: primary, fontSize: fontSize1, fontWeight: FontWeight.w500),maxLines: 2,)),
                  ],
                ),),
                Row(
                  children: [
                    Container(
                        height: 35,
                        // width: size.width,
                        child: FutureBuilder<String>(
                          future: _getPSP(widget.sanad),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              ///حسین صادق
                              return
                                snapshot.data!.toString().split(",")[0].contains("پرداخت نوین") ? Image.asset("assets/images/novin.png") :
                                snapshot.data!.toString().split(",")[0].contains("سپهر") ? Image.asset("assets/images/sepehr.png") :
                                snapshot.data!.toString().split(",")[0].contains("سداد") ? Image.asset("assets/images/sadad.png") :
                                snapshot.data!.toString().split(",")[0].contains("پرداخت") ? Image.asset("assets/images/behpardakht.png") :
                                snapshot.data!.toString().split(",")[0].contains("ایران") ? Image.asset("assets/images/irankish.png") :
                                Image.asset("assets/images/pasargad.png") ;
                            } else if (snapshot.hasError) {return Container();} else return Container();
                          },
                        )),
                    SizedBox(width: 10,),
                    Text( widget._data[widget.index].status,
                        style: TextStyle(
                            color: widget._data[widget.index].status.toString().contains("اصلاح") ? Colors.red : primary, fontSize: fontSize1))
                  ],
                ),

///90 و حورده 126
              ],
            )
        ),
        _showContent
            ? Column(children: [
          Padding(child: Divider(height: 0,color: Color(0xff000000),),padding: EdgeInsets.only(right: 20,left: 20,bottom: 4),),

          Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.white,
            ),
            width: double.infinity,
            // height: 110,
            margin: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
            padding: EdgeInsets.only(bottom: 0,top: 5, right: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    Expanded(child: Column(
                      children: [

                        items(widget._data[widget.index].sanad, Icons.tablet),
                        h(),
                      items(widget._data[widget.index].foroshgah, Icons.store),
                        h(),
                      items(widget._data[widget.index].terminal, Icons.adjust),
                        h(),
                      ],

                    )),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        items(widget._data[widget.index].serial, Icons.settings_cell_rounded),
                        h(),
                        items(widget._data[widget.index].brand, Icons.south_east_outlined),
                        h(),
                        items(widget._data[widget.index].model , Icons.branding_watermark_outlined),
                        h(),
                      ],

                    )),
                    Expanded(
                      child: Column(
                        children: [

                          Container(
                              height: size.height * .1 + 35,
                              width: size.width,
                              child: FutureBuilder<String>(
                                future: getImg(widget._data[widget.index].brand,widget._data[widget.index].model),
                                builder: (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return CachedNetworkImage(
                                      imageUrl: snapshot.data!.toString(),
                                      placeholder: (context, url) =>
                                          Image.asset("assets/images/pos3.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset("assets/images/pos3.png"),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else
                                    return Container();
                                },
                              ))
                        ],
                      ),
                    ),
                  ],
                ),
                //  SizedBox(height: 6),

              ],
            )
        ) ])
            : Container()
      ]),
    ),);
  }

  Future<String> _getPSP(String sanad) async {
    String response = await OnlineServices.getPSP3(
        {
          "sanad": sanad,
        });
    psp = response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "").split(",")[0];
    //print(response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", ""));
    return response.replaceAll("\n", "").replaceAll("\t", "").replaceAll("\r", "");
  }

  Widget h (){ double s = 12;return SizedBox( height: s); }
  Widget items (String txt , IconData ic){
     double fontSize2 = 14;

    return Row(
      children: [
        Icon(ic) ,
        SizedBox(
          width: 5,
        ),
        Flexible(child: Text( txt == null ? "-" :  txt,
            style: TextStyle(
                color: primary, fontSize: fontSize2))),

      ],
    );
  }

  Future<String> getImg(String _brand_value, String _model_value) async {
    String response = await OnlineServices.getDeviceImg({
      "brand": _brand_value,
      "model": _model_value
    });
    //print (await response);
    return response;
  }
}