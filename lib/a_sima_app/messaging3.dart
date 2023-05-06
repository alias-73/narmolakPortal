

//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:sima_portal/a_sima_app/components/summaryForm.dart';
// import 'package:sima_portal/a_sima_app/models/agentModel.dart';
// import 'package:sima_portal/a_sima_app/models/messageModel.dart';
// import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
// import 'package:sima_portal/a_sima_app/services/online_services.dart';
// import 'package:sima_portal/a_sima_app/sima_home1.dart';
//
// class messaging3_page extends StatefulWidget {
//   List<AgentModel> _Agentdata = [];
//   messaging3_page(this._Agentdata);
//   @override
//   State<StatefulWidget> createState() => messaging3_pageState();
//
// }
//
// class messaging3_pageState extends State<messaging3_page> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   List<MessageModel> _data = [];
//   Future<List<MessageModel>>_getData() async {
//     Map response = await OnlineServices.getMessages({"agentcode" : widget._Agentdata.last.agentCode} );
//     _data.clear();
//     _data.addAll(response['data']);
//    // print(_data);
//     return _data;
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double fontSize1 = blockSize * 1;
//     double fontSize2 = blockSize * 2;
//     double fontSize3 = blockSize * 3;
//     double fontSize4 = blockSize * 4;
//     double fontSize5 = blockSize * 5;
//     double fontSize6 = blockSize * 6;
//     double fontSize7 = blockSize * 7;
//     double appBarHeight = AppBar().preferredSize.height;
//     double mainHeight = size.height-appBarHeight-65;
//     double itemHeight = mainHeight * .45;
//     double itemWidth = size.width * .45;
//     double widthItem = size.width * .8;
//     Color bcTextColor = Color(0x22000000);
//     Color textColor = Color(0xbb000000);
//     Color color = Color(0xff321654);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         alignment: Alignment.bottomCenter,
//         children: [
//           Container(
//             height: mainHeight ,
//             alignment: Alignment.center,
//             child:  FutureBuilder<List<MessageModel>>(future: _getData(),
//               builder: (context, AsyncSnapshot<List<MessageModel>> snapshot) {
//
//                 if (snapshot.hasData) {
//                   //  List<News> _news2 = snapshot.data!;
//                   return ListView.builder(
//                       itemCount: _data.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         return itemMessage(context, index);
//                       });
//
//                 }
//                 else if (snapshot.hasError) {return Container();} else return Container() ;},),
//           ),
//           ElevatedButton(onPressed: (){
//             Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_home1_page(widget._Agentdata))));
//
//                  sendDataForReadMessage();
//           },
//               child: Container(
//                   margin: EdgeInsets.only(bottom: 30),
//                   height: 50,
//                   // margin: EdgeInsets.only(top: 0),
//                   padding: EdgeInsets.only(top: 10,bottom: 10),
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Color(0x662962FF),
//                     border: Border.all(width: 1,color: Color(0xff000000),),
//                     borderRadius: BorderRadius.all(Radius.circular(5)),
//                     //  border: Border(color: Colors.black, width: 1.0),
//                   ),
//                   //  color: Colors.lightBlueAccent,
//                   width: size.width * .3,
//                   child: Text( "همه را خواندم" ,style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 16),)
//               ))
//         ],
//       )
//     );
//   }
//
//   Future<String> sendDataForReadMessage() async {
//
//     String response = await (OnlineServices()).sendDataForReadMessages(
//      //   {"agentcode" : widget._Agentdata.last.agentCode  });
//         {"agentcode" : "10002"  });
//     print("--" +response);
//     if (response== "ok")
//     {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: sima_home1_page(widget._Agentdata))));
//     }
//     else{
//       // print("errrror");
//     }
//
// return "";
//   }
//
//   Widget itemMessage(BuildContext , int index){
//     var size = MediaQuery.of(context).size;
//     var blockSize = size.width / 100;
//     double fontSize1 = blockSize * 1;
//     double fontSize2 = blockSize * 2;
//     double fontSize3 = blockSize * 3;
//     double fontSize4 = blockSize * 4;
//     double fontSize5 = blockSize * 5;
//     double fontSize6 = blockSize * 6;
//     double fontSize7 = blockSize * 7;
//     double appBarHeight = AppBar().preferredSize.height;
//     double mainHeight = size.height-appBarHeight-65;
//     double itemHeight = mainHeight * .45;
//     double itemWidth = size.width * .45;
//     double widthItem = size.width * .8;
//     Color bcTextColor = Color(0x22000000);
//     Color textColor = Color(0xbb000000);
//     Color color = Color(0xff321654);
//   return Container(
//               padding: EdgeInsets.all(20),
//               margin: EdgeInsets.only(top: 8,right: 14,left: 14),
//               width:  widthItem,
//               decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       colors: [color, Color(0x99000000)]
//                   ),
//                   color: bcTextColor,
//                   borderRadius: BorderRadius.all(Radius.circular(8)),
//                   border: Border.all(color:  color)
//               ),
//               child: Column(
//                 children: <Widget>[
//                   Text("تاریخ:  " + _data[index].date),
//                   Row(
//                     children: <Widget>[
//                       Icon(Icons.mail),
//                       SizedBox(width: 8),
//                       Flexible(child:
//                        Text(_data[index].message,
//                           overflow: TextOverflow.ellipsis,maxLines: 20,style: TextStyle(
//                             color: Color(0xff000000),fontSize: fontSize4,
//                           )))
//                     ],
//                   ),
//
//                 ],
//               ),
//             );
//   }
//
//   }