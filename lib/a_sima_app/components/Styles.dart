import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';

import '../../shimmer.dart';
import '../../snackbar/src/animated_snack_bar.dart';
import '../../snackbar/src/types.dart';

class Comp {
  late String agent;
  late String user;
  static double appBarHeight = AppBar().preferredSize.height;

  static Widget app_bar(String title, String img, IconData icon, Function f) {
    return img.length > 0
        ? AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: TextStyle(color: Colors.black)),
                SizedBox(
                  width: 10,
                ),
                Image(
                  image: AssetImage(img),
                  height: 50,
                )
              ],
            ),
          )
        : AppBar(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              title,
              style: TextStyle(color: Colors.black),
            ),
          );
  }

  static Widget editBox1(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    Color cl2 = Colors.red;
    return Container(
      margin: label == "شرح"
          ? EdgeInsets.only(left: 20, right: 20, top: 13)
          : EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 200 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        maxLines: label == "آدرس"
            ? 3
            : label == "شرح"
                ? 5
                : 1,
        textAlign: label == "شرح" ? TextAlign.right : TextAlign.center,
        key: key,
        style: TextStyle(
            color: cl,
            fontWeight: label == "شرح" ? FontWeight.w400 : FontWeight.w800),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: label == "شرح" ? EdgeInsets.all(8) : EdgeInsets.zero,

          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl2)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox2(
      BuildContext context,
      int keyType,
      int max2,
      int max1,
      String label2,
      String label1,
      IconData ic,
      Key key2,
      Key key1,
      String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * .5,
          margin: EdgeInsets.only(right: 30, top: 10),
          child: TextFormField(
            maxLength: max1 == 0 ? 100 : max1,
            textInputAction: TextInputAction.next,
            initialValue: initial,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key1,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: Icon(
                ic,
                color: cl,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label1,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
        Container(
          width: size.width * .33,
          margin: EdgeInsets.only(left: 30, top: 13),
          child: TextFormField(
            maxLength: max2 == 0 ? 100 : max2,
            textInputAction: TextInputAction.next,
            initialValue: initial,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key2,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.only(right: 10),
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label2,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget editBox3(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox4(BuildContext context, String label2, String label1,
      IconData ic, String initial2, String initial1) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * .5,
          margin: EdgeInsets.only(right: 30, top: 13),
          child: TextFormField(
            enabled: false,
            textInputAction: TextInputAction.next,
            initialValue: initial2,
            cursorColor: cl,
            textAlign: TextAlign.center,
            style: TextStyle(color: cl, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: Icon(
                ic,
                color: cl,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w600),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label1,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
        Container(
          width: size.width * .33,
          margin: EdgeInsets.only(left: 30, top: 10),
          child: TextFormField(
            enabled: false,
            textInputAction: TextInputAction.next,
            initialValue: initial1,
            cursorColor: cl,
            textAlign: TextAlign.center,
            style: TextStyle(color: cl, fontWeight: FontWeight.w600),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w600),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label2,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget editBox5(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    //print (initial);
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        maxLength: max == 0 ? 100 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        textAlign: TextAlign.center,
        key: key,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox6(
      BuildContext context,
      int keyType,
      int max2,
      int max1,
      String label2,
      String label1,
      IconData ic,
      Key key2,
      Key key1,
      String initial1,
      String initial2) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * .5,
          margin: EdgeInsets.only(right: 30, top: 13),
          child: TextFormField(
            maxLength: max1 == 0 ? 100 : max1,
            textInputAction: TextInputAction.next,
            initialValue: initial1,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key1,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: Icon(
                ic,
                color: cl,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label1,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
        Container(
          width: size.width * .33,
          margin: EdgeInsets.only(left: 30, top: 10),
          child: TextFormField(
            maxLength: max2 == 0 ? 100 : max2,
            textInputAction: TextInputAction.next,
            initialValue: initial2,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key2,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.only(right: 10),

              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label2,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget editBox7(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial, Function f) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 100 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        textAlign: TextAlign.center,
        key: key,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          counterText: "",
          icon: FloatingActionButton(
            child: Icon(Icons.refresh),
            backgroundColor: Colors.teal,
            onPressed: () {
              f();
              //   print(_psp_value);
              // Future.delayed(const Duration(milliseconds: 1000), () { f(); });
              // setState(() {});
            },
            mini: true,
          ),
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox8(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          prefixIcon: initial.contains("سداد")
              ? Padding(
                  child: Image.asset(
                    "assets/images/sadad.png",
                    height: 60,
                    width: 60,
                  ),
                  padding: EdgeInsets.only(right: 15),
                )
              : initial==("به پرداخت")
                  ? Padding(
                      child: Image.asset(
                        "assets/images/behpardakht.png",
                        height: 60,
                        width: 60,
                      ),
                      padding: EdgeInsets.only(right: 15),
                    )
              : initial.contains("پرداخت نوین") ? Padding(child: Image.asset(
                        "assets/images/novin.png",
                        height: 60,
                        width: 60,
                      ), padding: EdgeInsets.only(right: 15),)
              : initial.contains("سپهر") ? Padding(child: Image.asset(
                        "assets/images/sepehr.png",
                        height: 60,
                        width: 60,
                      ), padding: EdgeInsets.only(right: 15),)
                  : initial.contains("پاسارگاد")
                      ? Padding(
                          child: Image.asset(
                            "assets/images/pasargad.png",
                            height: 60,
                            width: 60,
                          ),
                          padding: EdgeInsets.only(right: 15),
                        )
                      : initial.contains("ایران")
                          ? Padding(
                              child: Image.asset(
                                "assets/images/irankish.png",
                                height: 60,
                                width: 60,
                              ),
                              padding: EdgeInsets.only(right: 15),
                            )
                          : Icon(
                              Icons.apps,
                              color: cl,
                            ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          // contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox9(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox9_1(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox10(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    // print("__________________${initial}______________________");
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          prefixIcon: initial.contains("Typical")
              ? Icon(
                  Icons.phone,
                  color: cl,
                )
              : initial.contains("GPRS")
                  ? Icon(
                      Icons.wifi,
                      color: cl,
                    )
                  : initial.contains("LAN")
                      ? Icon(
                          Icons.cable,
                          color: cl,
                        )
                      : Icon(Icons.cable),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox11(
      BuildContext context, String label, IconData ic, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    // print("__________________${initial}______________________");
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,

          prefixIcon: Container(
              padding: EdgeInsets.only(right: 10),
              // height: size.height * .08,
              child: FutureBuilder<String>(
                future: getImgBank(initial),
                builder: (context, AsyncSnapshot<String> snapshot) {
                  if (snapshot.hasData) {
                    return CachedNetworkImage(
                      height: 23,
                      width: 23,
                      // fit: BoxFit.fitHeight,
                      imageUrl: snapshot.data!.toString(),
                      placeholder: (context, url) => Container(
                        height: 23,
                        width: 23,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/Markazi.jpg",
                        height: 23,
                        width: 23,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Container();
                  } else
                    return Container();
                },
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox12(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    Color cl2 = Colors.red;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 100 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        maxLines: label == "آدرس" ? 3 : 1,
        textAlign: TextAlign.center,
        key: key,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          //counterText: "",
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl2)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox13(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    Color cl2 = Colors.red;
    RegExp regexp = RegExp(
      r"^|\-|\,|\ ",
    );
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        inputFormatters: [
          // FilteringTextInputFormatter.allow(RegExp(r"^|\-|\,|\ ")),
          //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z0-9]+")),
          FilteringTextInputFormatter.allow(RegExp("[@!_*a-z0-9]+")),
        ],
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 100 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        maxLines: label == "آدرس" ? 3 : 1,
        textAlign: TextAlign.center,
        key: key,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl2)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Widget editBox14(
      BuildContext context,
      int keyType,
      int max2,
      int max1,
      String label2,
      String label1,
      IconData ic,
      Key key2,
      Key key1,
      String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: size.width * .42,
          margin: EdgeInsets.only(right: 30, top: 10),
          child: TextFormField(
            maxLength: max1 == 0 ? 100 : max1,
            textInputAction: TextInputAction.next,
            initialValue: initial,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key1,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              prefixIcon: Icon(
                ic,
                color: cl,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label1,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
        Container(
          width: size.width * .42,
          margin: EdgeInsets.only(left: 30, top: 13),
          child: TextFormField(
            maxLength: max2 == 0 ? 100 : max2,
            textInputAction: TextInputAction.next,
            initialValue: initial,
            keyboardType:
                keyType == 1 ? TextInputType.text : TextInputType.number,
            cursorColor: cl,
            textAlign: TextAlign.center,
            key: key2,
            style: TextStyle(color: cl, fontWeight: FontWeight.w800),
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: cl,
                  width: 1.0,
                ),
              ),
              fillColor: cl,
              focusColor: cl,
              hoverColor: cl,
              contentPadding: EdgeInsets.zero,
              //errorText: _errorText1,
              labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),

              labelText: label2,
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: cl)),
              // errorText: 'Error message',
              border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
            ),
          ),
        ),
      ],
    );
  }

  static Widget editBox15(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    Color cl2 = Colors.red;
    return Container(
      margin: EdgeInsets.only(left: 0, right: 0, top: 13),
      child: TextFormField(
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 200 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        textAlign: label == "شرح" ? TextAlign.right : TextAlign.center,
        key: key,
        style: TextStyle(
            color: cl,
            fontWeight: label == "شرح" ? FontWeight.w400 : FontWeight.w800),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Icon(
            ic,
            color: cl,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: label == "شرح" ? EdgeInsets.all(8) : EdgeInsets.zero,

          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl2)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }


  static Widget editBoxCustom(BuildContext context, String label,
      String initial, int max, Key key, double width) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      width: width,
      margin: EdgeInsets.only(left: 30, top: 13),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        initialValue: initial,
        cursorColor: cl,
        key: key,
        maxLength: max,
        textAlign: TextAlign.center,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(right: 10),

          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          //contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static Future<String> getImgBank(String name) async {
    String response = await OnlineServices.getImgBank({"bank": name});
    //print (await response);
    return response;
  }

  static Future<String> getPrefs(String key) async {
    String value = "---";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    value = await prefs.getString(key)!;
    // if(key == _key14) _key14 = value; else if(key == _key15) _key15 = value;
    //  print("value: " + value);
    return value;
  }

  static Widget editBoxIran(BuildContext context, int keyType, int max,
      String label, IconData ic, Key key, String initial) {
    var size = MediaQuery.of(context).size;
    Color cl = Colors.black;
    return Container(
      margin: EdgeInsets.only(left: 30, right: 30, top: 13),
      child: TextFormField(
        enabled: initial.length > 0 ? false : true,
        maxLength: max == 0 ? 100 : max,
        textInputAction: TextInputAction.next,
        initialValue: initial,
        keyboardType: keyType == 1 ? TextInputType.text : TextInputType.number,
        cursorColor: cl,
        textAlign: TextAlign.center,
        key: key,
        style: TextStyle(color: cl, fontWeight: FontWeight.w800, fontSize: 30),
        decoration: InputDecoration(
          counterText: "",
          prefixIcon: Image.asset(
            "assets/images/iranflag.png",
            height: 80,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: cl,
              width: 1.0,
            ),
          ),
          fillColor: cl,
          focusColor: cl,
          hoverColor: cl,
          contentPadding: EdgeInsets.zero,
          //errorText: _errorText1,
          labelStyle: TextStyle(color: cl, fontWeight: FontWeight.w800),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),

          labelText: label,
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: cl)),
          // errorText: 'Error message',
          border: OutlineInputBorder(borderSide: BorderSide(color: cl)),
        ),
      ),
    );
  }

  static showSnack2(BuildContext context, IconData ic, String title) {
    title == "0" ? title = "لطفا مقادیر را بصورت صحیح وارد کنید" : Null;
    Color cl = Color(0xff000000);
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0x00fac80a),
        content: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          //   height: size.height * .15,
          child: Row(
            children: [
              Icon(
                ic,
                color: cl,
              ),
              SizedBox(width: 6),
              Text(
                title,
                style: TextStyle(
                    color: cl, fontSize: 14, fontWeight: FontWeight.w600),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xfffac80a),
            borderRadius: BorderRadius.all(Radius.circular(17)),
            //  image: DecorationImage(image: AssetImage("assets/images/replace.png"))
          ),
        )));
  }

  static showSnack(BuildContext context, IconData ic, String title) {
    title == "0" ? title = "لطفا مقادیر را بصورت صحیح وارد کنید" : Null;
    Color cl = Color(0xff000000);
    // ScaffoldMessenger.of(context).removeCurrentSnackBar();
    AnimatedSnackBar.material(
      title,
      type: AnimatedSnackBarType.error,
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static showSnackError2(BuildContext context) {
    Color cl = Colors.black;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0x00ffffff),
        content: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          //   height: size.height * .15,
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: cl,
              ),
              SizedBox(width: 6),
              Text(
                "لطفا مقادیر را بصورت صحیح وارد کنید",
                style: TextStyle(
                    color: cl, fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xfffac80a),
            borderRadius: BorderRadius.all(Radius.circular(17)),
            //  image: DecorationImage(image: AssetImage("assets/images/replace.png"))
          ),
        )));
  }

  static showSnackError(BuildContext context) {
    String title = "لطفا مقادیر را بصورت صحیح وارد کنید";
    AnimatedSnackBar.material(
      title,
      type: AnimatedSnackBarType.error,
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static showSnackEmpty2(BuildContext context) {
    Color cl = Colors.black;
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Color(0x00ffffff),
        content: Container(
          // alignment: Alignment.center,
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.symmetric(horizontal: 15),
          //   height: size.height * .15,
          child: Row(
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: cl,
              ),
              SizedBox(width: 6),
              Text(
                "اطلاعاتی برای نمایش وجود ندارد",
                style: TextStyle(
                    color: cl, fontSize: 12, fontWeight: FontWeight.w600),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Color(0xfffac80a),
            borderRadius: BorderRadius.all(Radius.circular(17)),
            //  image: DecorationImage(image: AssetImage("assets/images/replace.png"))
          ),
        )));
  }

  static showSnackEmpty(BuildContext context) {
    String title = "اطلاعاتی برای نمایش وجود ندارد";
    AnimatedSnackBar.material(
      title,
      type: AnimatedSnackBarType.info,
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static showSnackOK(BuildContext context, String txt) {
    AnimatedSnackBar.material(
      txt,
      type: AnimatedSnackBarType.success,
      desktopSnackBarPosition: DesktopSnackBarPosition.topCenter,
    ).show(context);
  }

  static Widget miniBtn1(BuildContext context, var size, String title, Color cl,
      Function f, int type) {
    Color cl = type == 1 ? Colors.teal : Colors.redAccent;
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          //padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 10),
          width: size.width * 0.4,
          height: size.height * .06,
          child: ElevatedButton(
              onPressed: () {
                type == 1 ? f() : Navigator.pop(context);
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 9)),
                  backgroundColor: MaterialStateProperty.all(cl)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 15)),
                  Icon(
                    type == 1 ? Icons.save_outlined : Icons.info_outline,
                    color: Colors.white,
                    size: 20,
                  )
                ],
              )),
        ));
  }

  static Widget miniBtn2(BuildContext context, var size, IconData icon,
      String title, Color cl, Function f) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          //padding: EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 10),
          width: size.width * 0.35,
          height: size.height * .06,
          child: ElevatedButton(
              onPressed: () {
                f();
              },
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 9)),
                  backgroundColor: MaterialStateProperty.all(cl)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(title,
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  Icon(
                    icon,
                    color: Colors.black,
                    size: 20,
                  )
                ],
              )),
        ));
  }

  static Widget fullBtn(var size, String title, IconData ic, Function f) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 10),
          width: size.width * 0.89,
          height: size.height * .06,
          child: ElevatedButton(
              onPressed: () {
                f();
              },
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.teal)),
              child: Stack(
                alignment: Alignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Align(
                    child: Icon(
                      ic,
                      color: Colors.white,
                      size: 30,
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              )),
        ));
  }

  static void show_short_info(String txt) {
    SmartDialog.show(builder: (_) {
      return FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topRight,
            child: Text(
              txt,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
          ));
    });
  }

  static void show_short_info2(double w, String txt) {
    SmartDialog.show(builder: (_) {
      return FittedBox(
          fit: BoxFit.fitWidth,
          child: Container(
            width: w * .7,
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.topRight,
            child: Text(
              txt,
              textAlign: TextAlign.right,
              style: TextStyle(color: Colors.white),
            ),
          ));
    });
  }

  static Widget fullBtn2(
      var size, String title, IconData ic, Function f, Color cl) {
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(top: 10),
          width: size.width * 0.89,
          height: size.height * .06,
          child: ElevatedButton(
              onPressed: () {
                f();
              },
              style:
                  ButtonStyle(backgroundColor: MaterialStateProperty.all(cl)),
              child: Stack(
                alignment: Alignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title,
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  Align(
                    child: Icon(
                      ic,
                      color: Colors.white,
                      size: 30,
                    ),
                    alignment: Alignment.centerRight,
                  )
                ],
              )),
        ));
  }

  static Widget loadingList_shimmer(double h, double w) {
    return SizedBox(
        width: w,
        height: h,
        child: Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Color(0xffffffff),
            highlightColor: Color(0xffe5e5e5),
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      margin: EdgeInsets.only(
                          bottom: 5, top: 10, right: 10, left: 10),
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          Column(children: [
                            ListTile(
                                title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  width: (w - 10) * .49,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [],
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

  static Widget loadingList_shimmer2(double h, double w) {
    return SizedBox(
        width: w,
        height: h,
        child: Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Color(0xffffffff),
            highlightColor: Color(0xffe5e5e5),
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      // height: 110,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Divider(thickness: .7, color: Color(0xff565656)),
                        ],
                      ));
                })));
  }

  static Widget loadingList_shimmer3(double h, double w) {
    return SizedBox(
        width: w,
        height: h,
        child: Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Color(0xffffffff),
            highlightColor: Color(0xffe5e5e5),
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(7),
                        color: Colors.white,
                      ),
                      width: double.infinity,
                      // height: 110,
                      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.transparent,
                                size: 20,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("-",
                                  style: TextStyle(
                                      color: Colors.transparent, fontSize: 13)),
                            ],
                          ),
                          Divider(thickness: .7, color: Color(0xff565656)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            //crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Expanded(
                                  child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Text("",
                                          style: TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 25,
                                      ),
                                      Flexible(
                                          child: Text("",
                                              style: TextStyle(
                                                  color: Colors.transparent,
                                                  fontSize: 13,
                                                  letterSpacing: .3))),
                                    ],
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.transparent,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text("",
                                          style: TextStyle(
                                              color: Colors.transparent,
                                              fontSize: 13,
                                              letterSpacing: .3)),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.transparent,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Flexible(
                                        child: Text("",
                                            style: TextStyle(
                                                color: Colors.transparent,
                                                fontSize: 13,
                                                letterSpacing: .3)),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                            ],
                          ),
                        ],
                      ));
                })));
  }

  static Widget loadingList_shimmer4(double h, double w) {
    return SizedBox(
        width: w,
        height: h,
        child: Shimmer.fromColors(
            direction: ShimmerDirection.rtl,
            baseColor: Color(0xffffffff),
            highlightColor: Color(0xffe5e5e5),
            child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      Container(
                          //   height: (size.height * .1) + 60,
                          alignment: Alignment.topRight,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          // height: 110,
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    //crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Flexible(
                                          child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.device_hub,
                                                color: Colors.transparent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(".",
                                                  style: TextStyle(
                                                    color: Colors.transparent,
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
                                                color: Colors.transparent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Flexible(
                                                  child: Text("k",
                                                      style: TextStyle(
                                                        color:
                                                            Colors.transparent,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.height,
                                                color: Colors.transparent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text("3",
                                                  style: TextStyle(
                                                      color: Colors.transparent,
                                                      fontSize: 13)),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.info_outline,
                                                color: Colors.transparent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text("c",
                                                  style: TextStyle(
                                                      color: Colors.transparent,
                                                      fontSize: 13)),
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
                                            height: h * .1,
                                            //  width: size.width - 20,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Image.asset(
                                                    "assets/images/pos3.png"),
                                              ],
                                            )),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          )),
                      Positioned(
                        child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.teal)),
                            child: Text("ترمینال")),
                        left: 20,
                        bottom: 8,
                      ),
                      Positioned(
                        child: RotatedBox(
                            quarterTurns: 2,
                            child: SvgPicture.asset(
                              "assets/images/arrow1.svg",
                              color: Colors.teal,
                              height: 53,
                            )),
                        right: 5,
                        bottom: 15,
                      )
                    ],
                  );
                })));
  }

  static Widget showLoading(double h, double w) {
    return Container(
      height: h,
      color: Color(0x7effffff),
      width: w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SpinKitThreeBounce(color: Color(0xffffa625)),
          ),
          Text("لطفا صبر کنید",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }




  static showDialog_(BuildContext context, String title, Widget w) {
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
                      textDirection: TextDirection.rtl, child: Text(title))
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
                                textDirection: TextDirection.rtl, child: w)));
                  },
                  child: Text(
                    "تایید",
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

  static Alert1(context, String title, String desc, type) {
    Alert(
      context: context,
      title: title,
      desc: desc,
      type: type == 1 ? AlertType.success : AlertType.error,
      alertAnimation: fadeAlertAnimation,
    ).show();
  }

  static Widget fadeAlertAnimation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Align(
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
