import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/pazirade/EditedStore_page.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/imgAddressModel.dart';
import 'package:sima_portal/a_sima_app/senfReq/list_senf_req.dart';
import 'package:sima_portal/a_sima_app/senfReq/new_senfReq.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/taqalob/list_taqalob.dart';
import 'package:sima_portal/a_sima_app/upload.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Hesab/list_hesab.dart';
import 'Moaref/list_moaref.dart';
import 'Pazirade/list_pazirande.dart';
import 'Takhsis/list_takhsis.dart';
import 'Terminal/list_terminal.dart';
import 'components/ScaleRoute.dart';
import 'device/list_device.dart';
import 'EM/em_cartableI.dart';
import 'EM/em_cartableP.dart';
import 'editInfo/list_edited.dart';
import 'estelam_senf.dart';
import 'jaygozini/list_jaygozini.dart';
import 'list_imei.dart';
import 'models/accessssssModel.dart';
import 'new_imei_check.dart';

class apps extends StatefulWidget {
  List<AgentModel> _data = [];
  List<AccessModel1> _data2 = [];

  apps(this._data,this._data2);

  @override
  State<StatefulWidget> createState() => register_pos_pageState();
}

class register_pos_pageState extends State<apps>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<ImgAddressModel> _data = [];
  late Map response;
  int _current = 0;
  final CarouselController _controller = CarouselController();
  late final List<String> imgList = [];

  void _getData() async {
    response = await OnlineServices.getSliderList(widget._data.last.agentCode);
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      for (int i = 0; i < _data.length; i++)
        imgList.add(_data[i].img + "," + _data[i].url);
      setState(() {});
    } else
      null;
  }



  // final Uri _url = Uri.parse('https://flutter.dev');
  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch ';
    }
  }

  void getAccess(String section , Widget w) async {
    String response = "_";
    // print(widget._data2[4].vaziat);

      try {
        section == "pazirande" ? response = widget._data2[0].vaziat :
        section == "moaref" ? response = widget._data2[1].vaziat :
        section == "hesab" ? response = widget._data2[2].vaziat :
        section == "upload" ? response = widget._data2[3].vaziat :
        section == "device" ? response = widget._data2[4].vaziat :
        section == "takhsis" ? response = widget._data2[5].vaziat :
        section == "jaygozini" ? response = widget._data2[6].vaziat :
        section == "em" ? response = widget._data2[7].vaziat :
        section == "terminal" ? response = widget._data2[8].vaziat :
        section == "foroshgah" ? response = widget._data2[9].vaziat :
        section == "hoviati" ? response = widget._data2[10].vaziat :
        section == "apps" ? response = widget._data2[11].vaziat :
        section == "payaneReq" ? response = widget._data2[12].vaziat : null;
      } on Exception catch (exception) {
    } catch (error) {
    }

      if(response == "_" && section != "taqalob" && section != "register" && section != "estelam_senf"){
        CoolAlert.show(
            context: context,
            type: CoolAlertType.error,
            confirmBtnText: "بستن",
            onConfirmBtnTap: (){
              Navigator.pop(context);
            },
            title: "",
            backgroundColor: Colors.white,
            text: "مجوز دسترسی به این بخش برای شما غیرفعال است. لطفا با پشتیبان برنامه تماس بگیرید"
        );
      }
      else {
        section == "em" ? _showEmMenu():
        Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl, child: w,)));
      }

  }

  bool loading = false;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    Color bcTextColor = Color(0x22000000);
    Color cl = Color(0xff000000);
    final List<Widget> imageSliders = imgList
        .map((item) => Container(
              child: Container(
                margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    child: Stack(
                      children: <Widget>[
                        //GestureDetector(onTap: (){ print(item.split(",")[1]);  _url = Uri.parse(item.split(",")[1]); openLink();  }    ,child:
                        GestureDetector(
                            onTap: () {
                              _launchUrl(item.split(",")[1]);
                            },
                            child: Image.network(item.split(",")[0],
                                fit: BoxFit.cover, width: 1000.0)),
                      ],
                    )),
              ),
            ))
        .toList();

    ///0385957531
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        resizeToAvoidBottomInset: true,
        body: Column(
          children: [
            SizedBox(
              height: (size.height * .32),
              width: size.width,
              child: Column(children: [
                Expanded(
                  child: CarouselSlider(
                    items: imageSliders,
                    carouselController: _controller,
                    options: CarouselOptions(
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 2.0,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                (Theme.of(context).brightness == Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        _current == entry.key ? 0.9 : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
              ]),
            ),
            // SizedBox(child:             Padding(padding: EdgeInsets.only(right: size.width * .05),child: Align(child: Text(
            //   "عملیات",textAlign: TextAlign.right,
            //   style: TextStyle(fontSize: 25, color: Colors.black,fontWeight: FontWeight.w800),
            // ),alignment: Alignment.centerRight,),),height: 30,),
            SizedBox(
              height: 7,
            ),

            SizedBox(
              height: (size.height * .68) -
                  56 -
                  appBarHeight -
                  statusBarHeight -
                  47,
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: AnimationConfiguration.toStaggeredList(
                        duration: const Duration(milliseconds: 575),
                        childAnimationBuilder: (widget) => SlideAnimation(
                          verticalOffset:
                              MediaQuery.of(context).size.width / 2,
                          child: FadeInAnimation(child: widget),
                        ),
                        children: [

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              items3(
                                  BuildContext,
                                  "پذیرنده",
                                  "assets/images/pazirande.png",
                                  Color(0xff9c1208),
                                  poses_list_page(widget._data) ,"pazirande"),
                              items3(
                                  BuildContext,
                                  "معرف",
                                  "assets/images/moaref.png",
                                  Color(0xfffc9117),
                                  list_moaref_page(widget._data) ,"moaref"),
                              items3(
                                  BuildContext,
                                  "حساب",
                                  "assets/images/hesab.png",
                                  Color(0xff7a0982),
                                  sheba_registered_page(widget._data) ,"hesab"),
                              items3(
                                  BuildContext,
                                  "مدارک",
                                  "assets/images/upload.png",
                                  Color(0xff06a801),
                                  upload_doc(widget._data) ,"upload"),

                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              items3(
                                  BuildContext,
                                  "دستگاه",
                                  "assets/images/device.png",
                                  Color(0xff595759),
                                  device_list(widget._data) ,"device"),
                              items3(
                                  BuildContext,
                                  "تخصیص",
                                  "assets/images/takhsis.png",
                                  Color(0xff0453d1),
                                  pos_registered3_page(widget._data) ,"takhsis"),
                              items3(
                                  BuildContext,
                                  "جایگزینی",
                                  "assets/images/replace.png",
                                  Color(0xff04b6d1),
                                  list_jaygozini_page(widget._data) ,"jaygozini"),
                              items3(
                                  BuildContext,
                                  "کارتابل EM",
                                  "assets/images/support.png",
                                  Color(0xffe60b0b),
                                  em_cartableP_page(widget._data) ,"em"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [

                              items4(
                                BuildContext,
                                "ترمینال ها",
                                "assets/images/Terminal.png",
                                Color(0xff5f5f00),
                                ter(widget._data) ,"terminal",
                              ),
                              items4(
                                  BuildContext,
                                  "ویرایش فروشگاه",
                                  "assets/images/shop.png",
                                  Color(0xff04b6d1),
                                  editedStore_page(widget._data) ,"foroshgah"),
                              items4(
                                  BuildContext,
                                  "ویرایش هویتی",
                                  "assets/images/eslah.png",
                                  Color(0xffe60b0b),
                                  list_edited_page(widget._data) ,"hoviati"),
                              items4(
                                  BuildContext,
                                  "درخواست ترمینال",
                                  "assets/images/reqterminal.png",
                                  Color(0xfffc9117),
                                  listReqTerminal(widget._data) ,"payaneReq"),
                            ],
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              items4(
                                  BuildContext,
                                  "رجیستری",
                                  "assets/images/register.png",
                                  Color(0xff04b6d1),
                                  listIMEI(widget._data) ,"register"),
                              items4(
                                  BuildContext,
                                  "استعلام صنف",
                                  "assets/images/estelam.png",
                                  Color(0xff04b6d1),
                                  estelam_senf() ,"estelam_senf"),
                              items4(
                                  BuildContext,
                                  "کشف تقلب",
                                  "assets/images/taqalob.png",
                                  Color(0xff04b6d1),
                                  list_taqalob_page(widget._data) ,"taqalob"),
                              items5(
                                  BuildContext,
                                  "اپ دستگاه ها",
                                  "assets/images/download.png",
                                  Color(0xffe60b0b) ,"apps"),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),



                        ],
                      ))),
            )
          ],
        ));
  }

  Widget items3(BuildContext, String title, String ic, Color c, Widget w , String section_name) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 17;
    double icSize = size.width * 0.1;
    double icSize2 = size.width * 0.2;
    Color icColor = Color(0xff676767);
    double hItem = (size.height - statusBarHeight) * .11;
    double wItem = size.width * 0.24;

    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        //  alignment: Alignment.center,
        height: hItem,
        width: wItem,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Color(0xff504f4f), width: 1.9)
            //color: bcItemColor1,
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: hItem * .5,

              width: size.width * .5 * .6,

              margin: EdgeInsets.only(right: 8),

              // alignment: Alignment.center,
              child: ic == "assets/images/takhsis.png"
                  ? Image.asset(
                      color: icColor,
                      ic,
                      height: icSize2,
                      width: icSize2,
                    )
                  : ic == "assets/images/replace.png"
                      ? Image.asset(
                          color: icColor,
                          ic,
                          height: icSize2,
                          width: icSize2,
                        )
                      : Image.asset(
                          color: icColor,
                          ic,
                          height: icSize,
                          width: icSize,
                        ),
            ),
            // دستگاه پذیرنده تخصیص جایگزینی ای ام
            Text(
              title,
              style: TextStyle(fontSize: fontSize, color: Colors.black),
            ),
            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
          getAccess(section_name , w);
        setState(() {});
      },
    );
  }

  Widget items4(BuildContext, String title, String ic, Color c, Widget w , String section_name) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 17;
    double icSize = size.width * 0.1;
    double icSize2 = size.width * 0.2;
    Color icColor = Color(0xff676767);
    double hItem = (size.height - statusBarHeight) * .11;
    double wItem = size.width * 0.24;
    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        //  alignment: Alignment.center,
        height: hItem,
        width: wItem,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Color(0xff504f4f), width: 1.9)
            //color: bcItemColor1,
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: hItem * .33,

              width: size.width * .5 * .5,

              margin: EdgeInsets.only(right: 8),

              // alignment: Alignment.center,
              child: ic == "assets/images/takhsis.png"
                  ? Image.asset(
                      color: icColor,
                      ic,
                      height: icSize2,
                      width: icSize2,
                    )
                  : ic == "assets/images/replace.png"
                      ? Image.asset(
                          color: icColor,
                          ic,
                          height: icSize2,
                          width: icSize2,
                        )
                      : Image.asset(
                          color: ic.contains("registerss") ? Colors.red : icColor,
                          ic,
                          height: icSize,
                          width: icSize,
                        ),
            ),
            // دستگاه پذیرنده تخصیص جایگزینی ای ام
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize - 4, color: Colors.black),
            ),
            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
        getAccess(section_name, w);

        // Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: w)));
      },
    );
  }

  Widget items5(BuildContext, String title, String ic, Color c , String section_name) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 17;
    double icSize = size.width * 0.39;
    double icSize2 = size.width * 0.2;
    Color icColor = Color(0xff676767);
    double hItem = (size.height - statusBarHeight) * .11;
    double wItem = size.width * 0.24;
    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        //  alignment: Alignment.center,
        height: hItem,
        width: wItem,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            border: Border.all(color: Color(0xff504f4f), width: 1.9)
            //color: bcItemColor1,
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: hItem * .33,
              width: size.width * .5 * .5,
              margin: EdgeInsets.only(right: 8),
              child: Image.asset(
                color: icColor,
                ic,
                height: icSize,
                width: icSize,
              ),
            ),
            // دستگاه پذیرنده تخصیص جایگزینی ای ام
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: fontSize - 4, color: Colors.black),
            ),
            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
        getAccess(section_name, Center());
      },
    );
  }

  Widget items2(BuildContext, String title, String ic, Color c, Widget w , String section_name) {
    c = Color(0xffbebebe);
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 20;
    double icSize = size.width * .5 * .15;

    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 9),
        //  alignment: Alignment.center,
        height: (size.height - statusBarHeight) * .1,
        width: size.width * 0.9,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xffd5d5d5),
              Color(0xe0b7b7b7),
            ],
          ),
          borderRadius: BorderRadius.circular(9),
          // color: bcItemColor1,
          //   borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  width: size.width * .5 * .25,
                  margin: EdgeInsets.only(left: 8, right: 8),
                  color: Colors.transparent,
                  // alignment: Alignment.center,
                  child: Image.asset(
                    color: Colors.black,
                    ic,
                    height: icSize,
                    width: icSize,
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                ),
              ],
            ),

            Container(
                alignment: Alignment.center,
                width: size.width * .5 * .2,
                margin: EdgeInsets.only(left: 8, right: 8),
                color: Colors.transparent,
                // alignment: Alignment.center,
                child: Text(
                  "10",
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                )),

            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
         getAccess(section_name , w);

        setState(() {});
      },
    );
  }

  Widget items1(BuildContext, String title, String ic, Color c, Widget w , String section_name) {
    c = Color(0xffbebebe);
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    double fontSize = 20;
    double icSize = size.width * 0.15;
    double icSize2 = size.width * 0.25;

    Color bcItemColor1 = c;
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(bottom: 9),
        //  alignment: Alignment.center,
        height: (size.height - statusBarHeight) * .1,
        width: size.width * 0.9,
        // padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
          color: bcItemColor1,
          //   borderRadius: BorderRadius.circular(20)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Container(
                  alignment: Alignment.center,

                  width: size.width * .5 * .25,

                  margin: EdgeInsets.only(left: 8, right: 8),
                  color: c,
                  // alignment: Alignment.center,
                  child: ic == "assets/images/takhsis.png"
                      ? Image.asset(
                          color: Colors.black,
                          ic,
                          height: icSize2,
                          width: icSize2,
                        )
                      : ic == "assets/images/replace.png"
                          ? Image.asset(
                              color: Colors.black,
                              ic,
                              height: size.width * .75,
                              width: size.width * .75)
                          : Image.asset(
                              color: Colors.black,
                              ic,
                              height: icSize,
                              width: icSize,
                            ),
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                ),
              ],
            ),

            Container(
                alignment: Alignment.center,
                width: size.width * .5 * .2,
                margin: EdgeInsets.only(left: 8, right: 8),
                color: c,
                // alignment: Alignment.center,
                child: Text(
                  "10",
                  style: TextStyle(fontSize: fontSize, color: Colors.black),
                )),

            //Divider(height: 3, color: Colors.black,),
          ],
        ),
      ),
      onTap: () {
        // Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child: w)));
        getAccess(section_name , w);
        // Navigator.push(context, ScaleRoute(page: Directionality(textDirection: TextDirection.rtl, child: w,)));

        setState(() {});
      },
    );
  }

  void _showEmMenu() {
    var size = MediaQuery.of(context).size;
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Color(0x69bcdeff),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Color(0xffffffff)),
                        width: size.width * .75,
                        height: size.height * .4,
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            const Text(
                              "ایران کیش",
                              style: TextStyle(
                                  fontWeight: FontWeight.w800, fontSize: 19),
                            ),
                            Image.asset("assets/images/irankish.png"),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            ScaleRoute(
                                page: Directionality(
                              textDirection: TextDirection.rtl,
                              child: em_cartableI_page(widget._data),
                            )));
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Color(0xffffffff)),
                          width: size.width * .75,
                          height: size.height * .4,
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              const Text(
                                "پاسارگاد",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800, fontSize: 19),
                              ),
                              Image.asset("assets/images/pasargad.png"),
                            ],
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              ScaleRoute(
                                  page: Directionality(
                                textDirection: TextDirection.rtl,
                                child: em_cartableP_page(widget._data),
                              )));
                        }),
                  ],
                ),
              ));
        });
  }
}
