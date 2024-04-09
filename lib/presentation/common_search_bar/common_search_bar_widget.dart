// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';

class CommonSearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChange;

  const CommonSearchBarWidget(
      {Key? key, required this.controller, this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(12), boxShadow: [
        BoxShadow(offset: Offset(0, 0), color: shadowColor, blurRadius: 3),
      ]),
      child: appTextField(
          onChanged: onChange,
          prefixIcon: Icon(
            Icons.search_rounded,
            color: textColor,
          ),
          hintTextStyle: TextStyle(color: textColor),
          textEditingController: controller,
          hintText: 'what_are_you_looking_for'.tr),
    );
  }
}
