// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Function() onPressed;
  final double horizontalPadding;

  const AppButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.horizontalPadding = 0.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
            vertical: size.height(15), horizontal: horizontalPadding),
        backgroundColor: primaryBlackColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set the border radius
        ),
      ),
      child: Center(
          child: Text(
        buttonText,
        style: TextStyle(
            color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
      )),
      onPressed: onPressed,
    );
  }
}
