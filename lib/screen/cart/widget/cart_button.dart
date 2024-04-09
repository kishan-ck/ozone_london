// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';

class CartButton extends StatefulWidget {
  final int value;
  final Function(int newValue) onChange;
  final CartDataModel? cartData;
  final Function()? decrementOnTap;
  final Function()? incrementOnTap;

  const CartButton(
      {required this.value,
      required this.onChange,
      Key? key,
      this.cartData,
      this.decrementOnTap,
      this.incrementOnTap})
      : super(key: key);

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return SizedBox(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: widget.decrementOnTap,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cartButtonBackgroundColor,
                    border: Border.all(
                        color: controller.cartValue == 1
                            ? shadowColor
                            : backgroundColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.remove_rounded,
                      color: controller.cartValue == 1
                          ? grayColor
                          : primaryBlackColor,
                      size: 12),
                ),
              ),
              SizedBox(
                  width: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(widget.cartData?.count.toString() ?? "1"),
                  )),
              InkWell(
                onTap: widget.incrementOnTap,
                child: Container(
                  height: double.infinity,
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: cartButtonBackgroundColor,
                    border: Border.all(color: shadowColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.add_rounded,
                      color: primaryBlackColor, size: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
