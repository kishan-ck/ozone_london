// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/screen/auth/sign_in_screen.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  const SignOutConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "log_out?".tr,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: primaryBlackColor),
          ),
          size.HeightSpace(10),
          Text(
            "are_you_sure_want_to_logout".tr,
            style: TextStyle(fontSize: 16, color: textColor),
          ),
          size.HeightSpace(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: primaryBlackColor),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  "cancel".tr,
                  style: TextStyle(
                      color: primaryBlackColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
                onPressed: () {
                  Get.back();
                },
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryBlackColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: Center(
                    child: Text(
                  "log_out".tr,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
                onPressed: () {
                  getStorage.remove("token");
                  Get.offAll(SignInScreen());
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
