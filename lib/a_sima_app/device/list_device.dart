import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:sima_portal/a_sima_app/device/device-model.dart';
import 'package:sima_portal/a_sima_app/device/new_device.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import '../components/Styles.dart';
import 'deviceHistoryModel.dart';

class device_list extends StatefulWidget {
  List<AgentModel> _Agentdata = [];

  device_list(this._Agentdata);

  @override
  State<StatefulWidget> createState() => device_listState();
}

class device_listState extends State<device_list> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentPageIndex = 0;
  List<DeviceModel> _data = [];
  int i = 0;

  Color cl = const Color(0xff000000);
  List<String> arayTXT = [];

  bool isFree = false;
  List<DeviceModel> _data2 = [];
  late Map response;
  final _key1 = GlobalKey<FormFieldState>();
  final _key2 = GlobalKey<FormFieldState>();

  Future<String> getImg(String _brand_value, String _model_value) async {
    String response = await OnlineServices.getDeviceImg(
        {"brand": _brand_value, "model": _model_value});
    //print (await response);
    return response;
  }

  Future<List<DeviceModel>> _getData() async {
    i++;
    if (i < 2) {
      response = await OnlineServices.getDeviceList({
        "agentcode": widget._Agentdata.last.agentCode,
        "usercode": widget._Agentdata.last.userCode
      });

      if (response["data"] != "free") {
        _data.clear();
        _data.addAll(response['data']);
        _data2.addAll(response['data']);
        for (int i = 0; i < _data.length; i++) {
          if (_data[i].serial == "" || _data[i].serial == null)
            _data[i].serial = "خالی";
        }

        setState(() {});
      } else {
        isFree = true;
        Comp.showSnackEmpty(context);

        setState(() {});
      }
    }
    return _data;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    double fontSize4 = blockSize * 4;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight - 65;
    return Scaffold(
        floatingActionButton: widget._Agentdata[0].agentModel == "0"
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Directionality(
                              textDirection: TextDirection.rtl,
                              child: device_register_page(widget._Agentdata))));
                },
              )
            : Center(),
        backgroundColor: const Color(0xfff0f0f0),
        key: _scaffoldKey,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Comp.appBarHeight),
            child: Comp.app_bar("لیست دستگاه ها", "", Icons.edit, () {})),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                    padding: const EdgeInsets.only(right: 20),
                    width: size.width * .9,
                    child: TextFormField(
                      onChanged: (txt) {
                        if (txt.length > 0) {
                          _data.clear();
                          _data.addAll(response['data']);
                          for (int i = 0; i < _data.length; i++) {
                            if (_data[i].serial == "" ||
                                _data[i].serial == null)
                              _data[i].serial = "بدون نام";
                          }
                          _data.removeWhere((element) => !element.serial
                              .contains(txt.toUpperCase().toString()));
                          setState(() {});
                        } else {
                          _data.clear();
                          _data.addAll(response['data']);
                          setState(() {});
                        }
                      },
                      style: const TextStyle(
                        color: Color(0xbb000000),
                      ),
                      decoration: const InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          hintText: "جستجو (صفحه کلید باید انگلیسی باشد)",
                          hintStyle:
                              TextStyle(color: Color(0x55000000), fontSize: 16),
                          contentPadding: EdgeInsets.only(
                              top: 11, right: 0, bottom: 10, left: 5)),
                    )),
                Expanded(
                    child: FutureBuilder<List<DeviceModel>>(
                  future: _getData(),
                  builder:
                      (context, AsyncSnapshot<List<DeviceModel>> snapshot) {
                    // print("-----"+snapshot.data!.toString());
                    if (snapshot.hasData) {
                      //  List<News> _news2 = snapshot.data!;
                      return ListView.builder(
                          itemCount: _data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return buildList(context, index);
                            AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 575),
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: buildList(context, index),
                                ),
                              ),
                            );
                          });
                    } else if (snapshot.hasError) {
                      return Container();
                    } else
                      return Container();
                  },
                ))
              ],
            ),

            ///ناظ
            _data2.length < 1 && isFree == false
                ? Comp.loadingList_shimmer4(size.height, size.width)
                : Center()
          ],
        ));
  }

  Widget buildList(BuildContext context, int index) {
    var size = MediaQuery.of(context).size;
    var blockSize = size.width / 100;
    final primary = const Color(0xff000000);
    final secondary = const Color(0xff000000);
    return Container(
        //   height: (size.height * .1) + 60,
        alignment: Alignment.topRight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.white,
        ),
        width: double.infinity,
        // height: 110,
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Flexible(
                        child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.device_hub,
                              color: secondary,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(_data[index].brand,
                                style: TextStyle(
                                  color: primary,
                                  fontSize: 13,
                                )),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.drive_file_rename_outline,
                              color: secondary,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Flexible(
                                child: Text(_data[index].serial,
                                    style: TextStyle(
                                      color: primary,
                                      fontSize: 13,
                                    ))),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    )),
                    Flexible(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.height,
                              color: secondary,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(_data[index].model,
                                style: TextStyle(color: primary, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: secondary,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                _data[index].status.contains("تخصیص")
                                    ? "تخصیص شده"
                                    : _data[index].status,
                                style: TextStyle(color: primary, fontSize: 13)),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        // Image.asset("assets/images/empty.png", height: 50) ,
                      ],
                    )),
                    Flexible(
                      child: Container(
                          height: size.height * .1,
                          //  width: size.width - 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FutureBuilder<String>(
                                future: getImg(
                                    _data[index].brand, _data[index].model),
                                builder:
                                    (context, AsyncSnapshot<String> snapshot) {
                                  if (snapshot.hasData) {
                                    return CachedNetworkImage(
                                      imageUrl: snapshot.data!.toString(),
                                      placeholder: (context, url) =>
                                          Image.asset("assets/images/pos3.png"),
                                      errorWidget: (context, url, error) =>
                                          Image.asset("assets/images/pos3.png"),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Container();
                                  } else
                                    return Container();
                                },
                              ),
                              PopupMenuButton(
                                itemBuilder: (context) {
                                  var list = <PopupMenuEntry<Object>>[];

                                  _data[index].status.contains("آزاد")
                                      ? list.add(PopupMenuItem(
                                          child: txt("حذف  "),
                                          value: 2,
                                        ))
                                      : _data[index].status.contains("رد")
                                          ? list.add(PopupMenuItem(
                                              child: txt("حذف  "),
                                              value: 2,
                                            ))
                                          : const Center();

                                  _data[index].status.contains("آزاد")
                                      ? list.add(PopupMenuItem(
                                          child: txt("انتقال به انبار  "),
                                          value: 3,
                                        ))
                                      : Center();

                                  list.add(PopupMenuItem(
                                    child: txt("ترمینال  "),
                                    value: 1,
                                  ));

                                  list.add(PopupMenuItem(
                                    child: txt("تاریخچه  "),
                                    value: 4,
                                  ));

                                  return list;
                                },
                                onSelected: (value) {
                                  doo(value as int, index);
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                color: Colors.blueGrey,
                                child: Column(
                                  children: [
                                    _data[index].soeich == "پرداخت نوین"
                                        ? Image.asset(
                                            "assets/images/novin.png",
                                            height: 30,
                                          )
                                        : _data[index].soeich == "سپهر"
                                            ? Image.asset(
                                                "assets/images/sepehr.png",
                                                height: 30,
                                              )
                                            : _data[index].soeich == "سداد"
                                                ? Image.asset(
                                                    "assets/images/sadad.png",
                                                    height: 30,
                                                  )
                                                : _data[index].soeich ==
                                                        "به پرداخت"
                                                    ? Image.asset(
                                                        "assets/images/behpardakht.png",
                                                        height: 30,
                                                      )
                                                    : _data[index].soeich ==
                                                            "پاسارگاد"
                                                        ? Image.asset(
                                                            "assets/images/pasargad.png",
                                                            height: 30,
                                                          )
                                                        : _data[index].soeich ==
                                                                "ایران کیش"
                                                            ? Image.asset(
                                                                "assets/images/irankish.png",
                                                                height: 30,
                                                              )
                                                            : const Center(),
                                    const Text("عملیات"),
                                    const Icon(Icons.keyboard_arrow_down)
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              ],
            )
          ],
        ));
  }

  void doo(int value, int index) {
    if (value == 1) {
      terminal(_data[index].serial);
    } else if (value == 2) {
      _showDialog(_data[index].serial, _data[index].soeich);
    } else if (value == 3) {
      _transferDialog(index);
    } else if (value == 4) {
      getDeviceHistory(_data[index].serial, _data[index].soeich);
    }
  }

  void _transferDialog(int index) async {
    var size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Column(
                children: [
                  const Text(
                    "درخواست انتقال",
                    textAlign: TextAlign.center,
                  ),
                  const Divider(
                    thickness: 2,
                    color: Colors.black87,
                  )
                ],
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "کد نماینده"),
                          key: _key1,
                        )),
                    SizedBox(height: 20),
                    Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(hintText: "کد کاربر"),
                          key: _key2,
                        )),
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      //  transfer(_data2[index].serial, _data2[index].soeich);
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red)),
                    child: const Text(
                      "     لغو     ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),
                    )),
                ElevatedButton(
                    onPressed: () {
                      if (_key1.currentState!.value.isNotEmpty &&
                          _key2.currentState!.value.isNotEmpty) {
                        Navigator.pop(context);
                        transfer(_data2[index].serial, _data2[index].soeich);
                      } else {
                        Comp.showSnackError(context);
                      }
                      //  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: scan1(widget.Baste))));
                    },
                    child: const Text(
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

  Future transfer(String serial, String psp) async {
    String response = await (OnlineServices()).transferDevice({
      "serial": serial,
      "agentre": _key1.currentState?.value.toString(),
      "userre": _key2.currentState?.value.toString(),
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "psp": psp
    });
    String ter;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.contains("ok"))
      _showDialog3("درخواست انتقال با موفقیت انجام شد");
  }

  Future getDeviceHistory(String serial, String psp) async {
    String txt = "";
    arayTXT.clear();
    List<DeviceHistoryModel> _data = [];
    late Map response;
    response =
        await OnlineServices.getDeviceHistory({"serial": serial, "psp": psp});
    if (response["data"] != "free") {
      _data.clear();
      _data.addAll(response['data']);
      for (int i = 0; i < _data.length; i++) {
        txt += _data[i].title + "\n";
        txt += _data[i].desc + "     ";
        txt += _data[i].date + "\n";
        txt += _data[i].user;
        i != _data.length - 1 ? txt += "\n" + "- - - - - - - - -" + "\n" : "";
        arayTXT.add(txt);
      }
      _showDialog2(txt);
    } else
      _showDialog2("تاریخچه خالی است");
  }

  Future terminal(String serial) async {
    String response = await (OnlineServices()).getTerminal({"serial": serial});
    String temp = response.split(",")[0];

    String serialll = "";
    if (temp.contains("-")) {
      serialll = temp.split("-")[2] +
          "-" +
          temp.split("-")[1] +
          "-" +
          temp
              .split("-")[0]
              .replaceAll("\n", "")
              .replaceAll("\t", "")
              .replaceAll("\r", "");
    } else
      serialll = temp;

    String ter;
    response =
        response.replaceAll("\n", "").replaceAll("\r", "").replaceAll("\t", "");
    if (response.length < 5)
      ter = "ترمینالی پیدا نشد";
    else
      ter = "سریال: " +
          serialll +
          "\n" +
          "برند: " +
          response.split(",")[1] +
          "\n"
              "مدل: " +
          response.split(",")[2] +
          "\n" +
          "ترمینال: " +
          response.split(",")[3] +
          "\n"
              "فروشگاه: " +
          response.split(",")[4];
    _showDialog2(ter);
  }

  void _showDialog2(String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl, child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: home_page())));
                  },
                  child: const Text(
                    "           تایید           ",
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

  void _showDialog3(String txt) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Directionality(
                      textDirection: TextDirection.rtl, child: Text(txt))
                ],
              ),
            ),
            actions: <Widget>[
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    //    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Directionality(textDirection: TextDirection.rtl, child: appbar_home(widget._Agentdata))));
                  },
                  child: const Text(
                    "           تایید           ",
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

  Widget txt(String txt) {
    Color c = Colors.white;
    double s = 15;
    return Align(
      child: Column(
        children: [
          Text(txt,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: s, color: c)),
          const Divider(
            color: Colors.white,
            height: 2,
          )
        ],
      ),
      alignment: Alignment.centerRight,
    );
  }

  void _showDialog(String serial, String psp) {
    var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(18))),
          child: AlertDialog(
            title: const Text("آیا از حذف دستگاه اطمینان دارید؟",
                textAlign: TextAlign.right,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    fontSize: 16)),
            actions: <Widget>[
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(const Color(0xffff3b3b))),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "  خیر  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _deleteDevice(serial, psp);
                  },
                  child: const Text(
                    "  بلی  ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16),
                  )),
            ],
          ),
        );
      },
    );
  }

  void _deleteDevice(String serial, String psp) async {
    String response = await OnlineServices.deleteDevice({
      "agentcode": widget._Agentdata.last.agentCode,
      "usercode": widget._Agentdata.last.userCode,
      "serial": serial,
      "psp": psp,
    });
    if (response.contains("ok")) i = 0;
    setState(() {});
  }
}
