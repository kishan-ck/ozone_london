// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/sign_in_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/auth/sign_up_screen.dart';
import 'package:ozone_london/screen/forgot_password/forgot_password_screen.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({Key? key}) : super(key: key);

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
        init: Get.find<SignInController>(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: backgroundColor,
                  automaticallyImplyLeading: false,
                ),
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(size.height(15)),
                    child: Form(
                      key: controller.formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/images/ic_logo_dark.svg",
                            height: size.height(40),
                          ),
                          size.HeightSpace(50),
                          Text(
                            'sign_in'.tr,
                            style: TextStyle(
                                fontSize: size.height(35),
                                fontWeight: FontWeight.bold),
                          ),
                          size.HeightSpace(10),
                          Text(
                            'username'.tr,
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
                              textEditingController: controller.emailController,
                              hintText: 'your_username_and_email'.tr,
                              validation: (value) {
                                if (value!.isEmpty) {
                                  return 'please_enter_your_username_and_email'
                                      .tr;
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
                          Obx(() {
                            return Container(
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
                                  isPassword: controller.passwordVisible.value,
                                  maxLines: 1,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.passwordVisible.value =
                                          !controller.passwordVisible.value;
                                    },
                                    hoverColor: Colors.transparent,
                                    splashColor: Colors.transparent,
                                    icon: Icon(
                                      controller.passwordVisible.value
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
                            );
                          }),
                          size.HeightSpace(15),
                          Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () {
                                Get.to(ForgotPasswordScreen());
                              },
                              splashColor: Colors.transparent,
                              child: Text(
                                'forgot_password'.tr,
                              ),
                            ),
                          ),
                          size.HeightSpace(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "dont_have_an_account_yet".tr,
                                style: TextStyle(color: textColor),
                              ),
                              size.WidthSpace(3),
                              InkWell(
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Get.to(SignUpScreen());
                                },
                                child: Text(
                                  'sign_up'.tr,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              size.WidthSpace(3),
                              Text(
                                "for_free".tr,
                                style: TextStyle(color: textColor),
                              ),
                            ],
                          ),
                          size.HeightSpace(30),
                          AppButton(
                            buttonText: "log_in".tr,
                            onPressed: () {
                              if (controller.formkey.currentState!.validate()) {
                                controller.login();
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
