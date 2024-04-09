// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';

class CountButton extends StatefulWidget {
  final int value;
  final Function(int newValue) onChange;
  final CartDataModel? cartData;

  const CountButton(
      {required this.value, required this.onChange, Key? key, this.cartData})
      : super(key: key);

  @override
  State<CountButton> createState() => _CountButtonState();
}

class _CountButtonState extends State<CountButton> {
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
                onTap: () async {
                  if (controller.cartValue > 1) {
                    controller.cartValue--;

                    controller.cartCountController.text =
                        controller.cartValue.toString();

                    widget.onChange(controller.cartValue);
                    controller.update();
                  }
                },
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
                  child:
                  TextFormField(
                    controller: controller.cartCountController,
                    onFieldSubmitted: (val) {
                      final number = num.tryParse(val);
                      if (number == null || number < 1) {
                        controller.cartCountController.text = 1.toString();
                        controller.update();
                      }
                    },
                    onChanged: (val) {
                      final number = num.tryParse(val);

                      if (number == null || number < 1) {
                        controller.cartValue = 1;
                      } else {
                        controller.cartValue = int.parse(val.trim());
                      }
                      controller.update();
                    },
                    textAlign: TextAlign.center,
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(color: primaryBlackColor, fontSize: 16),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      isCollapsed: true,
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                    ),
                  )),
              InkWell(
                onTap: () async {
                  controller.cartValue++;

                  controller.cartCountController.text =
                      controller.cartValue.toString();

                  widget.onChange(controller.cartValue);

                  controller.update();
                },
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
