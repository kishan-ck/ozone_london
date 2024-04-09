// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';

void askQuestionBottomSheet(BuildContext context,
    {required dynamic Function() submitOnTap}) {
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
      return GetBuilder(
        init: Get.find<ProductDetailController>(),
        builder: (controller) {
          return Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
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
                    "ask_a_question".tr,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  size.HeightSpace(15),
                  Form(
                    key: controller.formKey,
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'please_enter_your_message'.tr;
                        }
                        return null;
                      },
                      maxLines: 4,
                      controller: controller.askQuestionController,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: textColor),
                        hintText: "your_message".tr,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        enabled: true,
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryBlackColor, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryBlackColor, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryBlackColor, width: 1),
                            borderRadius: BorderRadius.circular(8)),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: primaryBlackColor, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                      ),
                    ),
                  ),
                  size.HeightSpace(15),
                  AppButton(
                    buttonText: "submit_now".tr,
                    onPressed: submitOnTap,
                  )
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
