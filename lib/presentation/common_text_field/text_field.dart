// ignore_for_file: prefer_conditional_assignment, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

Widget appTextField({
  FormFieldValidator<String>? validation,
  bool? isReadOnly,
  bool? isPassword,
  String? hintText,
  Function()? suffixClick,
  TextInputType? inputType,
  Function()? onTap,
  Widget? suffixIcon,
  EdgeInsets? contentPadding,
  TextStyle? hintTextStyle,
  Widget? prefixIcon,
  int? maxLines,
  Function(String)? onChanged,
  required TextEditingController textEditingController,
}) {
  if (isReadOnly == null) isReadOnly = false;
  if (isPassword == null) isPassword = false;
  return TextFormField(
      cursorColor: primaryBlackColor,
      keyboardType: inputType,
      controller: textEditingController,
      readOnly: isReadOnly,
      maxLines: maxLines,
      onTap: onTap,
      obscureText: isPassword,
      onChanged: onChanged,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: whiteColor,
          prefixIcon: prefixIcon,
          contentPadding: contentPadding ??
              EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          hintStyle: hintTextStyle,
          // errorStyle: errorTextfieldStyle,
          suffixIcon: suffixIcon,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12)),
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(12))),
      validator: validation);
}
