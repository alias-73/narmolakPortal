
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/profile/profile.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/dashboard.dart';
import 'package:sima_portal/a_sima_app/video_services/list_products.dart';
import 'package:sima_portal/a_sima_app/video_services/list_videos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'apps.dart';
import 'models/accessssssModel.dart';
import 'models/infUserModel.dart';
import 'models/notificationModel.dart';
import 'news/news-model.dart';
import 'news/news.dart';

class appbar_home extends StatefulWidget {
  List<AgentModel> _data = [];
  //const _LineChart8({required this.isShowingMainData});

  late final bool isShowingMainData;
  appbar_home(this._data);
  @override
  State<StatefulWidget> createState() => sampleState();
}

class ItemModel {
  String title;

  ItemModel(this.title);
}

class sampleState extends State<appbar_home> {
  late PageController _pageController;
  late AnimationController _animationController;
  int _currentIndex = 0;
  List<AccessModel1> _data2 = [];
  late AudioPlayer player;
  List<UserInfModel> userinfo = [];
  String Name = "";
  String Mobile = "";

  String title = "";
  String icon = "";
  int i = 0;

  late List<ItemModel> menuItems;
  List<NotificationModel> _message = [];
  List<NewsModel> _message2 = [];

  void getNotification() async {
    Map response;
    response = await OnlineServices.getNotification({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    if (response["data"] != "free") {
      await player.setAsset('assets/ding1.mp3'); player.play();
      _message.clear();
      menuItems.clear();
      _message.addAll(response['data']);

      for (int i =0 ; i< _message.length ; i++)
        {
          menuItems.add(ItemModel(_message[i].desc));
        }

      setState(() {});
    } else {
      //  print("freeeeeee");
    }
  }

  void getNews() async {
    Map response;
    response = await OnlineServices.getNewsList({
    "section" : "new",
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    //  print("freeeeeee");
    _message2.clear();

    // print(response["data"]);

    if (response["data"] != "free") {
      await player.setAsset('assets/ding2.mp3'); player.play();

      _message2.clear();
      _message2.addAll(response['data']);

      setState(() {});
    } else {
      setState(() {});

      //  print("freeeeeee");
    }
  }

  void clearNotification() async {
    String response = await OnlineServices.clearNotification({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });

      if(response == "ok" ){ menuItems.clear(); _controller.hideMenu();
      setState(() {});}

  }

  @override
  void initState() {
    getName();
    getAccess();
    menuItems = [];
    _pageController = PageController();
    getNotification();
    getNews();
    super.initState();
    player = AudioPlayer();

  }
  CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  List<BottomNavyBarItem> BTNs1 = [
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('داشبورد'),
        icon: Icon(Icons.pie_chart)
    ),

    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('آموزش'),
        icon: Icon(Icons.movie_creation_outlined)
    ),
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('برنامه ها'),
        icon: Icon(Icons.apps)
    ),
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('فروشگاه'),
        icon: Icon(Icons.storefront)
    ),

    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('پروفایل'),
        icon: Icon(Icons.person_pin)
    ),
  ];
  List<BottomNavyBarItem> BTNs2 = [
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('داشبورد'),
        icon: Icon(Icons.pie_chart)
    ),

    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('آموزش'),
        icon: Icon(Icons.movie_creation_outlined)
    ),
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('برنامه ها'),
        icon: Icon(Icons.apps)
    ),
    BottomNavyBarItem(
        activeColor: Color(0xff020202),
        inactiveColor: Color(0xff020202),
        title: Text('پروفایل'),
        icon: Icon(Icons.person_pin)
    ),
  ];

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication, )) {
    // if (!await launchUrl(Uri.parse(url),webViewConfiguration: const WebViewConfiguration(enableDomStorage: false), )) {
      throw 'Could not launch ';
    }
  }

  void getAccess() async {
    // print("________running_______");

    Map response = await OnlineServices.getAccess({
      "agentcode": widget._data.last.agentCode,
    });
    _data2.clear();
    // print(response['data']);
    // print("______833***_________");
    if(response['data'] == "free")
      _data2.clear();
    else
    _data2.addAll(response['data']);

  }

  void getName() async {
    Map response2;
    response2 = await OnlineServices.getName2({
      "agentcode": widget._data.last.agentCode,
      "usercode": widget._data.last.userCode
    });
    if (response2["data"] != "free") {
      userinfo.addAll(response2['data']);
    }
    Name = userinfo.last.name;
    Mobile = userinfo.last.mobile;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> a = [
      dashboard(widget._data),
      list_videos(widget._data),
      apps(widget._data,_data2),
      list_products(widget._data),
      profile_page(widget._data) ,
    ];

    List<Widget> b = [
      dashboard(widget._data),
      list_videos(widget._data),
      apps(widget._data,_data2),
      profile_page(widget._data) ,
    ];
    var size = MediaQuery.of(context).size;

    // widget._data.last.agentCode == "10070" ? title = "بایاپوز نوین" :
    // widget._data.last.agentCode == "10145" ? title = "نوین آوا" :
    //                                          title = "سیماخوان" ;

    widget._data.last.agentCode == "10070" ? icon = "assets/images/appbar_logo_baya.png" :
    widget._data.last.agentCode == "10145" ? icon = "assets/images/appbar_logo_novin.png" :
                                             icon = "assets/images/appbar_logo_sima.png" ;

    return Scaffold(
      appBar: AppBar(
       // leading: IconButton(icon: Icons.b),
        iconTheme: IconThemeData(color: Colors.black,),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Image.asset( icon ,height: 50,),
          // SizedBox(width: 6,),
          // BorderedText(
          //   strokeWidth: 3,
          //   strokeColor: Color(0xff171717),
          //   child:
          //   Text(
          //     title,
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 21.0,
          //     ),
          //   ),
          // ),
          //Text(title,style: TextStyle(color: Colors.black),),
          Row(children: [
            Stack(alignment: Alignment.bottomCenter,children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: news_page(widget._data))));

              }, icon: Icon(Icons.newspaper)),
              Visibility(visible: _message2.isNotEmpty ? true : false,child: Container(
                margin: EdgeInsets.only(left: 20,bottom: 10),
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red
                ),
              ),)
            ],),
            IconButton(onPressed: (){
              Comp.show_short_info("این امکان در نسخه دمو فعال نمیباشد");

              // _launchUrl("http://sima-pay.com/goftino.html?txt=${widget._data.last.agentCode}*${Name}*${Mobile}");
              }, icon: Icon(Icons.support_agent)),
            // IconButton(onPressed: (){_launchUrl("https://www.goftino.com/c/J71l9U");}, icon: Icon(Icons.support_agent)),
            CustomPopupMenu(
              arrowColor: Colors.transparent,
              menuBuilder: () => ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10),),
                        border: Border.all(color: Colors.white,width: 2.7),
                        color: const Color(0xFFEEEEEE),
                      ),
                      width: size.width * .85,
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [                          // SizedBox(width: 6,),
                          Text("    اعـلانـات   ",style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w700
                          )),
                          GestureDetector(child: Row(
                            children: [
                              Text(
                                "پاک کردن همه",
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700
                                ),
                              ),
                              Icon(Icons.restore_from_trash),
                              SizedBox(width: 9,),
                            ],
                          ),
                            onTap: (){
                              clearNotification();
                            },),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10),),
                        border: Border.all(color: Colors.white,width: 2.7),
                        color: const Color(0xFFE7E7E7),

                      ),
                      width: size.width * .85,
                      height: size.height * .7,
                      child: IntrinsicWidth(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: menuItems
                                .map(
                                  (item) => GestureDetector(
                                behavior: HitTestBehavior.translucent,
                                onTap: () { _controller.hideMenu(); },
                                child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 17),
                                    child: Column(children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 4),
                                        child: Text(
                                          item.title,
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ), Divider(thickness: 0.5,color: Colors.grey,)
                                    ],)
                                ),
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              pressType: PressType.singleClick,
              verticalMargin: -10,
              controller: _controller,
              child: Stack(alignment: Alignment.bottomCenter,children: [
                IconButton(icon: Icon(Icons.notifications_active),onPressed: (){
                  menuItems.isNotEmpty ? _controller.showMenu() : Comp.show_short_info("اعلانی وجود ندارد");
                  //    !_controller.menuIsShowing ? _controller.showMenu() : _controller.hideMenu() ;
                },),
                Visibility(visible: menuItems.isNotEmpty ? true : false,child: Container(
                  margin: EdgeInsets.only(left: 20,bottom: 10),
                  height: 10,
                  width: 10,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red
                  ),
                ),)
              ],),
            )
          ]),

        ]),
      ),

      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
             getNotification();
             getNews();
             // _currentIndex == 2 ? getAccess() : null;

          },
          children:  widget._data.last.userCode != "0" ? b : a ,
        ),
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: Color(0xFFFAFAFA),
        showElevation: true,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: widget._data.last.userCode == "0" ? BTNs1 :BTNs2,
      ),
    );
  }}