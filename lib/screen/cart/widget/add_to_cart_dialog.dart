// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class AddToCartDialog extends StatelessWidget {
  final String productName;
  final String image;

  const AddToCartDialog(
      {super.key, required this.productName, required this.image});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return Container(
          padding: EdgeInsets.only(top: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                productName,
                style: TextStyle(
                    color: primaryBlackColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                "added_to_your_cart".tr,
                style: TextStyle(
                    color: primaryBlackColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w300),
              ),
              size.HeightSpace(10),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(top: 10),
                height: size.height(200),
                width: size.width(200),
                decoration: BoxDecoration(
                    boxShadow: AppShadows.buttonBoxShadow,
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                child: CustomNetworkImage(
                  image: image,
                ),
              ),
              size.HeightSpace(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                          vertical: size.height(15),
                          horizontal: size.width(15)),
                      backgroundColor: backgroundColor,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: primaryBlackColor),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "view_cart".tr,
                      style: TextStyle(
                          color: primaryBlackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
                    onPressed: () {
                      Get.back();
                      Get.find<CartController>().cartOrderSummary();
                      Get.offAll(CustomBottomNavigationBar(index: 3));
                      controller.update();
                    },
                  ),
                  AppButton(
                      horizontalPadding: 15.0,
                      buttonText: "continue_shopping".tr,
                      onPressed: () {
                        Get.back();
                        Get.find<CartController>().cartOrderSummary();
                        Get.to(CustomBottomNavigationBar(
                          index: 0,
                        ));
                        controller.cartCountController.text = "1";
                      }),
                ],
              ),
              size.HeightSpace(20),
            ],
          ),
        );
      },
    );
  }
}
