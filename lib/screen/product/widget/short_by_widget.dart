// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_list_controller.dart';

void shortByBottomSheet(
    BuildContext context, ProductListController controller) {
  showModalBottomSheet(
    context: context,
    backgroundColor: backgroundColor,
    constraints:
        BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 1.2),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'short_by'.tr,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlackColor),
                ),
                GestureDetector(
                  child: Text(
                    'cancel'.tr,
                    style: TextStyle(fontSize: 18, color: textColor),
                  ),
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ),
            size.HeightSpace(15),
            Container(
              height: 200,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Text(
                      controller.shortByList[index],
                      style: TextStyle(fontSize: 18, color: primaryBlackColor),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return size.HeightSpace(20);
                  },
                  itemCount: controller.shortByList.length),
            )
          ],
        ),
      );
    },
  );
}
