// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sima_portal/a_sima_app/Pazirade/list_memberCo.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:path/path.dart' as path;
import 'package:sima_portal/a_sima_app/sima_home1.dart';
import 'package:path_provider/path_provider.dart';


import 'package:sima_portal/a_sima_app/profile/wallet.dart';

class memberCoupload extends StatefulWidget {
  String id;
  String sanad;
  String name;
  String emza;
  List<AgentModel> _Agentdata = [];
  memberCoupload(this._Agentdata,this.sanad,this.id,this.name,this.emza);
  @override
  State<StatefulWidget> createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<memberCoupload> {
  String _key ="0";
  int Counter = 0;
  File ID_Card1 = File("") ;
  bool id_card1 = false;
  bool Sid_card1 = false;
  File ID_Card3 = File("") ;

  bool id_card3 = false;
  bool Sid_card3 = false;

  late String OK;

  bool uploading1 = false;bool sendBtn1 = false;bool resendBtn1 = false;bool selectBtn1 = true;
  bool uploading5 = false;bool sendBtn5 = false;bool resendBtn5 = false;bool selectBtn5 = true;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();

  void saveUpload() async {
    String response = await OnlineServices.sendUpload_memberCo(
        {"id": widget.id});
    if (response == "ok")
      _showDialog(context);

  }

  @override
  Widget build(BuildContext context) {
  //  print(widget.sanad);
    // TODO: implement build
    var size = MediaQuery
        .of(context)
        .size;
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffffad42)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("بارگذاری مدارک امضاکنندگان شرکت","", Icons.edit, (){})),

          body: ListView(children: [
            Container(
              height: size.height ,
              child: ListView(
                children: [
                 // SizedBox(height: 10,),
                  Icon(Icons.cloud_upload_outlined,size: 140,color: Colors.teal,),
                  Center(child: Text(widget.name,style: TextStyle(color: Colors.teal,fontSize: 25),),),
                  items("تصویر روی کارت ملی" , id_card1 , Sid_card1 , ID_Card1 , getImage1 , _upload1 , selectBtn1, sendBtn1 , resendBtn1 , uploading1),
                  items( "تصویر شناسنامه",  id_card3, Sid_card3 , ID_Card3 , getImage5 , _upload5, selectBtn5, sendBtn5 , resendBtn5 , uploading5),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10),
                    child: ElevatedButton(onPressed:
                    Counter == 2? (){
                      if (Counter == 2) saveUpload(); else _showDialog2(context);
                    } : null ,
                      child: Text("اتمام مراحل بارگذاری ",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w700),) , ),)
                ],
              ),
            ),


          ],),
        ));
  }

  Future<Null> _cropImage(File f , int tag) async {
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
          lockAspectRatio: false),);
    if (croppedFile != null) {
      f = croppedFile;
      if(tag == 1) ID_Card1 = croppedFile;
      else if(tag == 3) ID_Card3 = croppedFile;

      setState(() {});
    }
  }

  Widget items (String txt, bool idA , bool idB, File file , VoidCallback  get , dynamic up ,bool select,  bool send, bool resend , bool uping ){
    var size = MediaQuery.of(context).size;
    double fSize1 = 25;
    double fSize2 = 30;
    double fSize3 = 50;

    return Container(
        margin: EdgeInsets.only(right: 10 , left: 10, bottom: 8),
        decoration: BoxDecoration(
          color: Color(0xffffad42),
          borderRadius: BorderRadius.all(Radius.circular(8)),
          //border: Border.all(color: Color(0xffffffff))
        ),
        height: size.height * .22,
        width: size.width,
        child:
        Row(
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
                            height: size.height *.2, fit: BoxFit.cover),
                        idB == true
                            ? Container(height: size.height * .2, width: size.width ,color: Color (0x6649EC00),)
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
                        Text(
                          txt,
                        )
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
                    Visibility(visible: select ,child: ElevatedButton(onPressed:  get  ,child: Text(" انتخاب تصویر ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),) , )),
                    Visibility(visible: send ,child: ElevatedButton(onPressed: (){ up(); } ,child: Text("     ارسال    ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),) , )),
                    Visibility(visible: uping ,child: Container(child: SpinKitThreeBounce(color: Color(0xffffa625)),height: size.height * .1, width: size.height * .1,)),
                    Visibility(visible: resend ,child: ElevatedButton(onPressed: (){ up(); } ,child: Text("   ارسال مجدد   ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),) , )),
                    Visibility(visible: resend ,child: Text(" خطا در ارسال ") ),
                    Visibility(visible: idB ,child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x88ffffff))),onPressed: () {  },
                    child: Text( "${txt} با موفقیت بارگذاری شد ",style: TextStyle(color: Color(0xaa000000),fontSize: 18),textAlign: TextAlign.center,) , )),
                  ],
                )),

          ],
        ));
  }

  _upload1() async {
    uploading1 = true;sendBtn1 = false;resendBtn1 = false;selectBtn1 = false;setState(() {});
    String f = base64Encode(ID_Card1.readAsBytesSync());
    var response = await (OnlineServices()).sendForUploadCo({"id" : widget.id ,"name": "26.jpg",  "sanad": widget.sanad,  "files": f});
    if (response == "ok") { Counter++;
    uploading1 = false; Sid_card1 = true; sendBtn1 = false;
    } else {resendBtn1=true; sendBtn1 =false; uploading1 = false;}
    setState(() {}); }

  _upload5() async {
    uploading5 = true;sendBtn5 = false;resendBtn5 = false;selectBtn5 = false;setState(() {});
    String f = base64Encode(ID_Card3.readAsBytesSync());
    var response = await (OnlineServices()).sendForUploadCo({"id" : widget.id ,"name": "28.jpg", "sanad": widget.sanad,  "files": f,});
    if (response == "ok") {Counter++;
    uploading5 = false; Sid_card3 = true; sendBtn5 = false;
    } else {resendBtn5=true; sendBtn5 =false; uploading5 = false;}
    setState(() {}); }

  Future getImage1() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(100).toString());
    ID_Card1 = await File(pickedFile!.path).copy(Path);
    id_card1 = !id_card1;sendBtn1 = true;selectBtn1 = false;
    _cropImage(ID_Card1, 1);
    //  setState(() {});
  }

  Future getImage5() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(500).toString());
    ID_Card3 = await File(pickedFile!.path).copy(Path);
    id_card3 = !id_card3;sendBtn5 = true;selectBtn5 = false;
    _cropImage( ID_Card3, 3); }

  void _showDialog(BuildContext context) {
    _showLoading = false;
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
                            builder: (BuildContext context) =>
                                Directionality(
                                    textDirection: TextDirection.rtl,
                                    child: memberCo_page(widget._Agentdata,widget.sanad,widget.emza))));
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
    _showLoading = false;
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
                      child: Text('لطفا تصویر روی کارت ملی و صفحه اول شناسنامه را بارگذاری نمایید.'))
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

}