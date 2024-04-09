// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/forgot_password_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class ResetPassWordScreen extends StatelessWidget {
  const ResetPassWordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        if (value == ConnectivityResult.none) {
          return Scaffold(
            body: InternetError(),
          );
        }
        return child;
      },
      child: GetBuilder(
        init: Get.find<ForgotPasswordController>(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                backgroundColor: backgroundColor,
                appBar: commonPageAppBar(
                    title: 'reset_password'.tr, isNotification: false),
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(15),
                    child: Form(
                      key: controller.resetPasswordFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'enter_your_new_password'.tr,
                            style: TextStyle(
                                fontSize: 22,
                                color: primaryBlackColor,
                                fontWeight: FontWeight.bold),
                          ),
                          size.HeightSpace(5),
                          Text(
                            controller.userAndEmailController.text,
                            style: TextStyle(fontSize: 18, color: textColor),
                          ),
                          size.HeightSpace(30),
                          Text(
                            'password'.tr,
                            style: TextStyle(
                                fontSize: 16, color: primaryBlackColor),
                          ),
                          size.HeightSpace(5),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      color: shadowColor,
                                      blurRadius: 3),
                                ]),
                            child: appTextField(
                                textEditingController:
                                    controller.passwordController,
                                isPassword: controller.passwordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.passwordVisible =
                                        !controller.passwordVisible;
                                    controller.update();
                                  },
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                    controller.passwordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: primaryBlackColor,
                                  ),
                                ),
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_your_password'.tr;
                                  }
                                  return null;
                                },
                                hintText: 'password'.tr),
                          ),
                          size.HeightSpace(30),
                          Text(
                            'confirm_password'.tr,
                            style: TextStyle(
                                fontSize: 16, color: primaryBlackColor),
                          ),
                          size.HeightSpace(5),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      color: shadowColor,
                                      blurRadius: 3),
                                ]),
                            child: appTextField(
                                textEditingController:
                                    controller.confirmPasswordController,
                                isPassword: controller.confirmPasswordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    controller.confirmPasswordVisible =
                                        !controller.confirmPasswordVisible;
                                    controller.update();
                                  },
                                  hoverColor: Colors.transparent,
                                  splashColor: Colors.transparent,
                                  icon: Icon(
                                    controller.confirmPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: primaryBlackColor,
                                  ),
                                ),
                                validation: (value) {
                                  if (value != null) {
                                    if (value.isNotEmpty) {
                                      if (controller.passwordController.text ==
                                          controller
                                              .confirmPasswordController.text) {
                                        return null;
                                      } else {
                                        return 'please_enter_confirm_password_as_same_as_new_password'
                                            .tr;
                                      }
                                    } else {
                                      return 'please_enter_confirm_password'.tr;
                                    }
                                  }
                                  return null;
                                },
                                hintText: 'confirm_password'.tr),
                          ),
                          size.HeightSpace(30),
                          AppButton(
                            buttonText: 'reset_password'.tr,
                            onPressed: () {
                              if (controller.resetPasswordFormKey.currentState!
                                  .validate()) {
                                controller.setNewPassword();
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              controller.isLoading ? loadingWidget() : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
