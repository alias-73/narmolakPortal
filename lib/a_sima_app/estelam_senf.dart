
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sima_portal/a_sima_app/device/list_device.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModel.dart';
import 'package:sima_portal/a_sima_app/models/brandModelModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirandeModel2.dart';
import 'package:sima_portal/a_sima_app/models/soeichModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';

import 'models/senfModel.dart';

class estelam_senf extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<estelam_senf> {
  String _key14 = "";
  bool isAllow2 = false;
  bool isAllow3 = false;
  String _key15 = "";
  List<String> _Senf = [];
  List<String> _SenfT = [];
  String _Senff = "صنف";
  List<SenfModel> _data1 = [];
  late List<String> ss = [];
  bool loading = false;
  bool isallow = false;
  late TextEditingController _controller1 = TextEditingController(text: "صنف");

  void getSenfList2() async {
    //await OnlineServices.check(1) == "111" ?
    // isallow = true : isallow = false;
    isallow = true;
    // print(isallow);
    Map response = await OnlineServices.getSenfList2();

    ss.clear();

    for (int i = 0 ; i < response["data"].length ; i++)
    {
      ss.contains(response["data"][i]["name"] + "##") ? null : ss.add(response["data"][i]["name"] + "##" );
      ss.add(response["data"][i]["name"] + "*" + response["data"][i]["raste"]);
    }
    isallow == false ? ss.clear() : null;

    setState(() {});

  }

  void getSenfList() async {
    Map response = await OnlineServices.getSenfList();
    _data1.clear();
    _Senf.clear();
    _data1.addAll(response['data']);

    for (int i = 0 ; i< _data1.length ; i++)
    {
      _Senf.add(_data1[i].senfName);
    }
    setState(() {
    });

  }

  @override
  void initState() {
    getSenfList();
    getSenfList2();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color cl = Color(0xff000000);
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("استعلام صنف","", Icons.edit, (){})),

      backgroundColor: Theme.of(context).primaryColor,
      // resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(child:
      Column(
        children: [
          SizedBox(height: 20,),
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                height: 110,
                margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  // initialValue: "_Senff",
                  controller: _controller1,
                  enabled: false,
                  cursorColor: Colors.black,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.zero,

                    prefixIcon: Icon(
                      Icons.storefront_outlined,
                      color: Colors.black,
                    ),

                    labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: cl,width: 1.0)),
                    labelText: "صنف",
                    disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(color: cl,width: 1.0)),
                  ),
                ),
              ),
              Container(
                height: 110,
                margin: EdgeInsets.only(right: 30, left: 30, bottom: 6),
                width: size.width,
                padding: EdgeInsets.only(right: 60,left: 20),
                child:  SearchableDropdown.single(
                  style: TextStyle(color: Color(0x00000000)),
                  items: ss.map((String val) {
                    return DropdownMenuItem<String>(

                      value: val,
                      child:
                      Container(
                        alignment:val.contains("##") ? Alignment.topRight : Alignment.center,
                        margin: EdgeInsets.zero,
                        padding: EdgeInsets.all(5),
                        child: Text( val.contains("##") ? val.toString().replaceAll("##", "") :  val.split("*")[1] , style: TextStyle(fontWeight: val.contains("##") ? FontWeight.w800 : FontWeight.w200),),
                      )  ,
                    );
                  }).toList(),
                  underline: Container(),
                  // value: ,
                  searchHint: "انتخاب صنف",
                  onChanged: (value) {
                    isAllow2 = false;
                    isAllow3 = false;
                    _Senff = value.contains("##") ? "_ _ _" : value.split("*")[1];
                    if (value.toString().contains("##"))
                    {
                      Comp.showSnack(context, Icons.warning_amber_rounded, "لطفا زیر دسته مورد نظر را انتخاب کنید");
                    }
                    else {
                      _controller1 = TextEditingController(text: value.split("*")[1]);
                      // print(value);
                      _key14 = value.split("*")[0];
                      _key15 = value.split("*")[1];
                      checkSenf(_key14.split("-")[0]);

                    }
                  },
                  isExpanded: true,
                ),),

            ],
          ),
          isAllow3 ? Column(
            children: [Icon( Icons.warning_amber,color: Colors.red,size:70 ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Column(
                children: [
                  Text("در صورت انتخاب این صنف،",
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,),
                  Text("فرم استشهاد",
                    style: TextStyle(decoration: TextDecoration.underline ,fontSize: 26,fontWeight: FontWeight.w700,color: Colors.red),textAlign: TextAlign.center,),
                  Text("مورد قبول نخواهد بود و فقط",
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,)
                  ,    Text("جواز کسب",
                    style: TextStyle(decoration: TextDecoration.underline ,fontSize: 26,fontWeight: FontWeight.w700,color: Colors.green),textAlign: TextAlign.center,),
                  Text("مورد تایید است.",
                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,),


    ],
              ),)
            ],
          ):
          Column(
            children: [Icon( Icons.warning_amber,color: Colors.red,size:70 ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: Column(
                children: [
                  Text("در صورت انتخاب این صنف،",
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,),
                  Text("فرم استشهاد یا جواز کسب",
                    style: TextStyle(decoration: TextDecoration.underline ,fontSize: 26,fontWeight: FontWeight.w700,color: Colors.green),textAlign: TextAlign.center,),
                  Text("مورد تایید است.",
                    style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700,color: Colors.black),textAlign: TextAlign.center,),


                ],
              ),)
            ],
          ),
        ],
      )),
    );
  }
  void checkSenf(String split) async {
    String response = await (OnlineServices()).checkSenf(
        {  "code" : split });
    if(response == "yes")
    {
      isAllow2=true;
      isAllow3=true;
    }
    else if(response == "no")
    {
      isAllow2=true;
    }
    setState(() {});
    // print(response);
  }
}