
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sima_portal/a_sima_app/list_riz.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/profile/wallet.dart';
import '../components/ScaleRoute.dart';
import '../components/Styles.dart';
import '../sarjam.dart';

class pasargadReport extends StatefulWidget {
  List<AgentModel> _AgentData = [];
  pasargadReport(this._AgentData);
  @override
  State<StatefulWidget> createState() => sampleState();

}

class sampleState extends State<pasargadReport> {

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    String code = widget._AgentData.last.userCode.contains("0") ? widget._AgentData.last.agentCode:widget._AgentData.last.userCode;

    // TODO: implement build
    double appBarHeight = AppBar().preferredSize.height;
    double radius = 5;

    return Scaffold(
      backgroundColor: Color(0x94DEE5E7),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("گزارش پاسارگاد","", Icons.edit, (){})),

      body:
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 10,),
            FittedBox(fit: BoxFit.fitHeight ,child: Container(

               height: size.height - appBarHeight,
              width: size.width ,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: Colors.white
              ),
              child: Column(
                children: [
                  items("گزارش ریز تراکنش ترمینال" , Icons.supervised_user_circle_outlined , list_riz_page(widget._AgentData)),
                  items("گزارش سرجمع تراکنش ترمینال" , Icons.monetization_on_outlined, sarjam_page(widget._AgentData)),
                ],
              ),
            )),

          ],
        ),
      ),


    );
  }

  Widget items(String title , IconData ic , Widget f) {
    var size = MediaQuery.of(context).size;
    Color icColor = Color(0xff484848);
    Color titleColor = Color(0xff484848);

    return ElevatedButton(onPressed: (){
      Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl,child: f,)));

    },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Color(0xffdadada)),
        ),
        child:Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: size.width * .13,
            child: Icon(ic,color: icColor,),),
          SizedBox(width: size.width * .63,
            child: Text(title , style: TextStyle(color: titleColor),),),
        ],
      ),));
  }

  Widget items2(String title , String ic , Widget f) {
    var size = MediaQuery.of(context).size;
    Color icColor = Color(0xff484848);
    Color titleColor = Color(0xff484848);
    double s = size.width * .07;

    return ElevatedButton(onPressed: (){
      Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl,child: f,)));

    },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            overlayColor: MaterialStateProperty.all(Color(0xffdadada)),
        ),
        child:Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          SizedBox(width: size.width * .13,
            child: Image.asset("assets/images/${ic}.png",color: Color(
                0xff6e6e6e),width: s,height: s),),
          SizedBox(width: size.width * .33,
            child: Text(title , style: TextStyle(color: titleColor),),),
        ],
      ),));
  }


  Future<String> getIMG() async {
    String response = await OnlineServices.getIMG(
        {"agentcode" : widget._AgentData.last.agentCode, "usercode" : widget._AgentData.last.userCode} );return response;}


}