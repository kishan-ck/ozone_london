// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';

Widget loadingWidget() {
  return Container(
    color: Colors.black26,
    child: Center(
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: CircularProgressIndicator(
          color: primaryBlackColor,
        ),
      ),
    ),
  );
}
