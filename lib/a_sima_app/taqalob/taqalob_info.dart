
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_date/persian_date.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/taqalob/taqalob-model.dart';
import 'package:sima_portal/a_sima_app/taqalob/taqalob-model2.dart';

class taqalobInfo extends StatefulWidget {
  String rahgiri;
  List<AgentModel> _Agentdata = [];
  taqalobInfo(this.rahgiri, this._Agentdata);

  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<taqalobInfo> {
  List<TaqalobModel2> _data = [];
  final _key1 = GlobalKey<FormFieldState>();

  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
  late Map response;
  bool loading = false;
  int? val = -1;

  Future<List<TaqalobModel2>> _getData() async {
    // print(widget.rahgiri);
    i++;
    if (i < 2) {
      response = await OnlineServices.getTaqalobInfo({
        "rahgiri": widget.rahgiri
      });
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        setState(() {});
      } else {
        isFree = true;
        Comp.showSnackEmpty(context);
        setState(() {});
      }
    }
    return _data;
  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
        backgroundColor: Color(0xfff1f1f1),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Comp.appBarHeight),
            child: Comp.app_bar("ثبت شرح نماینده", "", Icons.edit, () {})),
        body: Stack(
          children: [


                FutureBuilder<List<TaqalobModel2>>(
                  future: _getData(),
                  builder: (context, AsyncSnapshot<List<TaqalobModel2>> snapshot) {
                    if (snapshot.hasData) {
                      return          SingleChildScrollView(
                          child: Column(
                        children: [
                          txtField("نام پذیرنده", _data[0].P_Name),
                          txtField("نام فروشگاه", _data[0].F_Name),
                          txtField("نام ترمینال", _data[0].terminal),
                          txtField("تاریخ", _data[0].date),
                          txtField("تماس", _data[0].tell + " - " + _data[0].mobile ),
                          txtField("شهر", _data[0].ostan + " - " + _data[0].shahr ),
                          txtField("آدرس", _data[0].address),
                          txtField("شرح", _data[0].sharh),
                          SizedBox(height: 10,),

                          Text("آیا پذیرنده متخلف میباشد؟",style: TextStyle(color: Colors.red,fontWeight: FontWeight.w900,decoration: TextDecoration.underline,fontSize: 19)),

                          Row(mainAxisAlignment: MainAxisAlignment.center,children: [
                            SizedBox(width: size.width * .4,child: ListTile(
                              title: Text("بلی",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                              leading: Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int?;
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                            )),
                            SizedBox(width: size.width * .4,child: ListTile(
                              title: Text("خیر",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w800),),
                              leading: Radio(
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.red,
                              ),
                            )),
                          ]),



                           Comp.editBox1(context,1,0, "شرح", Icons.drive_file_rename_outline, _key1, ""),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Comp.miniBtn1(context ,size, "ثبت اطلاعات", Colors.teal , fun , 1),
                              Comp.miniBtn1(context , size, "انصراف", Colors.teal , (){} , 2),
                            ],
                          ),

                        ],
                      ));

                    } else if (snapshot.hasError) {
                      return Container();
                    } else
                      return Container();
                  },

            ),
            loading == true ? Comp.showLoading(size.height , size.width) : Center(),
            _data.length < 1 && isFree == false ?
            Comp.loadingList_shimmer(size.height , size.width) : Center()

          ],
        )

    );
  }

  void fun(){
    // sendDataForTakhsis();

    if (_key1.currentState!.value.toString().isNotEmpty && val != -1)
    {
      loading = true;
      setState(() {});

      sendDataForTaqalob();
    }
    else Comp.showSnack(context, Icons.warning_amber_rounded, "0");
  }

  void _showDialog(BuildContext context ,String txt) {
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
              ElevatedButton(onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context);
                //Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));

              },
                  child: Text("بستن",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16),))
            ],
          ),
        );
      },
    );
  }


  Future<String> sendDataForTaqalob() async {

    PersianDate persianDate = PersianDate();String today = persianDate.getDate.toString().substring(0, persianDate.getDate.toString().length - 13).replaceAll("-", "/");String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;

    String response ;
    response = await (OnlineServices()).sendDataForSaveTaqalob( {"pasokhtarikh": today, "pasokhsaat": datetime,"rahgiri" : widget.rahgiri , "takhalof": val == 1 ? "بلی" : "خیر" ,"pasokhsharh": _key1.currentState?.value   });
    //  print(response);
    if (response== "ok")
    {
      _showDialog(context, "اطلاعات با موفقیت ارسال شد");
    }
    else{
      // print("errrror");
    }
    return "";
  }


  Widget txtField(String title, String desc){
  var size = MediaQuery.of(context).size;

  return Container(
    alignment: Alignment.topRight,
  margin: const EdgeInsets.only(top: 18,right: 15,left: 15),
  decoration: BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 1.0, color: Color(0xff8f8f8f)),
    ),  ),
   child: Row(
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       SizedBox(width: 20,),
       SizedBox(width: size.width * .25,child: Text(title + " :" ,
           textAlign: TextAlign.right,
           style: TextStyle(
               fontWeight: FontWeight.w600,
               color: Colors.black,
               fontSize: 15)),),
       Flexible(child: Text(desc ,
           textAlign: TextAlign.right,
           maxLines: 2,
           style: TextStyle(
               fontWeight: FontWeight.w600,
               color: Colors.black,
               fontSize: 15)))
     ],
   ));
}

}