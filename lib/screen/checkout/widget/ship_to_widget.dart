// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/address/address_screen.dart';
import 'package:ozone_london/screen/address/billing_address_screen.dart';

class ShipToWidget extends StatelessWidget {
  const ShipToWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: Get.find<AddressController>(),
      builder: (controller) {
        return (controller.userDetailList?.shipping?.firstName == "" &&
                controller.userDetailList?.shipping?.lastName == "")
            ? Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: InkWell(
                  onTap: () {
                    controller.isBillingEdit = false;
                    controller.isShippingEdit = true;
                    controller.update();
                    controller.controllerTextForEditBilling();
                    Get.to(BillingAddressScreen());
                  },
                  child: Text(
                    "Add Address".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        textBaseline: TextBaseline.ideographic),
                  ),
                ),
              )
            : Container(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('ship_to'.tr,
                            style: TextStyle(
                                color: primaryBlackColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        TextButton(
                          onPressed: () {
                            controller.isBillingEdit = false;
                            controller.isShippingEdit = true;
                            controller.update();
                            controller.controllerTextForEditBilling();
                            Get.to(BillingAddressScreen());
                          },
                          child: Text('change_address'.tr,
                              style: TextStyle(
                                  color: primaryBlackColor, fontSize: 15)),
                        )
                      ],
                    ),
                    Text(controller.userDetailList?.shipping?.firstName ?? "",
                        style:
                            TextStyle(fontSize: 16, color: primaryBlackColor)),
                    size.HeightSpace(5),
                    Text(
                        "${controller.userDetailList?.shipping?.address1 ?? ""} ${controller.userDetailList?.shipping?.address2 ?? ""}, ${controller.userDetailList?.shipping?.city ?? ""} - ${controller.userDetailList?.shipping?.postcode ?? ""}"),
                    size.HeightSpace(5),
                    controller.userDetailList?.shipping?.phone == ""
                        ? SizedBox()
                        : Text(
                            "+91 ${controller.userDetailList?.shipping?.phone ?? ""}",
                            style: TextStyle(fontSize: 14, color: textColor)),
                  ],
                ),
              );
      },
    );
  }
}
