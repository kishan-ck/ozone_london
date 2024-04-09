// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ozone_london/constant/colors.dart';

AppBar commonAppBar() {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: backgroundColor,
    elevation: 0,
    centerTitle: false,
    title: SvgPicture.asset(
      "assets/images/ic_logo_dark.svg",
      width: 200,
    ),
    actions: [
      IconButton(
          onPressed: () {},
          icon: FaIcon(
            FontAwesomeIcons.bell,
            color: iconColor,
          ))
    ],
  );
}
