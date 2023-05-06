
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';
import 'enable_req_model.dart';

class list_enable_request extends StatefulWidget {
  String terminal ;
  list_enable_request(this.terminal);
  @override
  State<StatefulWidget> createState() => pos_jaygozini_pageState();

}

class pos_jaygozini_pageState extends State<list_enable_request> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<EnableReqModel> _data = [];
  List<EnableReqModel> _data2 = [];
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xff000000);
  late Map response;
  Future<List<EnableReqModel>>_getData() async {
    i++;
    if (i <2) {
     response = await OnlineServices.getEnableReqList({"terminal" : widget.terminal} );
    // response = await OnlineServices.getEnableReqList({"terminal" : "92980768"} );
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      _data2.addAll(response['data']);
      setState(() {});

    }
    else
    {
      isFree = true;
      Comp.showSnackEmpty(context);
      setState(() {});
    }
    }
    return _data;


  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست درخواست های فعالسازی","", Icons.edit, (){})),

      body: Stack(
        children: [
          Column(
            children: [

              Expanded(child:
                FutureBuilder<List<EnableReqModel>>(future: _getData(),
                builder: (context, AsyncSnapshot<List<EnableReqModel>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: _data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildList(context, index);
                        });

                  }
                  else if (snapshot.hasError) {return Container();} else return Container() ;},)),
            ],
          ),
          _data2.length < 1 && isFree == false ?
          Comp.showLoading(size.height , size.width) : Center()
        ],
      ),

    );
  }
  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        Container(
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 1),
              borderRadius: BorderRadius.circular(7),
              color: Colors.white,
            ),
            width: double.infinity,
            // height: 110,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.date_range_outlined,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),

                        Text(  _data[index].tarikh,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.timelapse_sharp,
                          color: secondary,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
//عکس کارت ملی
                        Text(  _data[index].saat,
                            style: TextStyle(
                                color: primary, fontSize: 13, letterSpacing: .3)),
                      ],
                    ),

                  ],
                ),
                Divider(thickness: .7,color: Color(0xff565656)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text( _data[index].vaziat == null ? "-" : _data[index].vaziat,
                                  style: TextStyle(
                                      color: primary, fontSize: 13, letterSpacing: .3)),
                            ),
                          ],
                        ),

                      ],
                    )),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.scatter_plot_outlined,
                              color: secondary,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text( _data[index].tozih == null ? "-" : _data[index].tozih,
                                  style: TextStyle(
                                      color: primary, fontSize: 13, letterSpacing: .3)),
                            ),
                          ],
                        ),

                      ],
                    )),
                  ],
                ),

              ],
            )
        ),
        //Positioned(child: ElevatedButton(onPressed: (){terminal(_data[index].sanad);},style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.teal)), child: Text("ترمینال")),left: 20,bottom: 8,)
      ],
    )  ;
  }


}
