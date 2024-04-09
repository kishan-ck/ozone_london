// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/address/billing_address_screen.dart';
import 'package:ozone_london/screen/address/widget/address_list_widget.dart';
import 'package:ozone_london/screen/order/order_detail_screen.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

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
          return Stack(
            children: [
              Scaffold(
                backgroundColor: backgroundColor,
                appBar: AppBar(
                  backgroundColor: backgroundColor,
                  elevation: 0,
                  title: Text(
                    "address".tr,
                    style: TextStyle(color: primaryBlackColor),
                  ),
                  leading: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back,
                        color: iconColor,
                      )),
                  actions: [
                    TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStatePropertyAll(Colors.black12)),
                        onPressed: () {
                          controller.isBillingEdit = false;
                          controller.isShippingEdit = false;
                          controller.controllerTextForEditBilling();
                          Get.to(BillingAddressScreen());
                        },
                        child: Text(
                          "add_address".tr,
                          style: TextStyle(color: iconColor),
                        ))
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      (controller.userDetailList?.billing?.firstName == "" &&
                              controller.userDetailList?.billing?.lastName ==
                                  "")
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "billing_address".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: primaryBlackColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.isShippingEdit = false;
                                          controller.isBillingEdit = true;
                                          controller.update();
                                          controller
                                              .controllerTextForEditBilling();
                                          Get.to(BillingAddressScreen());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: kBackgroundCardColor),
                                          child: Icon(Icons.edit),
                                        ),
                                      )
                                    ],
                                  ),
                                  size.HeightSpace(10),
                                  addressString(
                                      name: controller.userDetailList?.billing
                                              ?.company ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.billing?.firstName ?? ""} ${controller.userDetailList?.billing?.lastName ?? ""}"),
                                  size.HeightSpace(3),
                                  addressString(
                                      name: controller.userDetailList?.billing
                                              ?.address1 ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name: controller.userDetailList?.billing
                                              ?.address2 ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.billing?.city ?? ""} ${controller.userDetailList?.billing?.postcode ?? ""}"),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.billing?.state ?? ""} ${controller.userDetailList?.billing?.country ?? ""}"),
                                  size.HeightSpace(3),
                                  addressString(
                                      name: controller
                                              .userDetailList?.billing?.phone ??
                                          ""),
                                  size.HeightSpace(20),
                                  addressString(
                                      name: controller
                                              .userDetailList?.billing?.email ??
                                          ""),
                                ],
                              ),
                            ),
                      size.HeightSpace(15),
                      (controller.userDetailList?.shipping?.firstName == "" &&
                              controller.userDetailList?.shipping?.lastName ==
                                  "")
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 15),
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "shipping_address".tr,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: primaryBlackColor),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          controller.isBillingEdit = false;
                                          controller.isShippingEdit = true;
                                          controller.update();
                                          controller
                                              .controllerTextForEditBilling();
                                          Get.to(BillingAddressScreen());
                                        },
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              color: kBackgroundCardColor),
                                          child: Icon(Icons.edit),
                                        ),
                                      )
                                    ],
                                  ),
                                  size.HeightSpace(10),
                                  addressString(
                                      name: controller.userDetailList?.shipping
                                              ?.company ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.shipping?.firstName ?? ""} ${controller.userDetailList?.shipping?.lastName ?? ""}"),
                                  size.HeightSpace(3),
                                  addressString(
                                      name: controller.userDetailList?.shipping
                                              ?.address1 ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name: controller.userDetailList?.shipping
                                              ?.address2 ??
                                          ""),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.shipping?.city ?? ""} ${controller.userDetailList?.shipping?.postcode ?? ""}"),
                                  size.HeightSpace(3),
                                  addressString(
                                      name:
                                          "${controller.userDetailList?.shipping?.state ?? ""} ${controller.userDetailList?.shipping?.country ?? ""}"),
                                ],
                              ),
                            ),
                    ],
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
