// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class FreeShippingWidget extends StatelessWidget {
  const FreeShippingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundCardColor,
      padding: EdgeInsets.all(10),
      alignment: AlignmentDirectional.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("🔥"),
          size.WidthSpace(5),
          Text(
            "These products are limited, checkout within",
            style: TextStyle(fontSize: 14, color: primaryBlackColor),
          )
        ],
      ),
    );
  }
}
