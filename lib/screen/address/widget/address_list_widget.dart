// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class AddressListWidget extends StatelessWidget {
  final String userName;
  final String mobileNo;
  final String userAddress;
  final String userCity;
  final String userCountry;

  const AddressListWidget(
      {super.key,
      required this.userName,
      required this.mobileNo,
      required this.userAddress,
      required this.userCity,
      required this.userCountry});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 15, bottom: 15, right: 5),
        decoration: BoxDecoration(
            color: whiteColor,
            boxShadow: AppShadows.buttonBoxShadow,
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(userName,
                    style: TextStyle(fontSize: 18, color: primaryBlackColor)),
                TextButton(
                    style: ButtonStyle(
                        overlayColor: MaterialStatePropertyAll(Colors.black12)),
                    onPressed: () {},
                    child: Text(
                      "edit".tr,
                      style: TextStyle(color: primaryBlackColor),
                    ))
              ],
            ),
            Text("Primary",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: primaryBlackColor)),
            size.HeightSpace(4),
            Text(
              mobileNo,
              style: TextStyle(color: primaryBlackColor),
            ),
            size.HeightSpace(4),
            Text(userAddress, style: TextStyle(color: textColor, fontSize: 15)),
            Text(userCity, style: TextStyle(color: textColor, fontSize: 15)),
            Text(userCountry, style: TextStyle(color: textColor, fontSize: 15)),
          ],
        ));
  }
}
