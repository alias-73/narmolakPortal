
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import 'components/Styles.dart';

class errorPage extends StatefulWidget {
late String txt;
errorPage(this.txt);
  @override
  State<StatefulWidget> createState() => pageState();

}

class pageState extends State<errorPage> {

  @override
  void initState() {
    _deleteImageFromCache();
    super.initState();
  }
  Future _deleteImageFromCache() async {
    String url = "http://194.33.125.128:80/Portal/pos/fix/fix.jpg";
    await CachedNetworkImage.evictFromCache(url);
  }


  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication, )) {
      // if (!await launchUrl(Uri.parse(url),webViewConfiguration: const WebViewConfiguration(enableDomStorage: false), )) {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var size = MediaQuery.of(context).size;

    return SafeArea(child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/appbar_logo.png",height: size.height * .2,width: size.width),

            CachedNetworkImage(
              height: size.height * .3,
              width: size.width,
              // fit: BoxFit.fitHeight,
              imageUrl: "http://194.33.125.128:80/Portal/pos/fix/fix.jpg",
              placeholder: (context, url) =>
                  Container(alignment: Alignment.center,height: size.height * .3,width: size.width),
              errorWidget: (context, url, error) =>
                  Image.asset("assets/images/appbar_logo.png",height: size.height * .3,width: size.width,fit: BoxFit.cover,),
            ),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),child: Text(textAlign: TextAlign.center,
          widget.txt.split(",")[1],
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black,
            fontSize: 22.0,
          ),
        ),),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10),child: ElevatedButton(onPressed:() {
          Comp.show_short_info("این امکان در نسخه دمو فعال نمیباشد");
          // _launchUrl("http://sima-pay.com/goftino.html?txt=${00000}*Alias*${09999999999}");
        }, child: Row(mainAxisAlignment: MainAxisAlignment.center,children: [
          Text("ارتباط با پشتیبانی",style: TextStyle(fontSize: 20),),
          SizedBox(width: 40,),
          Icon(Icons.support_agent_outlined,size: 30,)
        ],)),),

       
          ],
        ),
      ),
    ));
  }}