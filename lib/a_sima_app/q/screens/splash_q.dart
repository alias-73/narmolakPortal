
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_question_answer_widget/flutter_question_answer_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/login_page.dart';
import 'package:cool_alert/cool_alert.dart';
import '../../appbar_home.dart';
import '../../components/Styles.dart';
import '../../models/agentModel.dart';
import '../../services/online_services.dart';
import '../../sima_home1.dart';

class introPage extends StatefulWidget {
  List<AgentModel> _data = [];
  introPage(this._data);
  @override
  _introPageState createState() => _introPageState();
}

class _introPageState extends State<introPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  String ISlogin = "-";
  bool loading = false;
  bool isAnswered = false;
  bool isShow = false;
  int counter = 0;

  String _q1 = "1- بیشترین استفاده شما از پرتال شرکت در کدام بستر میباشد؟";
  String _q2 = "2- به امکانات پرتال چه امتیازی می دهید؟";
  String _q3 = "3- چند نفر در مجموعه شما فعال هستند؟";
  String _q4 = "4- چه مواردی را از نقاط قوت پرتال میدانید؟";
  String _q5 = "5- چه مواردی را از نقاط ضعف پرتال میدانید؟";
  String _q6 = "6- به سرعت پاسخ دهی کارشناسان ما چه امتیازی می دهید";
  String _q7 = "7- آیا شرکتی با پورتال نمایندگان با خدمات بهتر از ما میشناسید؟";
  String _q8 = "8- پیشنهاد شما برای بهتر شدن پرتال، کدام موارد است؟";
  String _q9 = "9- به عملکر کلی پرتال چه امتیازی می دهید؟";
  String _q10 = "10- علت انتخاب شرکت ما برای شما کدام موارد است؟";
  String _q11 = "11- مهمترین مزیت برای شما در انتخاب این شرکت چیست؟";
  String _q12 = "12- چه مواردی باعث عدم همکاری با ما از سوی شما می شود؟";
  String _q13 = "13- چگونه می توانیم در آینده بهتر به شما خدمت کنیم؟";

  String _a1 = "-";
  String _a2 = "-";
  final  _a3 = GlobalKey<FormFieldState>();
  final  _a4 = GlobalKey<FormFieldState>();
  final  _a5 = GlobalKey<FormFieldState>();
  String _a6 = "-";
  String _a7 = "-";
  final  _a7a = GlobalKey<FormFieldState>();
  final  _a8 = GlobalKey<FormFieldState>();
  String _a9 = "-";
  final  _a10 = GlobalKey<FormFieldState>();
  final  _a11 = GlobalKey<FormFieldState>();
  final  _a12 = GlobalKey<FormFieldState>();
  final  _a13 = GlobalKey<FormFieldState>();

  void _onIntroEnd(context) async {
    if(_a1=="-" || _a2=="-" || _a6=="-" || _a7=="-" || _a9=="-" || _a3.currentState!.value.toString().isEmpty || _a4.currentState!.value.toString().isEmpty || _a5.currentState!.value.toString().isEmpty  || _a8.currentState!.value.toString().isEmpty  || _a10.currentState!.value.toString().isEmpty  || _a11.currentState!.value.toString().isEmpty  || _a12.currentState!.value.toString().isEmpty  || _a13.currentState!.value.toString().isEmpty )
    {
      Comp.showSnack(context , Icons.warning,  "لطفا به تمام سوالات پاسخ دهید" );
    }
    else {
      if( _a7.contains("بلی") && _a7a.currentState!.value.toString().isEmpty)
        {
          Comp.showSnack(context , Icons.warning,  "لطفا به تمام سوالات پاسخ دهید" );
        }
      else{
        //Comp.showSnack(context , Icons.warning,  "ارسال شد" );
        counter++;
        sendData1();
        loading = true;
        setState(() {});

      }

    }
  }


  void sendData1 () async{
    counter == 1 ? sendData( "1 ", _a1 ) :
    counter == 2 ? sendData( "2 ", _a2 ) :
    counter == 3 ? sendData( "3 ", _a3.currentState!.value.toString() ) :
    counter == 4 ? sendData( "4 ", _a4.currentState!.value.toString() ) :
    counter == 5 ? sendData( "5 ", _a5.currentState!.value.toString() ) :
    counter == 6 ? sendData( "6 ", _a6 ) :
    counter == 7 ? sendData( "7 ", _a7.contains("خیر") ? "خیر، نمیشناسم" : "بله، میشناسم: " + _a7a.currentState!.value.toString() ) :
    counter == 8 ? sendData( "8 ", _a8.currentState!.value.toString() ) :
    counter == 9 ? sendData( "9 ", _a9 ) :
    counter == 10 ? sendData( "10 ", _a10.currentState!.value.toString() ) :
    counter == 11 ? sendData( "11 ", _a11.currentState!.value.toString() ) :
    counter == 12 ? sendData( "12 ", _a12.currentState!.value.toString() ) :
    counter == 13 ? sendData( "13 ", _a13.currentState!.value.toString() ) : Center();
  }

  void sendData ( String Question , String Answer) async{
    String response = await OnlineServices.sendQuestionaire({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode,
      "q" : Question,
      "a" : Answer
    });
    if(response.contains("ok")  && counter != 13)
      {
        counter++;
        sendData1();
      }
    else if(counter == 13)
      {
        loading = false;
        setState(() {});
        CoolAlert.show(
          context: context,
          confirmBtnText: "   شروع نرم افزار  ",
          type: CoolAlertType.success,
          title: "",
          backgroundColor: Colors.white,
          onConfirmBtnTap: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._data))));
          }, text: "از اینکه در نظر سنجی ما شرکت کردید، سپاسگزاریم 🙏",
        );
      }
  }



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent));

    const bodyStyle = TextStyle(fontSize: 19.0);
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          child: Image.asset("assets/images/bc.jpg"),
        ),
        IntroductionScreen(
          key: introKey,
          globalBackgroundColor: Colors.white,
          // globalHeader: Align(
          //   alignment: Alignment.topRight,
          //   child: SafeArea(
          //     child: Padding(
          //       padding: const EdgeInsets.only(top: 16, right: 16),
          //       //child: _buildImage('flutter.png', 100),
          //     ),
          //   ),
          // ),
          pages: [
            PageViewModel(
              useScrollView: true,
              titleWidget :Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Container(width: size.width * .7,
                      decoration: BoxDecoration(
                      color: Color(0xff7b7b7b),
                      borderRadius: BorderRadius.circular(20)),
                      height: size.height * .1,
                      child: Center (child: Text("فرم نظر سنجی نمایندگان" , style:  TextStyle(fontSize: fontSize6,fontWeight: FontWeight.w800, color: Color(0xfffac80a)),)),
                      ),
                    width: size.width * .8,
                  height: size.height * .14,
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xfffac80a) , width: 4 ),
                    borderRadius: BorderRadius.circular(20)
                  ),),
                   SizedBox(height: 20,),
                   Image.asset("assets/images/q.jpg" , width: size.width * .6,),

                  question("نماینده گرامی"),
                  question2("جهت بهبود کیفیت و افزایش خدمات، لطفا فرم نظر سنجی را با دقت تکمیل نمایید.\n شایان ذکر است نظرهای ارسال شده محرمانه می باشد و هیچ گونه اطلاعاتی از شخص ثبت کننده ذخیره نمی گردد.\n پس هر چه دل تنگت میخواهد بگو ! 😉")
                ],
              ),
              bodyWidget: Center(),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              // image: Center(),
              titleWidget :question(_q1),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: _a1,
                question: "",
                answerList: ["وب", "اپلیکیشن موبایل"],
                answerWidth: size.width,
                onChanged: (String value) {
                  setState(() {
                    // if(!_a1.contains(value))
                    //   {
                    //     print(_a1);
                    //   }

                    _a1 = value;
                  });
                },
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question(_q2),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: _a2,
                question: "",
                answerList: ["عالی", "خوب", "متوسط" , "ضعیف" , "خیلی ضعیف"],
                answerWidth: size.width,
                onChanged: (String value) {
                  setState(() {
                    _a2 = value;
                  });
                },
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question4(_q3 , _a3),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q4 , _a4),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "", question: "", answerList: [],
                answerWidth: size.width,), decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q5 , _a5),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "", question: "", answerList: [],
                answerWidth: size.width,), decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question(_q6),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: _a6,
                question: "",
                answerList: ["عالی", "خوب", "متوسط" , "ضعیف" , "خیلی ضعیف"],
                answerWidth: size.width,
                onChanged: (String value) {
                  setState(() {
                    // if(!_a1.contains(value))
                    //   {
                    //     print(_a1);
                    //   }

                    _a6 = value;
                  });
                },
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question(_q7 ),
              bodyWidget: Column(
                children: [
                  FlutterQuestionAnswerWidget.singleSelection(
                    answered: _a7,
                    question: "",
                    answerList: ["خیر، نمیشناسم", "بلی، میشناسم"],
                    answerWidth: size.width,
                    onChanged: (String value) {
                      if(value.contains("بلی")){isShow = true;} else isShow=false;
                      setState(() {_a7 = value;});},
                  ),
                  Visibility(visible: isShow ,child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "لطفا نام شرکت را وارد کنید"
                    ),
                    textAlign: TextAlign.right,
                    key: _a7a,
                  ))
                ],
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q8 , _a8),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question(_q9),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: _a9,
                question: "",
                answerList: ["عالی", "خوب", "متوسط" , "ضعیف" , "خیلی ضعیف"],
                answerWidth: size.width,
                onChanged: (String value) {
                  setState(() {
                    _a9 = value;
                  });
                },
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q10 , _a10),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q11 , _a11),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),







              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q12 , _a12),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),
            PageViewModel(
              titleWidget :question3(_q13 , _a13),
              bodyWidget: FlutterQuestionAnswerWidget.singleSelection(
                answered: "",
                question: "",
                answerList: [],
                answerWidth: size.width,
              ),
              //image:  Center(),
              decoration: pageDecoration,
            ),


          ],
          onDone: () => _onIntroEnd(context),
          //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
          showSkipButton: false,
          skipOrBackFlex: 0,
          nextFlex: 0,
          showBackButton: true,
          rtl: true, // Display as right-to-left
          back: const Icon(Icons.arrow_forward,color: Color(0xfffac80a),),
          //skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600,color: Color(0xfffac80a),)),
          next: const Icon(Icons.arrow_back,color: Color(0xfffac80a),),
          done: const Text('ارسال', style: TextStyle(fontWeight: FontWeight.w500,color: Color(0xfffac80a),)),
          curve: Curves.fastLinearToSlowEaseIn,
          controlsMargin: const EdgeInsets.all(6),
          controlsPadding: kIsWeb
              ? const EdgeInsets.all(0.0)
              : const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
          dotsDecorator: const DotsDecorator(
            activeColor:  Color(0xfffac80a),
            size: Size(4.0, 4.0),
            color: Color(0xFFBDBDBD),
            activeSize: Size(7.0, 7.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          dotsContainerDecorator: const ShapeDecoration(
            color: Colors.black87,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),
        loading ? Comp.showLoading(size.height , size.width) : Center()
      ],
    );
  }
  
  Widget question (String txt){
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    return Container(
      child: Text("\n" + txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: fontSize6
        ),),
    );
    
  }


  Widget question2 (String txt){
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    double fontSize5 = blockSize * 5;
    return Container(
      child: Text("\n" + txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: fontSize5
        ),),
    );

  }

  Widget question3 (String txt ,GlobalKey key){
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    double fontSize5 = blockSize * 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("\n" + txt,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: fontSize6
          ),),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          maxLines: 9,
          decoration: InputDecoration(
              hintText: "اینجا بنویسید . . . "
          ),
          textAlign: TextAlign.right,
          key: key,
        )
      ],
    );

  }

  Widget question4 (String txt ,GlobalKey key){
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize6 = blockSize * 6;
    double fontSize5 = blockSize * 5;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text("\n" + txt,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: fontSize6
          ),),
        SizedBox(
          height: 30,
        ),
        TextFormField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          decoration: InputDecoration(

              hintText: "اینجا بنویسید . . . "
          ),
          textAlign: TextAlign.right,
          key: key,
        )
      ],
    );

  }

}