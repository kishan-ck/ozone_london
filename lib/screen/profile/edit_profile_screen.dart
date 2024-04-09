// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/edit_profile_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';

class UserEditProfile extends StatelessWidget {
  const UserEditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonPageAppBar(title: "edit_account".tr, isNotification: false),
      backgroundColor: backgroundColor,
      body: GetBuilder(
          init: Get.find<EditProfileController>(),
          builder: (controller) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.all(size.height(15)),
                    child: Form(
                        key: controller.formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('first_name'.tr),
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
                                    controller.firstNameController,
                                hintText: 'enter_your_first_name'.tr,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_your_username_and_email'
                                        .tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            size.HeightSpace(15),
                            Text('last_name'.tr),
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
                                    controller.lastNameController,
                                hintText: 'enter_your_last_name'.tr,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_your_last_name'.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            size.HeightSpace(15),
                            Text(
                                "this_will_be_how_your_name_will_be_displayed_in_the_account_section_and_in_reviews"
                                    .tr),
                            size.HeightSpace(15),
                            Text('email_address'.tr),
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
                                    controller.emailAddressController,
                                hintText: 'enter_your_email'.tr,
                                validation: (value) {
                                  if (value!.isEmpty) {
                                    return 'please_enter_your_email_id'.tr;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            size.HeightSpace(30),
                            AppButton(
                              buttonText: "save_changes".tr,
                              onPressed: () {
                                if (controller.formkey.currentState!
                                    .validate()) {
                                  controller.editUserData();
                                }
                              },
                            )
                          ],
                        )),
                  ),
                ),
                controller.isLoading ? loadingWidget() : SizedBox()
              ],
            );
          }),
    );
  }
}
