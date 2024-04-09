// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/forgot_password_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OfflineBuilder(
      connectivityBuilder: (context, value, child) {
        if (value == ConnectivityResult.none) {
          return Scaffold(body: InternetError(),);
        }
        return child;
      },
      child: GetBuilder(
          init: Get.find<ForgotPasswordController>(),
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
                        key: controller.forgotPasswordFormKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'lost_your_password'.tr,
                              style: TextStyle(
                                  fontSize: size.height(35),
                                  fontWeight: FontWeight.bold),
                            ),
                            size.HeightSpace(30),
                            Text(
                              'please_enter_your_username_or_email_address_you_will_receive_a_link_to_create_a_new_password_via_email'
                                  .tr,
                              style: TextStyle(fontSize: 18),
                            ),
                            size.HeightSpace(30),
                            Text(
                              'username_or_email'.tr,
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
                                controller.userAndEmailController,
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
                            AppButton(
                              buttonText: "reset_password".tr,
                              onPressed: () {
                                if (controller.forgotPasswordFormKey
                                    .currentState!
                                    .validate()) {
                                  controller.sendResetPasswordLink();
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
          }),
    );
  }
}
