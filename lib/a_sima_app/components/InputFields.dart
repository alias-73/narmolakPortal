import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final validator;
  final onSaved;

  InputFieldArea({required this.hint ,required  this.obscure , required this.icon , this.validator , this.onSaved});


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size ;
    var blockSize = size.width / 100;

    double fontSize6 = blockSize * 6;
    double fontSize7 = blockSize * 7;
    Color errorColor = Color(0xffff846b);
  //  Color iconColor = Colors.black;
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(right: 10),
      margin: EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        color: Color(0x22000000),
        borderRadius: BorderRadius.all(Radius.circular(17))
      ),
      //color: Colors.blueGrey,
      child: TextFormField(
        validator: validator,
        onSaved: onSaved,
        obscureText: obscure,
        style: const TextStyle(
          color: Colors.black
        ),
        decoration: InputDecoration(
          icon: Icon(
            icon ,
            color: Colors.black,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.white
              )
          ),
          errorStyle: TextStyle(color : errorColor),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: errorColor
            )
          ),
          focusedErrorBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: errorColor
              )
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black , fontSize: 16),
          contentPadding: const EdgeInsets.only(
            top: 11 , right: 0 , bottom: 10 , left: 5
          )
        ),
      ),
    );
  }

}