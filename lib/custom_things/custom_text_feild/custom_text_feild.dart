import 'package:flutter/material.dart';

class CustomTextFeild extends StatelessWidget {
  //const CustomTextFeild({Key? key}) : super(key: key);

  String? hintText;
  TextEditingController? controller;
  bool obscureText = false;
  TextInputType? textInputType;
  IconButton? suffixIcon;
  dynamic validator;

  CustomTextFeild(
      {this.textInputType,this.suffixIcon,this.hintText, this.controller, required this.obscureText, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: TextStyle(
        color: Color(0xFF6F7471),
      ),
      obscureText: obscureText,
      validator: validator,
      keyboardType: textInputType,
      cursorColor: Color(0xFF6F7471),
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          color: Color(0xFFBFC0C0),
        ),
        filled: true,
        fillColor: Color(0xFFFBFBFC),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.2,
            color: Color(0xFF22A45D),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 0.5,
            color: Color(0xFF22A45D),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.2,
            color: Color(0xFF22A45D),
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            width: 1.2,
            color: Color(0xFF22A45D),
          ),
        ),
      ),
    );
  }
}
