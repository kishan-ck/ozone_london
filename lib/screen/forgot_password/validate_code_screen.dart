// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/forgot_password_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class ValidateCodeScreen extends StatelessWidget {
  const ValidateCodeScreen({Key? key}) : super(key: key);

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
                appBar: commonPageAppBar(
                    title: "validate_code".tr, isNotification: false),
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(size.height(15)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'username_or_email'.tr,
                          style:
                              TextStyle(fontSize: 18, color: primaryBlackColor),
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
                            isReadOnly: true,
                            textEditingController:
                                controller.userAndEmailController,
                            hintText: 'your_username_and_email'.tr,
                          ),
                        ),
                        size.HeightSpace(20),
                        Text(
                          'valid_code'.tr,
                          style:
                              TextStyle(fontSize: 18, color: primaryBlackColor),
                        ),
                        size.HeightSpace(20),
                        OtpTextField(
                          keyboardType: TextInputType.number,
                          showFieldAsBox: true,
                          showCursor: false,
                          borderRadius: BorderRadius.circular(10),
                          fieldWidth: 50,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onSubmit: (value) {
                            controller.validateCode = value;
                            controller.update();
                          },
                          focusedBorderColor: primaryBlackColor,
                          autoFocus: true,
                          decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBlackColor)),
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: primaryBlackColor)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: redColor))),
                        ),
                        size.HeightSpace(50),
                        AppButton(
                          buttonText: "valid_code".tr,
                          onPressed: () {
                            if (controller.validateCode.isNotEmpty) {
                              controller.validateCodeVerify();
                            } else {
                              showCustomSnackBar(
                                  "please_enter_validate_code".tr);
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
          );
        },
      ),
    );
  }
}
