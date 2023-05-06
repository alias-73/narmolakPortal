// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persian_date/persian_date.dart';

import 'package:sima_portal/a_sima_app/Takhsis/list_takhsis.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class iranKishupload extends StatefulWidget {
  String sanad;
  int index;
  String name;

  List<AgentModel> _Agentdata = [];
  iranKishupload(this._Agentdata,this.sanad, this.name, this.index);

  @override
  State<StatefulWidget> createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<iranKishupload> {
  String _key = "0";
  int Counter = 0;
 late File ID_Card1;
  bool id_card1 = false;
  bool Sid_card1 = false;
  late String today = "";
  late String datetime = "";

 late String OK;

  bool uploading1 = false;
  bool sendBtn1 = false;
  bool resendBtn1 = false;
  bool selectBtn1 = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final ImagePicker _picker = ImagePicker();

  void saveUpload() async {

    PersianDate persianDate = PersianDate();String today = persianDate.getDate.toString().substring(0, persianDate.getDate.toString().length - 13).replaceAll("-", "/");String h = DateTime.now().hour.toString();if (h.length == 1) h= "0" + h;String m = DateTime.now().minute.toString(); if (m.length == 1) m = "0" + m;String datetime =h + ":" + m;

    String response =
        await OnlineServices.sendUpload_IranKish({"sanad": widget.sanad,"tarikh" : today.toString() , "saat" : datetime.toString() ,"agentcode": widget._Agentdata.last.agentCode, "usercode": widget._Agentdata.last.userCode ,"name" : widget.name  });
    if (response == "ok") _showDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    String text1 = "لطفا قبل از آپلود فرم نصب موارد ذیل به دقت مطالعه شوند";
    String text2 =
        "پرفراژ تراکنش 60 ریالی (وجود نام فروشگاه در پرفراژ الزامی می باشد) \nموارد با رنگ قرمز در فرم نصب مطابق با پرونده ثبتی تکمیل گردد\nامضا پذیرنده با فرم استهشاد و فرم قرارداد یکسان باشد\nفرم نصب حتما باید آخرین نسخه ارائه شده باشد (26 ماده) \nدر محل امضا پذیرنده نام و نام خانوادگی پذیرنده حتما قید گردد\nدر صورتی که پذیرنده حقوقی باشد، نام و امضای صاحب حق امضا و مهر شرکت برای الزامی می باشد";
    Color cl = Colors.black;
    //  print(widget.sanad);
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffffad42)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          //appBar:
   //           Comp.app_bar("بارگذاری فرم نصب ایران کیش", "", Icons.edit, () {}),
          body: ListView(
            children: [
              Container(
                height: size.height,
                child: ListView(
                  children: [
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        text1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 15),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: Colors.black, width: 2.5)),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      margin: EdgeInsets.symmetric(horizontal: 6),
                      child: Column(
                        children: [
                          Text(
                            text2,
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.blue)),
                              onPressed: () {
                                _showDialog3(context);
                              },
                              child: Text("مشاهده تصویر راهنما",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500)),
                            ),
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                          border: Border.all(color: Colors.black, width: 2.5)),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    items(
                        "تصویر فرم نصب ایران کیش",
                        id_card1,
                        Sid_card1,
                        ID_Card1,
                        getImage1,
                        _upload1,
                        selectBtn1,
                        sendBtn1,
                        resendBtn1,
                        uploading1),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: ElevatedButton(
                        onPressed: Counter == 1
                            ? () {
                                if (Counter == 1)
                                  saveUpload();
                                else
                                  _showDialog2(context);
                              }
                            : null,
                        child: Text(
                          "اتمام مراحل بارگذاری ",
                          style: TextStyle(
                              fontSize: 23, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Future<Null> _cropImage(File f, int tag) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: f.path,
      aspectRatioPresets: Platform.isAndroid
          ? [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ]
          : [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio5x3,
              CropAspectRatioPreset.ratio5x4,
              CropAspectRatioPreset.ratio7x5,
              CropAspectRatioPreset.ratio16x9
            ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'لطفا تصویر انتخابی را برش دهید',
          toolbarColor: Color(0xffffad42),
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
    );
    if (croppedFile != null) {
      f = croppedFile;
      if (tag == 1) ID_Card1 = croppedFile;

      setState(() {});
    }
  }

  Widget items(String txt, bool idA, bool idB, File file, VoidCallback  get,
      dynamic up, bool select, bool send, bool resend, bool uping) {
    var size = MediaQuery.of(context).size;
    double fSize1 = 25;
    double fSize2 = 30;
    double fSize3 = 50;

    return Container(
        margin: EdgeInsets.only(right: 10, left: 10, bottom: 8),
        decoration: BoxDecoration(
          color: Color(0xffffad42),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          //border: Border.all(color: Color(0xffffffff))
        ),
        height: size.height * .18,
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                alignment: Alignment.center,
                width: size.width * .5,
                //height: size.height * 0.2,
                child: Stack(
                  children: [
                    idA == true
                        ? Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(file,
                                  height: size.height * .16, fit: BoxFit.cover),
                              idB == true
                                  ? Container(
                                      height: size.height * .16,
                                      width: size.width,
                                      color: Color(0x6649EC00),
                                    )
                                  : SizedBox()
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add_photo_alternate_outlined,
                                size: fSize3,
                                color: Color(0xddffffff),
                              ),
                              Text(txt)
                            ],
                          ),
                  ],
                )),
            Container(
                alignment: Alignment.center,
                width: size.width * .4,
                height: size.height * 0.2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: select,
                        child: ElevatedButton(
                          onPressed: get,
                          child: Text(
                            " انتخاب تصویر ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        )),
                    Visibility(
                        visible: send,
                        child: ElevatedButton(
                          onPressed: () {
                            up();
                          },
                          child: Text(
                            "     ارسال    ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        )),
                    Visibility(
                        visible: uping,
                        child: Container(
                          child: SpinKitThreeBounce(color: Color(0xffffa625)),
                          height: size.height * .1,
                          width: size.height * .1,
                        )),
                    Visibility(
                        visible: resend,
                        child: ElevatedButton(
                          onPressed: () {
                            up();
                          },
                          child: Text(
                            "   ارسال مجدد   ",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w300),
                          ),
                        )),
                    Visibility(visible: resend, child: Text(" خطا در ارسال ")),
                    Visibility(
                        visible: idB,
                        child: ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0x88ffffff))),
                          onPressed: () {  },
                          child: Text(
                            "${txt} با موفقیت بارگذاری شد ",
                            style: TextStyle(
                                color: Color(0xdd000000), fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        )),
                  ],
                )),
          ],
        ));
  }

  _upload1() async {
    uploading1 = true;
    sendBtn1 = false;
    resendBtn1 = false;
    selectBtn1 = false;
    setState(() {});
    String f = base64Encode(ID_Card1.readAsBytesSync());
    var response = await (OnlineServices()).sendForUploadIranKish(
        {"name": "9004.jpg", "sanad": widget.sanad, "files": f});
    if (response == "ok") {
      Counter++;
      uploading1 = false;
      Sid_card1 = true;
      sendBtn1 = false;
    } else {
      resendBtn1 = true;
      sendBtn1 = false;
      uploading1 = false;
    }
    setState(() {});
  }

  Future getImage1() async {
    final pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir, Random().nextInt(100).toString());
    ID_Card1 = await File(pickedFile!.path).copy(Path);
    id_card1 = !id_card1;
    sendBtn1 = true;
    selectBtn1 = false;
    _cropImage(ID_Card1, 1);
  }

  void _showDialog(BuildContext context) {
    setState(() {});
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('مدارک با موفقیت ذخیره شد'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Directionality(
                                textDirection: TextDirection.rtl,
                                child:
                                    pos_registered3_page(widget._Agentdata))));
                  },
                  child: Container(
                      // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      )))
            ],
          ),
        );
      },
    );
  }

  void _showDialog2(BuildContext context) {
    setState(() {});
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                          'لطفا تصویر فرم نصب ایران کیش را بارگذاری نمایید.'))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      // margin: EdgeInsets.only(top: 0),
                      padding: EdgeInsets.only(top: 4, bottom: 4),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        border: Border.all(
                          width: 1,
                          color: Color(0xff000000),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        //  border: Border(color: Colors.black, width: 1.0),
                      ),
                      //  color: Colors.lightBlueAccent,
                      width: size.width * .3,
                      child: Text(
                        "تایید",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      )))
            ],
          ),
        );
      },
    );
  }

  void _showDialog3(BuildContext context) {
    setState(() {});
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.zero,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: Container(
              padding: EdgeInsets.zero,

              //  height: size.height,
              width: size.width,
              child: CachedNetworkImage(
                imageUrl: "https://sima-pay.com/upload/nasbir/sample.jpg",
                placeholder: (context, url) =>
                    Image.asset("assets/images/Logo_Sima_Cart.gif"),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/Logo_Sima_Cart.gif"),
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.teal)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "       تایید        ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  ))
            ],
          ),
        );
      },
    );
  }
}
