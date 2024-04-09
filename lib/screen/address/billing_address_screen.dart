// ignore_for_file: prefer_const_constructors

import 'package:ck_woocommerce_api/models/user_detail_model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class BillingAddressScreen extends StatelessWidget {
  const BillingAddressScreen({super.key});

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
      child: GetBuilder<AddressController>(
        init: Get.find<AddressController>(),
        builder: (controller) {
          return Scaffold(
            appBar: commonPageAppBar(
                title: "billing_address".tr, isNotification: false),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(size.height(15)),
                child: Form(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('first_name'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.firstNameController,
                        hintText: 'enter_your_first_name'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_username_and_email'.tr;
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
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.lastNameController,
                        hintText: 'enter_your_first_name'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_username_and_email'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('company_name'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.companyNameController,
                        hintText: 'enter_your_company_name'.tr,
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('country_region'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.countryController,
                        isReadOnly: true,
                        hintText: 'enter_your_country'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_country'.tr;
                          }
                          return null;
                        },
                        onTap: () {
                          showCountryPicker(
                            context: context,
                            onSelect: (value) {
                              controller.countryController.text = value.name;
                            },
                          );
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('street_address'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController:
                            controller.streetAddressController,
                        hintText: 'house_number_and_street_name'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_address'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.apartmentController,
                        hintText: 'apartment_suits_unit'.tr,
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('town_city'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.cityController,
                        hintText: 'enter_your_town_city'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_town_city'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('state'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.stateController,
                        hintText: 'enter_your_state'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_state'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('pin_code'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.pinCodeController,
                        hintText: 'enter_your_pin_code'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_pin_code'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    Text('phone_number'.tr),
                    size.HeightSpace(5),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                offset: Offset(0, 0),
                                color: shadowColor,
                                blurRadius: 3),
                          ]),
                      child: appTextField(
                        textEditingController: controller.phoneNumberController,
                        hintText: 'enter_your_phone_number'.tr,
                        validation: (value) {
                          if (value!.isEmpty) {
                            return 'please_enter_your_phone_number'.tr;
                          }
                          return null;
                        },
                      ),
                    ),
                    size.HeightSpace(15),
                    AppButton(
                        buttonText: "save_address".tr,
                        onPressed: () {
                          if (controller.isBillingEdit ||
                              controller.isShippingEdit) {
                            controller.editBillingAddress().then((value) {
                              controller.fetchAddress().then((value) {
                                // controller.firstNameController.clear();
                                // controller.lastNameController.clear();
                                // controller.companyNameController.clear();
                                // controller.countryController.clear();
                                // controller.streetAddressController.clear();
                                // controller.apartmentController.clear();
                                // controller.cityController.clear();
                                // controller.stateController.clear();
                                // controller.pinCodeController.clear();
                                // controller.phoneNumberController.clear();
                              });
                            });
                            controller.isBillingEdit = false;
                            controller.isShippingEdit = false;

                            Get.back();
                          } else {
                            Get.back();
                          }
                        }),
                    size.HeightSpace(15),
                  ],
                )),
              ),
            ),
          );
        },
      ),
    );
  }
}
