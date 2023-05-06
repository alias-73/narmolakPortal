
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class alarm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<alarm> {
  bool bc = false;
  Future _deleteImageFromCache() async {
    String url = "http://194.33.125.128:80/Portal/pos/notif-main/alarm.jpg";
    await CachedNetworkImage.evictFromCache(url);
  }
  @override
  void initState() {
    _deleteImageFromCache();
    Future.delayed(Duration(seconds: 14), (){bc=true;});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deleteImageFromCache();

    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return WillPopScope(
        onWillPop: () async{
      return bc;
    },
    child: Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: CachedNetworkImage(
          imageUrl: "http://194.33.125.128:80/Portal/pos/notif-main/alarm.jpg",
          placeholder: (context, url) =>
              Center(child: Text("لطفا کمی صبر کنید . . . ")),
          errorWidget: (context, url, error) =>
              Image.asset("assets/images/empty.png"),
        )
      ),
    ));
  }}