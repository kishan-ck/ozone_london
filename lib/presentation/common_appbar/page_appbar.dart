// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';

AppBar commonPageAppBar({required String title, bool isNotification = true}) {
  return AppBar(
    backgroundColor: backgroundColor,
    elevation: 0,
    title: Text(
      title,
      style: TextStyle(color: primaryBlackColor),
    ),
    leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back,
          color: iconColor,
        )),
    actions: [
      isNotification
          ? IconButton(
              onPressed: () {},
              icon: FaIcon(
                FontAwesomeIcons.bell,
                color: iconColor,
              ))
          : SizedBox()
    ],
  );
}
