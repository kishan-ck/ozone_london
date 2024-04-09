// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/bottom_navigation_bar/bottom_navigation_bar.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/screen/cart/cart_screen.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class CouponCodeScreen extends StatelessWidget {
  const CouponCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CartController>(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              backgroundColor: backgroundColor,
              appBar: commonPageAppBar(
                  title: 'coupon_code'.tr, isNotification: false),
              body: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('promo_code'.tr,
                          style: TextStyle(
                              fontSize: 16,
                              color: primaryBlackColor,
                              fontWeight: FontWeight.bold)),
                      size.HeightSpace(10),
                      TextFormField(
                        controller: controller.couponCodeController,
                        cursorColor: primaryBlackColor,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: whiteColor,
                          hintText: 'enter_promo_code'.tr,
                          isDense: true,
                          suffixIcon: SizedBox(
                              width: size.width(100),
                              child: AppButton(
                                buttonText: 'apply'.tr,
                                onPressed: () {},
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      size.HeightSpace(30),
                      Text('available_offers'.tr,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: primaryBlackColor)),
                      size.HeightSpace(10),
                      Flex(
                        direction: Axis.vertical,
                        children: [
                          ListView.separated(
                            itemCount: controller.couponList.length,
                            shrinkWrap: true,
                            controller: controller.scrollController,
                            itemBuilder: (context, index) {
                              return Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        size.HeightSpace(5),
                                        Text(
                                            controller.couponList[index].code ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: primaryBlackColor,
                                                fontWeight: FontWeight.bold)),
                                        size.HeightSpace(5),
                                        Text(
                                            controller.couponList[index]
                                                    .description ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: textColor)),
                                        size.HeightSpace(5),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: ElevatedButton(
                                        onPressed: () async {
                                          // controller
                                          //     .applyCoupon(
                                          //         couponCode: controller
                                          //                 .couponList[index]
                                          //                 .code ??
                                          //             "")
                                          //     .then((value) {
                                          //   showCustomSnackBar(
                                          //       "${controller.applyCouponModel?.message}",
                                          //       isError: false);
                                          //   getStorage.write(
                                          //       "couponCode",
                                          //       controller.applyCouponModel
                                          //               ?.coupondata?[0].code ??
                                          //           "");
                                          //   getStorage.write(
                                          //       "couponAmount",
                                          //       controller
                                          //               .applyCouponModel
                                          //               ?.coupondata?[0]
                                          //               .amount ??
                                          //           "");
                                          //   getStorage.write(
                                          //       "couponMessage",
                                          //       controller.applyCouponModel
                                          //               ?.message ??
                                          //           "");
                                          //   getStorage.write(
                                          //       "couponDescription",
                                          //       controller
                                          //               .applyCouponModel
                                          //               ?.coupondata?[0]
                                          //               .description ??
                                          //           "");
                                          // });
                                          controller.isHaveCoupon = true;
                                          controller.update();
                                          await getStorage.write(
                                              "couponCode",
                                              controller
                                                      .couponList[index].code ??
                                                  "");
                                          await getStorage.write(
                                              "discountAmount",
                                              controller.couponList[index]
                                                      .amount ??
                                                  "");
                                          controller.setCouponData();
                                          Get.back();
                                        },
                                        child: Text('apply'.tr,
                                            style: TextStyle(
                                                color: primaryBlackColor)),
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                              vertical: size.height(5)),
                                          backgroundColor: whiteColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                10.0), // Set the border radius
                                          ),
                                        )),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return Divider(
                                height: size.height(1),
                                color: textColor,
                              );
                            },
                          ),
                        ],
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
    );
  }
}
