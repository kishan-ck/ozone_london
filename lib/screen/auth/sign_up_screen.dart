// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/sign_up_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/auth/sign_in_screen.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

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
          init: Get.find<SignUpController>(),
          builder: (controller) {
            return Scaffold(
                backgroundColor: backgroundColor,
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        margin: EdgeInsets.all(size.height(15)),
                        child: Form(
                          key: controller.formkey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              size.HeightSpace(40),
                              Text(
                                'sign_up'.tr,
                                style: TextStyle(
                                    fontSize: size.height(50),
                                    fontWeight: FontWeight.bold),
                              ),
                              size.HeightSpace(30),
                              Text(
                                'name'.tr,
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
                                      controller.yourNameController,
                                  hintText: 'name'.tr,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return 'please_enter_your_name'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              size.HeightSpace(30),
                              Text(
                                'user_name'.tr,
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
                                      controller.userNameController,
                                  hintText: 'user_name'.tr,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return 'please_enter_your_user_name'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              size.HeightSpace(30),
                              Text(
                                'email'.tr,
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
                                      controller.emailController,
                                  hintText: 'email'.tr,
                                  validation: (value) {
                                    if (value!.isEmpty) {
                                      return 'please_enter_your_email'.tr;
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              size.HeightSpace(30),
                              Text(
                                'password'.tr,
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
                                    maxLines: 1,
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
                                        color: iconColor,
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
                              size.HeightSpace(10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Checkbox(
                                    activeColor: primaryBlackColor,
                                    value: controller.checkboxValue,
                                    onChanged: (value) {
                                      controller.checkboxValue = value!;
                                      controller.update();
                                    },
                                  ),
                                  Expanded(
                                      child: Row(
                                    children: [
                                      Text(
                                        "yes_i_agree_with".tr,
                                        style: TextStyle(
                                            color: textColor, fontSize: 12),
                                      ),
                                      Text(
                                        'privacy_policy'.tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12),
                                      ),
                                      Text(
                                        "and_terms_of_use".tr,
                                        style: TextStyle(
                                            color: textColor, fontSize: 12),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                              size.HeightSpace(30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "already_have_an_account".tr,
                                    style: TextStyle(color: textColor),
                                  ),
                                  size.WidthSpace(3),
                                  InkWell(
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      Get.to(SignInScreen());
                                    },
                                    child: Text(
                                      'log_in'.tr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              size.HeightSpace(30),
                              AppButton(
                                buttonText: "sign_up".tr,
                                onPressed: () {
                                  if (controller.formkey.currentState!
                                      .validate()) {
                                    if (controller.checkboxValue == true) {
                                      controller.createUser();
                                    } else {
                                      showCustomSnackBar(
                                        "please_accept_the_privacy_policy_and_terms_of_use"
                                            .tr,
                                      );
                                    }
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    controller.isLoading ? loadingWidget() : SizedBox(),
                  ],
                ));
          }),
    );
  }
}
