// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:hidable/hidable.dart';
import 'package:flutter/material.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/cart/widget/cart_button.dart';
import 'package:ozone_london/screen/product_detail/widget/count_button.dart';

class ProductBottomNavigationBar extends StatefulWidget {
  final dynamic Function() addToCartPress;

  const ProductBottomNavigationBar({Key? key, required this.addToCartPress})
      : super(key: key);

  @override
  State<ProductBottomNavigationBar> createState() =>
      _ProductBottomNavigationBarState();
}

class _ProductBottomNavigationBarState
    extends State<ProductBottomNavigationBar> {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return Hidable(
          preferredWidgetSize: Size(double.infinity, size.height(75)),
          controller: controller.scrollController,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            decoration: BoxDecoration(
              color: whiteColor,
              boxShadow: AppShadows.buttonBoxShadow,
              borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10), topEnd: Radius.circular(10)),
            ),
            child: Row(
              children: [
                CountButton(value: controller.cartValue, onChange: (val) {}),
                SizedBox(width: 20),
                Flexible(
                  child: AppButton(
                      buttonText: 'add_to_cart'.tr,
                      onPressed: widget.addToCartPress),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
