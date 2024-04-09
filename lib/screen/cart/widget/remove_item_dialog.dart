// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class RemoveItemDialog extends StatelessWidget {
  final Function()? removeOnPress;
  final String productName;

  const RemoveItemDialog({
    super.key,
    this.removeOnPress,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Remove Item',
            style: TextStyle(
                color: primaryBlackColor,
                fontSize: 23,
                fontWeight: FontWeight.w600),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: RichText(
              text: TextSpan(
                text: 'Are you sure you want to remove ',
                style: TextStyle(
                    fontFamily: "Jost",
                    color: primaryBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
                children: <TextSpan>[
                  TextSpan(
                    text: productName,
                    style: TextStyle(
                      fontFamily: "Jost",
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.8),
                      fontSize: 18,
                    ),
                  ),
                  TextSpan(
                    text: ' from the cart?',
                    style: TextStyle(
                        fontFamily: "Jost",
                        color: primaryBlackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          size.HeightSpace(40),
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
                onPressed: removeOnPress,
                child: Center(
                    child: Text(
                  "Remove".tr,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                )),
              ),
            ],
          ),
          size.HeightSpace(20),
        ],
      ),
    );
  }
}
