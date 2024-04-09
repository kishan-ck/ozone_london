// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';

void orderReturnBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    // constraints:
    //     BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.only(
        topStart: Radius.circular(25),
        topEnd: Radius.circular(25),
      ),
    ),
    builder: (context) {
      return Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: size.width(50),
              height: size.height(5),
              decoration: BoxDecoration(
                color: primaryBlackColor,
                borderRadius: BorderRadiusDirectional.circular(20),
              ),
            ),
            size.HeightSpace(15),
            Text(
              "free_shipping_and_returns".tr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            size.HeightSpace(15),
            Text(
              "Shipping cost is based on weight. Just add products to your cart and use the Shipping Calculator to see the shipping price.",
              style: TextStyle(color: textColor, fontSize: 18),
            ),
            size.HeightSpace(15),
            Text(
              "We want you to be 100% satisfied with your purchase. Items can be returned or exchanged within 30 days of delivery.",
              style: TextStyle(color: textColor, fontSize: 18),
            ),
          ],
        ),
      );
    },
  );
}
