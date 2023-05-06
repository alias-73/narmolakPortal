// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sima_portal/a_sima_app/profile/list_users.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/profile/pasargadReport.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/profile/support_center.dart';
import 'package:sima_portal/a_sima_app/profile/wallet.dart';
import '../models/infUserModel.dart';
import 'about.dart';
import 'bioAuth.dart';
import 'change_pass.dart';
import 'package:path/path.dart' as path;

import 'change_username.dart';
import '../components/ScaleRoute.dart';
import 'laws.dart';

//import
import 'dart:io' as io;

class profile_page extends StatefulWidget {
  List<AgentModel> _AgentData = [];

  profile_page(this._AgentData);

  @override
  State<StatefulWidget> createState() => sampleState();
}

class sampleState extends State<profile_page>
    with AutomaticKeepAliveClientMixin {
  List<UserInfModel> _data3 = [];

  bool uploading6 = false;
  bool sendBtn6 = false;
  bool resendBtn6 = false;
  bool selectBtn6 = true;
  io.File Maliyat = io.File("");

  bool maliyat = false;
  bool Smaliyat = false;


  Future<List<UserInfModel>> getName() async {
    Map response2;
    response2 = await OnlineServices.getName2({
      "agentcode": widget._AgentData.last.agentCode,
      "usercode": widget._AgentData.last.userCode
    });
    if (response2["data"] != "free") {
      _data3.addAll(response2['data']);
      setState(() {});
    }

    return _data3;
  }

  final ImagePicker _picker = ImagePicker();

  _upload6() async {
    uploading6 = true;
    sendBtn6 = false;
    resendBtn6 = false;
    selectBtn6 = false;
    setState(() {});
    String f = base64Encode(Maliyat.readAsBytesSync());
    var response = await (OnlineServices()).sendForUploadProfile({
      "name": widget._AgentData.last.agentCode +
          widget._AgentData.last.userCode +
          ".jpg",
      "agentcode": widget._AgentData.last.agentCode,
      "usercode": widget._AgentData.last.userCode,
      "files": f,
    });
    if (response == "ok") {
      Comp.showSnackOK(context, "تصویر پروفایل شما با موفقیت تغییر کرد");
      _deleteImageFromCache();
      uploading6 = false;
      Smaliyat = true;
      sendBtn6 = false;
    } else {
      resendBtn6 = true;
      sendBtn6 = false;
      uploading6 = false;
    }
    setState(() {});
  }

  Future getImage6() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir, Random().nextInt(700).toString());
    Maliyat = await io.File(pickedFile!.path).copy(Path);
    maliyat = !maliyat;
    sendBtn6 = true;
    selectBtn6 = false;
    _cropImage(Maliyat, 6);
  }

  @override
  void initState() {
    // print("+_______________+");
    _deleteImageFromCache();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    String code = widget._AgentData.last.userCode.contains("0")
        ? widget._AgentData.last.agentCode
        : widget._AgentData.last.userCode;

    // TODO: implement build
    double appBarHeight = AppBar().preferredSize.height;
    double radius = 5;

    return Scaffold(
        backgroundColor: Color(0x94DEE5E7),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              elevation: 10,
              expandedHeight: size.height * .3,
              floating: true,
              pinned: false,
              snap: true,
              stretch: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                stretchModes: [StretchMode.zoomBackground],
                //  title: Text('Running running'),
                background: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      "assets/images/profile_bc.jpg",
                      fit: BoxFit.cover,
                      height: size.height * .3,
                      width: size.width,
                    ),
                    Container(
                        height: size.height * .3,
                        width: size.width * .93,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: FutureBuilder<String>(
                                future: (getIMG()),
                                builder:
                                    (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return Stack(
                                      children: [
                                        ClipOval(
                                            child: Material(
                                                child: InkWell(
                                                    child: Smaliyat == true
                                                        ? Image.file(
                                                            Maliyat,
                                                            height: size.width *
                                                                .33,
                                                            width: size.width *
                                                                .33,
                                                          )
                                                        : SizedBox(
                                                            width: size.width * .33,
                                                            height: size.width * .33,
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: snapshot
                                                                  .data!
                                                                  .toString(),
                                                              // imageUrl: "https://pos.sima-pay.com//upload/Image/Agent/${widget._AgentData.last.agentCode}${widget._AgentData.last.userCode}.jpg",
                                                              placeholder: (context,
                                                                      url) =>
                                                                  Image.asset(
                                                                      "assets/images/person.png"),
                                                              errorWidget: (context, url, errorgetIMG) =>
                                                                  Image.asset(
                                                                      "assets/images/person.png"),
                                                            ))))),
                                        Positioned(
                                            bottom: 3,
                                            right: 3,
                                            child: GestureDetector(
                                              child: Container(
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.teal,
                                                    shape: BoxShape.circle),
                                              ),
                                              onTap: getImage6,
                                            ))
                                      ],
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else
                                    return Container();
                                },
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(top: 6),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: FutureBuilder<List<UserInfModel>>(
                                        future: getName(),
                                        builder: (context,
                                            AsyncSnapshot<List<UserInfModel>>
                                                snapshot) {
                                          if (snapshot.hasData) {
                                            return Text(
                                              snapshot.data!.first.name,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400),
                                            );
                                          } else if (snapshot.hasError) {
                                            return Container();
                                          } else
                                            return Container();
                                        },
                                      ),
                                    )),
                                Padding(
                                    padding: EdgeInsets.only(bottom: 10),
                                    child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Text(
                                          "کد نماینده: " + code,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Color(0xff505050),
                                              fontWeight: FontWeight.w500),
                                        ))),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              // height: size.height * .3,
                              width: size.width * .94,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  widget._AgentData.last.userCode == "0"
                                      ? items(
                                          "کاربران",
                                          Icons.supervised_user_circle_outlined,
                                          users_page(widget._AgentData))
                                      : Center(),
                                  items(
                                      "کیف پول",
                                      Icons.monetization_on_outlined,
                                      wallet_page(widget._AgentData)),
                                  items(
                                      "تغییر نام کاربری",
                                      Icons.accessibility_new_rounded,
                                      changeUsername(widget._AgentData)),
                                  items("تغییر رمز ورود", Icons.lock_open_sharp,
                                      changePass(widget._AgentData)),
                                  // items("احراز هویت بیومتریک", Icons.fingerprint, bioAuth()),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                            fit: BoxFit.fitHeight,
                            child: Container(
                              //height: size.height * .3,
                              width: size.width * .94,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(radius),
                                  color: Colors.white),
                              child: Column(
                                children: [
                                  items2("گزارشات پاسارگاد", "pasargad",
                                      pasargadReport(widget._AgentData)),
                                  items2("گزارشات ایران کیش", "irankish",
                                      users_page(widget._AgentData)),
                                  items2("گزارشات سداد", "sadad",
                                      users_page(widget._AgentData)),
                                  items2("گزارشات به پرداخت", "behpardakht",
                                      users_page(widget._AgentData)),
                                  items2("گزارشات پرداخت نوین", "novin",
                                      users_page(widget._AgentData)),
                                  items2("گزارشات سپهر", "sepehr",
                                      users_page(widget._AgentData)),
                                ],
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          //   height: size.height * .3,
                          width: size.width * .94,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(radius),
                              color: Colors.white),
                          child: Column(
                            children: [
                              items("مرکز پشتیبانی", Icons.support_agent_sharp,
                                  support_center(widget._AgentData)),
                              items("قوانین", Icons.safety_check, laws()),
                              items(
                                  "درباره ما", Icons.lock_open_sharp, about()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future _deleteImageFromCache() async {
    String url =
        "https://sima-pay.com//upload/Image/Agent/${widget._AgentData.last.agentCode}${widget._AgentData.last.userCode}.JPG";
    await CachedNetworkImage.evictFromCache(url);
  }

  Future<Null> _cropImage(io.File f, int tag) async {
    io.File? croppedFile = await ImageCropper().cropImage(
      sourcePath: f.path,
      cropStyle: CropStyle.circle,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'لطفا تصویر انتخابی را برش دهید',
          toolbarColor: Color(0xffffad42),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      f = croppedFile;
      Maliyat = croppedFile;
      setState(() {});
      _upload6();
    }
  }

  Widget items(String title, IconData ic, Widget f) {
    var size = MediaQuery.of(context).size;
    Color icColor = Color(0xff484848);
    Color titleColor = Color(0xff484848);

    return ElevatedButton(
        onPressed: () {
          title.contains("سداد")
              ? () {}
              : title.contains("پرداخت")
                  ? () {}
                  : title.contains("کیش")
                      ? () {}
                      : title.contains("شعب")
                          ? () {}
                        : title.contains("تغییر")
                          ? () {}

                          : Navigator.push(
                              context,
                              ScaleRoute(
                                  page: Directionality(
                                textDirection: TextDirection.rtl,
                                child: f,
                              )));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Color(0xffdadada)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: size.width * .13,
                child: Icon(
                  ic,
                  color: icColor,
                ),
              ),
              SizedBox(
                width: size.width * .33,
                child: Text(
                  title,
                  style: TextStyle(color: titleColor),
                ),
              ),
            ],
          ),
        ));
  }

  Widget items2(String title, String ic, Widget f) {
    var size = MediaQuery.of(context).size;
    Color icColor = Color(0xff484848);
    Color titleColor = Color(0xff484848);
    double s = size.width * .07;

    return ElevatedButton(
        onPressed: () {
          title.contains("سداد")
              ? () {}
              : title.contains("پرداخت")
                  ? () {}
                  : title.contains("کیش")
                      ? () {}
                      : title.contains("شعب")
                          ? () {}
                          : Navigator.push(
                              context,
                              ScaleRoute(
                                  page: Directionality(
                                textDirection: TextDirection.rtl,
                                child: f,
                              )));
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          overlayColor: MaterialStateProperty.all(Color(0xffdadada)),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              SizedBox(
                width: size.width * .13,
                child: Image.asset("assets/images/${ic}.png",
                    color: Color(0xff6e6e6e), width: s, height: s),
              ),
              SizedBox(
                width: size.width * .33,
                child: Text(
                  title,
                  style: TextStyle(color: titleColor),
                ),
              ),
            ],
          ),
        ));
  }

  Future<String> getIMG() async {
    _deleteImageFromCache();
    String response = await OnlineServices.getIMG({
      "agentcode": widget._AgentData.last.agentCode,
      "usercode": widget._AgentData.last.userCode
    });
    setState(() {});
    // print(response);
    return response;
  }

  @override
  bool get wantKeepAlive => true;
}
