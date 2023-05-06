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
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'models/pazirandeModel2.dart';

class upload_doc extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  upload_doc(this._Agentdata);
  @override
  State<StatefulWidget> createState() => ImagePickerScreenState();
}

class ImagePickerScreenState extends State<upload_doc> {
  String _pazirande_Value = "پذیرنده";
  List<String> _pazirandeValue = [];
  String _key = "0";
  bool isAllow2 = false;

  int Counter = 0;
  late TextEditingController _controller1 = TextEditingController(text: "پذیرنده");
  bool isallow = false;
  File ID_Card1 = File("") ;

  bool id_card1 = false;
  bool Sid_card1 = false;
  late File ID_Card2 = File("") ;

  bool id_card2 = false;
  bool Sid_card2 = false;
  File ID_Card3 = File("") ;

  bool id_card3 = false;
  bool Sid_card3 = false;
  late File Ejare = File("") ;

  bool ejare = false;
  bool Sejare = false;

  late File Javaz = File("") ;
  bool javaz = false;
  bool Sjavaz = false;

  File Esteshhad = File("") ;
  bool esteshhad = false;
  bool Sesteshhad = false;

  File Maliyat = File("") ;
  bool maliyat = false;
  bool Smaliyat = false;

  late File Sheba = File("") ;

  bool sheba = false;
  bool Ssheba = false;

  late String OK;
  late String PSP = "";
  late String SENF = "";
  late String Type = "حقیقی";

  bool uploading1 = false;bool sendBtn1 = false;bool resendBtn1 = false;bool selectBtn1 = true;
  bool uploading2 = false;bool sendBtn2 = false;bool resendBtn2 = false;bool selectBtn2 = true;
  bool uploading4 = false;bool sendBtn4 = false;bool resendBtn4 = false;bool selectBtn4 = true;
  bool uploading5 = false;bool sendBtn5 = false;bool resendBtn5 = false;bool selectBtn5 = true;
  bool uploading6 = false;bool sendBtn6 = false;bool resendBtn6 = false;bool selectBtn6 = true;
  bool uploading3 = false;bool sendBtn3 = false;bool resendBtn3 = false;bool selectBtn3 = true;
  bool uploading7 = false;bool sendBtn7 = false;bool resendBtn7 = false;bool selectBtn7 = true;
  bool uploading9 = false;bool sendBtn9 = false;bool resendBtn9 = false;bool selectBtn9 = true;

  late String A = "تصویر روی کارت ملی";
  late String B = "تصویر پشت کارت ملی";
  late String C = "تصویر شناسنامه";

  List<PazirandeModel2> _data3 = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _showLoading = false;
  final ImagePicker _picker = ImagePicker();
  void saveUpload() async {
    if (_key.length > 2) {
      String response = await OnlineServices.sendUpload(
          {"sanad": _key
              .split("-")
              .first}
      );
      if (response == "ok")
        {
          _showLoading = false;
          setState(() {});
          CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          confirmBtnText: "بستن",
          onConfirmBtnTap: (){
            Navigator.pop(context);
            Navigator.pop(context);
          },
          title: "",
          backgroundColor: Colors.white,
          text: "مدارک با موفقیت ذخیره شد"
        );
        }
    } else
      Comp.showSnack(context,Icons.adjust,"لطفا پذیرنده را انتخاب نمایید");

  }
  void getPazirandeList() async {
   // await OnlineServices.check(2) == "222" ?
    //isallow = true : isallow = false;
    isallow = true ;
    //print(isallow);
    Map response = await OnlineServices.getPazirandeList5(
        {"agentcode" : widget._Agentdata.last.agentCode ,"usercode" : widget._Agentdata.last.userCode}
    );
    _data3.clear();
    _data3.addAll(response['data']);

    for (int i = 0 ; i< _data3.length ; i++)
    {
      _pazirandeValue.add(_data3[i].pazirande);
    }
    isallow == false ? _pazirandeValue.clear() : null;

    setState(() {});
  }

  void  _getPSP(String sanad) async {
    String response = await OnlineServices.getPSP2(
        {
          "sanad": sanad,
        });
    PSP = response;
    setState(() {});
  }

  void checkSenf(String split) async {
    String response = await (OnlineServices()).checkSenf(
        {  "code" : split });
    if(response == "yes")
    {
      isAllow2=true;
    }    if(response == "no")
    {
      isAllow2=false;
    }
    setState(() {});
    print(response);
  }

  void  _getSenf(String sanad) async {
    String response = await OnlineServices.getSenf(
        {
          "sanad": sanad,
        });
    SENF = response;
    checkSenf(SENF.split("-")[0]);
    print(SENF);

    // setState(() {});
  }

  void  _getType(String sanad) async {
    String response = await OnlineServices.getType(
        {
          "sanad": sanad,
        });
    Type = response;
    if (Type == "حقوقی")
    {
      A = "صویر صفحه اول اساسنامه";
      B = "تصویر آگهی ثبت";
      C = "تصویر آخرین تغییرات";
    }
    setState(() {});
  }

  @override
  void initState() {
    getPazirandeList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    var size = MediaQuery.of(context).size;

    Color cl = Colors.black  ;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Color(0xffffad42)));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: SafeArea(child: Scaffold(
            key: _scaffoldKey,
            body: SingleChildScrollView(child:
            Column(children: [
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      controller: _controller1,
                      enabled: false,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,

                        prefixIcon:
                        PSP.contains("پرداخت نوین") ? Padding(child:Image.asset("assets/images/novin.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) :
                        PSP.contains("پاسارگاد") ? Padding(child:Image.asset("assets/images/pasargad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) :
                        PSP.contains("پرداخت") ? Padding(child:Image.asset("assets/images/behpardakht.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),): PSP.contains("سداد") ? Padding(child:Image.asset("assets/images/sadad.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),)  : PSP.contains("ایران") ?  Padding(child:Image.asset("assets/images/irankish.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) : PSP.contains("سپهر") ?  Padding(child:Image.asset("assets/images/sepehr.png",height: 60,width: 60,), padding: EdgeInsets.only(right: 15),) : Icon(Icons.person,color: cl,),
                        labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: cl)),
                        labelText: "پذیرنده",
                        disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: cl)),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 35, left: 35, bottom: 6),
                      width: size.width,
                      padding: EdgeInsets.only(right: 60,left: 20),
                      child: DropdownButton<String>(
                          isExpanded: true,
                          underline: Container(),
                          items:_pazirandeValue.map((String val) {return DropdownMenuItem<String>(value: val, child: Text(val),);}).toList(),
                          onChanged: (newVal) {
                            // print(value);
                            newVal == null ? null : _key = newVal;
                            //print(value.split("-").first);
                            _pazirande_Value = newVal!;
                            _getPSP(newVal.split("-")[0]);
                            _getType(newVal.split("-")[0]);
                            _getSenf(newVal.split("-")[0]);
                            // print(newVal.split("-")[0]);
                            _controller1 = TextEditingController(text: _pazirande_Value);

                            setState(() {});
                          }))
                ],
              ),
              SizedBox(height: 6,),
              Stack(children: [
                Container(
                  //height: size.height + size.height*.25 ,

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(

                        children: [
                                            items( A ,               id_card1 , Sid_card1 , ID_Card1 , getImage1 , getImage11 , _upload1 , selectBtn1, sendBtn1 , resendBtn1 , uploading1),
                                            items( C,                id_card3, Sid_card3 , ID_Card3 , getImage5 ,getImage55 , _upload5, selectBtn5, sendBtn5 , resendBtn5 , uploading5) ,
                          Type == "حقیقی" && isAllow2 == false ? items( "تصویر استشهادیه", esteshhad , Sesteshhad  , Esteshhad , getImage3 ,getImage33 , _upload3, selectBtn3, sendBtn3 , resendBtn3 , uploading3): Center(),
                          Type == "حقیقی" ? items(  "تصویر قرارداد اجاره",  ejare,  Sejare,  Ejare, getImage9 ,getImage99 , _upload9, selectBtn9, sendBtn9 , resendBtn9 , uploading9): Center(),

                        ],
                      )   ,
                      Column(
                        children: [
                          items( B , id_card2 , Sid_card2 , ID_Card2 , getImage2 , getImage22 , _upload2, selectBtn2, sendBtn2 , resendBtn2 , uploading2),
                          items( "تصویر تاییدیه شبا" , sheba    , Ssheba    ,  Sheba   , getImage7 , getImage77 , _upload7, selectBtn7, sendBtn7 , resendBtn7 , uploading7),
                          Type == "حقیقی" ? items( "تصویر جواز کسب", javaz , Sjavaz , Javaz , getImage4 ,getImage44 , _upload4, selectBtn4, sendBtn4 , resendBtn4 , uploading4) : Center(),
                          Type == "حقیقی" ? items( "تصویر مالیاتی" , maliyat    , Smaliyat    ,  Maliyat   , getImage6 , getImage66 , _upload6, selectBtn6, sendBtn6 , resendBtn6 , uploading6) : Center(),

                        ],
                      )
                    ],
                  ),),
                _key.length < 2 ? Container(
                  alignment: Alignment.topCenter,
                  width: size.width,
                  child: Column(
                    children: [
                      Icon(Icons.arrow_upward,size: 100,),
                      Padding(padding: EdgeInsets.symmetric(vertical: 15,horizontal: 10),child: Text("لطفا ابتدا پذیرنده را انتخاب کنید",textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w700),))
                    ],
                  ),
                  height: size.height ,
                  color: Color(0xb8ffffff),
                ) : Container(),
              ]),
              Container(width: size.width* .9,child:
              ElevatedButton(onPressed:
              _key.length > 1? (){
                if (Counter == 4) saveUpload(); else CoolAlert.show(
                  context: context,
                  confirmBtnText: "باشه",
                  type: CoolAlertType.warning,
                  title: "",
                  backgroundColor: Colors.white,
                  text: Type == "حقوقی" ? "لطفا تمامی مدارک را بارگذاری نمایید" : "یک یا چند مورد از مدارک زیر بارگذاری نشده \n تصویر پشت و روی کارت ملی \n تصویر شناسنامه \n تاییدیه شبا",
                );
              } : null ,
                child: Text("اتمام مراحل بارگذاری ",style: TextStyle(fontWeight: FontWeight.w700),) , ),)


            ],)))));
  }


  Widget items (String txt, bool idA , bool idB, File file , VoidCallback get ,VoidCallback gett , dynamic up ,bool select,  bool send, bool resend , bool uping ){
    var size = MediaQuery.of(context).size;
    var hSize =  size.height * .33;

    double fSize3 = 35;

    return Container(
        width: size.width * .48,
        height: hSize,
        margin: EdgeInsets.only( bottom: 7),
        decoration: BoxDecoration(
          color: Color(0xffe8e8e8),
          border: Border.all(color: Color(0xff717171),width: 1),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          //border: Border.all(color: Color(0xffffffff))
        ),

        child:
        Column(
          //      mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
                alignment: Alignment.center,
                height: hSize *.8,
                width: size.width * .47,
                //height: size.height * 0.2,
                child: Stack(
                  children: [
                    idA == true
                        ? Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(borderRadius: BorderRadius.circular(10.0),
                            child: Image.file(file,
                                height: hSize * .76, fit: BoxFit.cover)),
                        idB == true
                            ? Container(height: hSize * .8, width: size.width *.5 ,color: Color(
                            0x48ffffff),child: Icon(Icons.check_circle_outline,size: 60,color: Color(
                            0xff31ff00),),)
                            : SizedBox()
                      ],
                    )
                        : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_photo_alternate_outlined,
                          size: fSize3,
                          color: Color(0xff3b3b3b),
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
                //height: hSize * 0.15,
                child: Column(

                  ///requestFullMetadata
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(visible: select ,child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,children: [
                      ElevatedButton(onPressed:  get ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                          0xff1e4abd))),child: Icon(Icons.filter) , ),
                      ElevatedButton(onPressed:  gett ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                          0xff008655))),child: Icon(Icons.camera_alt) , ),
                    ],)),
                    Visibility(visible: send ,child: ElevatedButton(onPressed: (){ up(); } ,style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(
                        0xff367167))),child: Text("     ارسال    ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),) , )),
                    Visibility(visible: uping ,child: Container(child: SpinKitThreeBounce(color: Color(0xffffa625)),height: size.height * .05, width: size.height * .05,)),
                    Visibility(visible: resend ,child: ElevatedButton(onPressed: (){ up(); } ,child: Text("   ارسال مجدد   ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w300),) , )),
                    Visibility(visible: resend ,child: Text(" خطا در ارسال ") ),
                    Visibility(visible: idB ,child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color(0x88ffffff))),onPressed: () {  },
                      child: Text( "بارگذاری موفق",style: TextStyle(color: Color(
                          0xe2000000),fontSize: 18),textAlign: TextAlign.center,) , )),
                  ],
                )),

          ],
        ));
  }

  void fun(){
    _key.length > 1? (){
      if (Counter == 4) saveUpload(); else CoolAlert.show(
        context: context,
        type: CoolAlertType.warning,
        confirmBtnText: "باشه",
        title: "",
        backgroundColor: Colors.white,
        text: Type=="حقوقی" ? "لطفا تمامی مدارک را بارگذاری نمایید" : "یک یا چند مورد از مدارک زیر بارگذاری نشده: \n تصویر پشت و روی کارت ملی \n تصویر شناسنامه \n تاییدیه شبا",
      );
    } : null;
  }
  Future<Null> _cropImage(File f , int tag) async {
    File? croppedFile = await ImageCropper().cropImage(
      sourcePath: f.path,
      aspectRatioPresets: Platform .isAndroid
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
      else if(tag == 2) ID_Card2 = croppedFile;
      else if(tag == 3) Esteshhad = croppedFile;
      else if(tag == 4) Javaz = croppedFile;
      else if(tag == 5) ID_Card3 = croppedFile;
      else if(tag == 6) Maliyat = croppedFile;
      else if(tag == 7) Sheba = croppedFile;
      else if(tag == 9) Ejare = croppedFile;

      setState(() {});
    }

  }

  _upload1() async {
    uploading1 = true;sendBtn1 = false;resendBtn1 = false;selectBtn1 = false;setState(() {});
    String f = base64Encode(ID_Card1.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "26.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") { Counter++;
    uploading1 = false; Sid_card1 = true; sendBtn1 = false;
    } else {resendBtn1=true; sendBtn1 =false; uploading1 = false;}
    setState(() {}); }

  _upload2() async {
    uploading2 = true;sendBtn2 = false;resendBtn2 = false;selectBtn2 = false;setState(() {});
    String f = base64Encode(ID_Card2.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "27.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {Counter++;
    uploading2 = false; Sid_card2 = true; sendBtn2 = false;
    } else {resendBtn2=true; sendBtn2 =false; uploading2 = false;}
    setState(() {}); }

  _upload3() async {
    uploading3 = true;sendBtn3 = false;resendBtn3 = false;selectBtn3 = false;setState(() {});
    String f = base64Encode(Esteshhad.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "9007.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {
      uploading3 = false; Sesteshhad = true; sendBtn3 = false;
    } else {resendBtn3=true; sendBtn3 = false; uploading3 = false;
    await (OnlineServices()).sendError({"error": response});
    CoolAlert.show(
      context: context,
      confirmBtnText: "   بستن  ",
      type: CoolAlertType.error,
      title: "لطفا خطای 289 را به مدیر اعلام کنید",
      backgroundColor: Colors.white,
    );
    }
    setState(() {}); }

  _upload4() async {
    uploading4 = true;sendBtn4 = false;resendBtn4 = false;selectBtn4 = false;setState(() {});
    String f = base64Encode(Javaz.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "25.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {
      uploading4 = false; Sjavaz = true; sendBtn4 = false;
    } else {resendBtn4=true; sendBtn4 =false; uploading4 = false;}
    setState(() {}); }

  _upload5() async {
    uploading5 = true;sendBtn5 = false;resendBtn5 = false;selectBtn5 = false;setState(() {});
    String f = base64Encode(ID_Card3.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "28.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {Counter++;
    uploading5 = false; Sid_card3 = true; sendBtn5 = false;
    } else {resendBtn5=true; sendBtn5 =false; uploading5 = false;}
    setState(() {}); }

  _upload6() async {
    uploading6 = true;sendBtn6 = false;resendBtn6 = false;selectBtn6 = false;setState(() {});
    String f = base64Encode(Maliyat.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "2.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {
      uploading6 = false; Smaliyat = true; sendBtn6 = false;
    } else {resendBtn6=true; sendBtn6 =false; uploading6 = false;}
    setState(() {}); }


  _upload7() async {
    uploading7 = true;sendBtn7 = false;resendBtn7 = false;selectBtn7 = false;setState(() {});
    String f = base64Encode(Sheba.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "12.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {Counter++;
    uploading7 = false; Ssheba = true; sendBtn7 = false;
    } else {resendBtn7=true; sendBtn7 =false; uploading7 = false;}
    setState(() {}); }


  _upload9() async {
    uploading9 = true;sendBtn9 = false;resendBtn9 = false;selectBtn9 = false;setState(() {});
    String f = base64Encode(Ejare.readAsBytesSync());
    var response = await (OnlineServices()).sendForUpload({"name": "14.jpg",  "sanad": _key.split("-").first,  "files": f,});
    if (response == "ok") {
      uploading9 = false; Sejare = true; sendBtn9 = false;
    } else {resendBtn9=true; sendBtn9 =false; uploading9 = false;}
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

  Future getImage11() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(100).toString());
    ID_Card1 = await File(pickedFile!.path).copy(Path);
    id_card1 = !id_card1;sendBtn1 = true;selectBtn1 = false;
    _cropImage(ID_Card1, 1);
    //  setState(() {});
  }

  Future getImage2() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(200).toString());
    ID_Card2 = await File(pickedFile!.path).copy(Path);
    id_card2 = !id_card2;sendBtn2 = true;selectBtn2 = false;
    _cropImage(ID_Card2, 2); }

  Future getImage22() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(200).toString());
    ID_Card2 = await File(pickedFile!.path).copy(Path);
    id_card2 = !id_card2;sendBtn2 = true;selectBtn2 = false;
    _cropImage(ID_Card2, 2); }

  Future getImage3() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(300).toString());
    Esteshhad = await File(pickedFile!.path).copy(Path);
    esteshhad = !esteshhad; sendBtn3 = true;selectBtn3 = false;
    _cropImage( Esteshhad, 3); }

  Future getImage33() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(300).toString());
    Esteshhad = await File(pickedFile!.path).copy(Path);
    esteshhad = !esteshhad; sendBtn3 = true;selectBtn3 = false;
    _cropImage( Esteshhad, 3); }

  Future getImage4() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(400).toString());
    Javaz = await File(pickedFile!.path).copy(Path);
    javaz = !javaz;sendBtn4 = true;selectBtn4 = false;
    _cropImage( Javaz, 4); }


  Future getImage44() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(400).toString());
    Javaz = await File(pickedFile!.path).copy(Path);
    javaz = !javaz;sendBtn4 = true;selectBtn4 = false;
    _cropImage( Javaz, 4); }

  Future getImage5() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(500).toString());
    ID_Card3 = await File(pickedFile!.path).copy(Path);
    id_card3 = !id_card3;sendBtn5 = true;selectBtn5 = false;
    _cropImage( ID_Card3, 5); }


  Future getImage55() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(500).toString());
    ID_Card3 = await File(pickedFile!.path).copy(Path);
    id_card3 = !id_card3;sendBtn5 = true;selectBtn5 = false;
    _cropImage( ID_Card3, 5); }

  Future getImage6() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(700).toString());
    Maliyat = await File(pickedFile!.path).copy(Path);
    maliyat = !maliyat;sendBtn6 = true;selectBtn6 = false;
    _cropImage( Maliyat, 6); }

  Future getImage66() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(700).toString());
    Maliyat = await File(pickedFile!.path).copy(Path);
    maliyat = !maliyat;sendBtn6 = true;selectBtn6 = false;
    _cropImage( Maliyat, 6); }

  Future getImage7() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(700).toString());
    Sheba = await File(pickedFile!.path).copy(Path);
    sheba = !sheba;sendBtn7 = true;selectBtn7 = false;
    _cropImage( Sheba, 7); }

  Future getImage77() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(700).toString());
    Sheba = await File(pickedFile!.path).copy(Path);
    sheba = !sheba;sendBtn7 = true;selectBtn7 = false;
    _cropImage( Sheba, 7); }

  Future getImage9() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.gallery,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(900).toString());
    Ejare = await File(pickedFile!.path).copy(Path);
    ejare = !ejare;sendBtn9 = true;selectBtn9 = false;
    _cropImage( Ejare, 9); }

  Future getImage99() async {
    final pickedFile = await _picker.pickImage( source: ImageSource.camera,);
    String dir = (await getApplicationDocumentsDirectory()).path;
    String Path = path.join(dir,  Random().nextInt(900).toString());
    Ejare = await File(pickedFile!.path).copy(Path);
    ejare = !ejare;sendBtn9 = true;selectBtn9 = false;
    _cropImage( Ejare, 9); }

}