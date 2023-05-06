
// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:persian_number_utility/src/extensions.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';
import 'package:sima_portal/a_sima_app/models/agentModel.dart';
import 'package:sima_portal/a_sima_app/models/usersModel.dart';
import 'package:sima_portal/a_sima_app/services/online_services.dart';
import 'dart:ui';


import 'components/Styles.dart';

class transfer_page extends StatefulWidget {
  List<AgentModel> _data = [];
  transfer_page(this._data);@override
  State<StatefulWidget> createState() => infoState();}

class infoState extends State<transfer_page> with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _key ="0";
  final _key2 = GlobalKey<FormFieldState>();
  bool loading = false;
  late String today = "";
  late String datetime = "";

  late Map response;
  List<UserModel> _data1 = [];
  List<UserModel> _data2 = [];
  bool isFree = false;
  List<String> _users = [];
  String _Users = "کاربران";
 late double balance;

  Future<String> getBalance() async {
    String response = await OnlineServices.getBalance2(
        {
          "agentcode": widget._data.last.agentCode,
          "usercode": widget._data.last.userCode
          // "agentcode": "10004",
          // "usercode": "0"
        });
    balance = double.parse(response.toString().replaceAll(",", ""));
    return response;
  }

  void getUserList() async {
    Map response = await OnlineServices.getUserList({"agentcode" : widget._data.last.agentCode,"usercode" : widget._data.last.userCode});
    _data1.clear();
    _users.clear();
    _data1.addAll(response['data']);

    for (int i = 0 ; i< _data1.length ; i++)
    {
     // print("___${_data1[i].code}___");
   //   print("___${widget._data.last.userCode}___");
      if(_data1[i].code != widget._data.last.userCode)
      _users.add(_data1[i].name + "-" + _data1[i].code);
    }
    setState(() {});

  }

  int i = 0;
  @override
  void initState()  {
    getUserList();
    super.initState();
  }

  void transfer() async {
    
    
    
    
    String datetime ="";
  //  print(_Users);
    String response = await OnlineServices.transfer(
        {
          "agentcode": widget._data.last.agentCode,
          "usercodesen": widget._data.last.userCode,
          "usercoderec": _Users.split("-")[1],
          "money": _key2.currentState!.value.toString(),
          "tarikh" : today.toString().replaceAll("/", "-") ,
          "saat" : datetime.toString()
        });
    response == "0" ? _showDialog(context, "انتقال اعتبار با موفقیت انجام شد")
        : _showDialog(context, "مبلغ انتقال نباید کمتر از 100.000 تومان باشد");
   // print( response);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;
    var blockSize = size.width / 100;
    double appBarHeight = AppBar().preferredSize.height;
    double mainHeight = size.height - appBarHeight;
    double itemHeight = mainHeight * .45;
    double itemWidth = size.width * .45;
    double h = .13;
    Color bcTextColor = Color(0x22000000);
    Color textColor = Color(0xbb000000);
    return SafeArea(child: Scaffold(
      appBar: PreferredSize(preferredSize: Size.fromHeight(Comp.appBarHeight) ,child: Comp.app_bar("انتقال اعتبار","", Icons.edit, (){})),

      key: _scaffoldKey,
        backgroundColor: Color(0xffffffff),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 10,),
              Image.asset("assets/images/transfer.jpg",height: size.height * .3,),
              Container(
                padding: EdgeInsets.only(top: 10),
                alignment: Alignment.center,
             //   height: size.height * .3,
             //   width: size.width,
                color: Color(0x00ffffff),
                child: Container(
                  padding: EdgeInsets.all(20),
                //  height: size.height * .3 * .8,
                //  width: size.width * .85,

                  decoration: BoxDecoration(
                    color: Color(0xaaffffff),
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("موجودی", style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 23),),
                        SizedBox(width: 10,),
                        FutureBuilder<String>(future: getBalance(),
                          builder: (context, AsyncSnapshot<String> snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!.toPersianDigit() + " ریال",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 35),);
                            } else if (snapshot.hasError) {return Container();} else return Container();},)
                      ],
                    ),



                  ],),
                ),
              ),
              Container(
                //  height: 50,
                decoration: BoxDecoration(
                    color: Color(0x22000000),
                    borderRadius: BorderRadius.all(Radius.circular(17))
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: 35, left: 35, bottom: 6,top: 25),
                width: size.width,
                padding: EdgeInsets.only(right: 60,left: 20,top: 10,bottom: 10),
                child:  SearchableDropdown.single(
                  style: TextStyle(color: Colors.black),
                  items: _users.map((String val) {
                    return DropdownMenuItem<String>(
                      value: val,
                      child: Text(val,style: TextStyle(fontSize: 15),),
                    );
                  }).toList(),
                  underline: Container(),
                  // value: ,
                  hint: Text(_Users == null ? "" : _Users ),
                  searchHint: "انتخاب کاربر",
                  onChanged: (value) {
                    if(value != null)
                    {
                      //    print("___");
                      _key = value;
                      _Users = value;
                    }
                    else
                    {
                      //    print("__++++++_");

                      _key = "0";
                      _Users = "0";
                    }
                    setState(() {});
                  },
                  isExpanded: true,
                ),),
              Container(
                decoration: BoxDecoration(
                    color: bcTextColor,
                    borderRadius: BorderRadius.all(Radius.circular(17))
                ),
                margin: EdgeInsets.only(right: 35, left: 35, bottom: 6,top: 8),
                padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                child:  TextFormField(
                  key: _key2,
                  keyboardType: TextInputType.number,
                  obscureText: false,
                  //    initialValue: "22222",
                  style: const TextStyle(
                    color: Color(0xbb000000),
                  ),
                  decoration:  InputDecoration(
                      border: InputBorder.none,
                      icon:  Icon(
                        Icons.monetization_on_outlined ,
                        color: textColor,
                        size: 25,
                      ),
                      hintText: "مبلغ (ریال)",
                      hintStyle: const TextStyle(color: Color(0x55000000) , fontSize: 16),
                      contentPadding: const EdgeInsets.only(
                          top: 11 , right: 0 , bottom: 10 , left: 5
                      )
                  ),
                ),
              ),
              ElevatedButton(onPressed: (){
               // balance = balance.toStringAsFixed(0);
              //  print("___${balance.toStringAsFixed(0)}_______${_key2.currentState!.value.toString()}______");
                if (_key.length > 1 && _key2.currentState!.value.toString().length > 0)
                {if(balance < double.parse(_key2.currentState!.value.toString()))
                  _showDialog(context, "مبلغ انتقال بیشتر از میزان موجودی شما است");
                else transfer();}

                else Comp.showSnack(context, Icons.adjust, "لطفا کاربر و یا مبلغ مورد نظر را وارد کنید");


              },
                child: Text("انتقال اعتبار ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),) , )

            ],
          ),
        ),
    ),
    );
  }

  void _showDialog(BuildContext context, String txt) async{
       var size = MediaQuery.of(context).size;
    showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration( borderRadius: BorderRadius.all(Radius.circular(18)) ),
          child: AlertDialog(
            title: Text(txt,textAlign: TextAlign.right,),

            actions: <Widget>[
              Row(
                children: [
                  ElevatedButton(onPressed: (){Navigator.pop(context);},
                      child: Text("تایید",style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16),)),],
              )
            ],
          ),
        );
      },
    );
  }

}