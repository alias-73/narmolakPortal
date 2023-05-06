
// ignore_for_file: missing_return, deprecated_member_use
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/Pazirade/PazirandeAccordian.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/components/Styles.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/pazirande-model.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos1.dart';
import 'package:sima_portal/a_sima_app/Pazirade/register_pos11.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import '../../shimmer.dart';
import 'EditedStore_page.dart';
import 'dart:math' as math;

class poses_list_page extends StatefulWidget {
  List<AgentModel> _Agentdata = [];
  poses_list_page(this._Agentdata);
  @override
  State<StatefulWidget> createState() => poses_list_pageState();

}

class poses_list_pageState extends State<poses_list_page> with SingleTickerProviderStateMixin {


  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int i = 0;
  bool isFree = false;
  final primary = Color(0xff000000);
  final secondary = Color(0xfff29a94);
  List<PazirandeModel> _data = [];
  List<PazirandeModel> _data2 = [];
  List<PazirandeModel> _data3 = [];
  final _key4 = GlobalKey<PopupMenuButtonState>();

//  List<PazirandeModel> _data3 = [];
  late Map response;
  bool isOpened = false;
late  AnimationController _animationController;
late  Animation<Color> _buttonColor;
late  Animation<double> _animateIcon;
late  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  initState() {


    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 100))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    )) as Animation <Color>;
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }


  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: 4,
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animateIcon,
        ),
      ),
    );
  }

  Future<List<PazirandeModel>> _getData() async {
    //print(widget._Agentdata.last.agentCode + "8" + widget._Agentdata.last.userCode);
    i++;
    if (i < 2) {
      response = await OnlineServices.getPazirandeList({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": widget._Agentdata.last.userCode
      });
      //  response = await OnlineServices.getPazirandeList({"agentcode" : "10004","usercode" : "0"} );
      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        _data3.addAll(response['data']);
     //   print(_data[i].emza);

        for (int i = 0; i < _data.length; i++) {

          if (_data[i].name == "" || _data[i].name == null) {
            _data[i].name = "بدون نام";
          }
        }
        setState(() {});
        // Future.delayed(const Duration(milliseconds: 1000), () {
        //   setState(() {});});
      }
      else {
        isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }

  void _showAction(BuildContext context, int index) {
      // index == 0 ? Navigator.push(context, MaterialPageRoute(
      //           builder: (context) =>
      //           Directionality(
      //               textDirection: TextDirection.rtl,
      //               child: editedStore_page(widget._Agentdata)))) :
      index == 0 ? Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: register_pos_page11(widget._Agentdata)))):
      Navigator.push(context, MaterialPageRoute(
          builder: (context) =>
              Directionality(
                  textDirection: TextDirection.rtl,
                  child: register_pos_page1(widget._Agentdata))));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xfff0f0f0),

      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 30),
        child: ExpandableFab(
          distance: 70.0,
          children: [
            // ActionButton(
            //   onPressed: () => _showAction(context, 0),
            //   icon: const Icon(Icons.drive_file_rename_outline),
            // ),
            ActionButton(
              onPressed: () => _showAction(context, 0),
              icon: const Icon(Icons.person_pin_outlined),
            ),
            ActionButton(
              onPressed: () => _showAction(context, 1),
              icon: const Icon(Icons.person_add),
            ),
          ],
        ),
      ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.edit,),
      //   onPressed: (){
      //      Navigator.push(context, MaterialPageRoute(builder: (context) => Directionality(textDirection: TextDirection.rtl, child:
      //      editerStore_page(widget._Agentdata))));
      //   },
      // ),
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("لیست پذیرنده ها","", Icons.edit, (){})),

      body: Stack(

        children: [
          Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                      padding: EdgeInsets.only(right: 20),
                      width: size.width * .9,
                      child: TextFormField(
                        onChanged: (txt) {
                          //srch = txt;
                          // print(txt);
                          ///ناظ
                          //_getData2();
                          if (txt.length > 0) {
                            _data3.clear();
                            _data3.addAll(response['data']);
                            for (int i = 0; i < _data3.length; i++) {
                              if (_data3[i].name == "" || _data3[i].name == null) {
                                _data3[i].name = "بدون نام";
                              }
                            }

                            if (double.tryParse(txt) != null) {
                              _data3.removeWhere((element) => !element.usercode.contains(txt.toString()));

                            } else {
                              _data3.removeWhere((element) => !element.name.contains(txt.toString()));

                            }
                            setState(() {});
                          }
                          else {
                            // print("________222222222_________");
                            _data3.clear();
                            _data3.addAll(response['data']);
                            setState(() {});
                          }
                        },
                        style: const TextStyle(
                          color: Color(0xbb000000),
                        ),
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            hintText: "جستجو بر اساس کد کاربر و نام پذیرنده",
                            hintStyle: const TextStyle(
                                color: Color(0x55000000), fontSize: 16),
                            contentPadding: const EdgeInsets.only(
                                top: 11, right: 0, bottom: 10, left: 5
                            )
                        ),
                      )),
                  IconButton(icon: Icon(_data.length > _data3.length ? Icons.filter_alt_rounded : Icons.filter_alt_outlined,size: 35,color: _data.length > _data3.length ? Colors.red : Colors.black,),onPressed: ()async{ filter(context);setState(() {

                  });},)
                ],
              ),
              Expanded(child: FutureBuilder<List<PazirandeModel>>(
                future: _getData(),
                builder: (context,
                    AsyncSnapshot<List<PazirandeModel>> snapshot) {
                  if (snapshot.hasData) {
                    return
                      ListView.builder(
                          itemCount: _data3.length,
                          itemBuilder: (BuildContext context, int index) {
                            return
                              PazirandeAccordion(_data3,index,size,widget._Agentdata);
                              AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 175),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child:  PazirandeAccordion(_data3,index,size,widget._Agentdata)
                                  ,
                                ),
                              ),
                            );
                          });
                  }

                  else if (snapshot.hasError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },)

              ),
            ],
          ),

          _data2.length < 1 && isFree == false ?
          Comp.loadingList_shimmer(size.height , size.width)
              : Center()
        ],
      ),);
  }

  Widget loadingList_shimmer(){
    var size = MediaQuery.of(context).size;

    return  SizedBox(
        width: size.width,
        height: size.height,
        child: Shimmer.fromColors(
        direction: ShimmerDirection.rtl,
        baseColor: Color(0xffffffff),
    highlightColor: Color(0xffe5e5e5),
    child: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              margin: EdgeInsets.only(bottom: 5, top: 10, right: 10, left: 10),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  Column(children: [
                    ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: (size.width - 10) * .49,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [

                                ],
                              ),
                            ),
                            Row(
                              children: [

                                SizedBox(
                                  width: 10,
                                ),

                              ],
                            )
                          ],
                        )),

                  ]),
                ],
              ));

        })));
  }


  void filter(BuildContext context) async {
    int? val = -1;
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  Text(
                    "انتخاب فیلتر",
                    textAlign: TextAlign.center,
                  ),
                  Divider(thickness: 2,color: Colors.black87,)
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: Column(
                          //alignment: Alignment.center,
                          children: <Widget>[
                            ListTile(
                              title: Text("همه"),
                              leading: Radio(
                                value: 9,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int?;
                                  });
                                },
                                activeColor: Color(0xff000000),
                              ),
                            ),
                            ListTile(
                              title: Text("ایران کیش"),
                              leading: Radio(
                                value: 11,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("پاسارگاد"),
                              leading: Radio(
                                value: 12,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("فعال"),
                              leading: Radio(
                                value: 1,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int?;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("تایید شد"),
                              leading: Radio(
                                value: 2,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int?;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("نیاز به اصلاح"),
                              leading: Radio(
                                value: 3,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int?;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("آماده تخصیص"),
                              leading: Radio(
                                value: 4,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("درخواست ابطال"),
                              leading: Radio(
                                value: 5,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("رد پرونده"),
                              leading: Radio(
                                value: 6,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("نیاز به ثبت کارتابل"),
                              leading: Radio(
                                value: 7,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("غیرفعال مالیاتی"),
                              leading: Radio(
                                value: 8,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),
                            ListTile(
                              title: Text("درحال بررسی"),
                              leading: Radio(
                                value: 10,
                                groupValue: val,
                                onChanged: (value) {
                                  setState(() {
                                    val = value as int;
                                  });
                                },
                                activeColor: Colors.green,
                              ),
                            ),


                          ],
                        )),

                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: Text(
                      "     لغو     ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                    //  print(val.toString() + "___" + _data3.length.toString());
                    //  print(val.toString() + "__data_" + _data.length.toString());
                      _data3.clear();
                      _data3.addAll(_data);
                      if(val == 1) {
                        setState(() =>_data3.removeWhere((element) => !element.status.contains("فعال")) );
                      } else if(val == 2) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("تایید شد")) );
                        } else if(val == 3) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("نیاز به اصلاح")) );
                        } else if(val == 4) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("آماده تخصیص")) );
                        } else if(val == 5) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("درخواست ابطال")) );
                        } else if(val == 6) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("رد پرونده")) );
                        } else if(val == 7) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("نیاز به ثبت")) );
                        } else if(val == 8) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("مالیاتی")) );
                        } else if(val == 9) {
                          setState(() =>_data3.removeWhere((element) => element.status.contains("0")) );
                        } else if(val == 10) {
                          setState(() =>_data3.removeWhere((element) => !element.status.contains("بررسی")) );
                        } else if(val == 11) {
                          setState(() =>_data3.removeWhere((element) => !element.soeich.contains("ایران کیش")) );
                        } else if(val == 12) {
                          setState(() =>_data3.removeWhere((element) => !element.soeich.contains("پاسارگاد")) );
                        }
                     // print(val.toString() + "__====_" + _data3.length.toString());

                        this.setState(() {});
                      Navigator.pop(context);

                    },
                    child: Text(
                      "   تایید   ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
              ],
            );
          },
        );
      },
    );
  }

}

@immutable
class _ExpandingActionButton extends StatelessWidget {
  const _ExpandingActionButton({
    required this.directionInDegrees,
    required this.maxDistance,
    required this.progress,
    required this.child,
  });

  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi / 180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

@immutable
class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.onPressed,
    required this.icon,
  });

  final VoidCallback? onPressed;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: Colors.teal,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: theme.colorScheme.onSecondary,
      ),
    );
  }
}

@immutable
class ExpandableFab extends StatefulWidget {
  const ExpandableFab({
    super.key,
    this.initialOpen,
    required this.distance,
    required this.children,
  });

  final bool? initialOpen;
  final double distance;
  final List<Widget> children;

  @override
  State<ExpandableFab> createState() => _ExpandableFabState();
}

class _ExpandableFabState extends State<ExpandableFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _expandAnimation;
  bool _open = false;

  @override
  void initState() {
    super.initState();
    _open = widget.initialOpen ?? false;
    _controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      curve: Curves.fastOutSlowIn,
      reverseCurve: Curves.easeOutQuad,
      parent: _controller,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          _buildTapToCloseFab(),
          ..._buildExpandingActionButtons(),
          _buildTapToOpenFab(),
        ],
      ),
    );
  }

  Widget _buildTapToCloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.hardEdge,
          elevation: 4.0,
          child: InkWell(
            onTap: _toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
    i < count;
    i++, angleInDegrees += step) {
      children.add(
        _ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: _expandAnimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

  Widget _buildTapToOpenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            onPressed: _toggle,
            child: const Icon(Icons.add_box_outlined),
          ),
        ),
      ),
    );
  }
}