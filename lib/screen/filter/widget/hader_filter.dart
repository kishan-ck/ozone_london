// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class HeaderFilter extends StatelessWidget {
  const HeaderFilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(15),
          child: Container(
              alignment: AlignmentDirectional.center,
              padding: EdgeInsetsDirectional.all(8),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: AppShadows.buttonBoxShadow,
                borderRadius: BorderRadiusDirectional.circular(10),
              ),
              child: Icon(Icons.clear, color: iconColor, size: 18)),
        ),
        Center(
          child: Text(
            'filter'.tr,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(width: size.width(20), height: size.height(20)),
      ],
    );
  }
}
