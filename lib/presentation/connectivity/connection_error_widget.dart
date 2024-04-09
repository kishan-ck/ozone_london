// ignore_for_file: deprecated_member_use, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';

class InternetError extends StatefulWidget {
  const InternetError({Key? key}) : super(key: key);

  @override
  State<InternetError> createState() => _InternetErrorState();
}

class _InternetErrorState extends State<InternetError> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                size.HeightSpace(25),
                Image.asset(
                  'assets/images/ic_network_error.jpg',
                  fit: BoxFit.cover,
                ),
                size.HeightSpace(25),
                Text(
                  'network_error'.tr,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: primaryBlackColor),
                ),
                size.HeightSpace(25),
                Text(
                  'network_error_description'.tr,
                  style: TextStyle(fontSize: 16, color: textColor),
                  textAlign: TextAlign.center,
                ),
                size.HeightSpace(25),
                AppButton(
                  buttonText: "try_again".tr,
                  onPressed: () {},
                )
              ])),
    );
  }
}
