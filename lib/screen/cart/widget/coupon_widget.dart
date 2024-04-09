// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/controller/searchController.dart';
import 'package:ozone_london/screen/cart/coupon_code_list_screen.dart';

import '../../../presentation/common_snack_bar/custom_snack_bar.dart';

class CouponWidget extends StatefulWidget {
  final String couponCode;

  const CouponWidget({Key? key, required this.couponCode}) : super(key: key);

  @override
  State<CouponWidget> createState() => _CouponWidgetState();
}

class _CouponWidgetState extends State<CouponWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
      init: Get.find<CartController>(),
      assignId: true,
      builder: (controller) {
        return Column(
          children: [
            const Divider(height: 0),
            Visibility(
              visible: controller.isHaveCoupon,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Text('coupon_code'.tr,
                          style: TextStyle(
                              fontSize: 18,
                              color: primaryBlackColor,
                              fontWeight: FontWeight.bold))),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                    child: ListTile(
                      onTap: () {},
                      leading: Icon(Icons.local_offer_outlined,
                          color: iconColor, size: 20),
                      title: Text(
                        getStorage.read("couponCode") ?? "",
                        style:
                            TextStyle(fontSize: 16, color: primaryBlackColor),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: TextButton(
                          onPressed: () {
                            // controller
                            //     .removeCoupon(
                            //         couponCode: controller.applyCouponModel
                            //                 ?.coupondata?[0].code
                            //                 ?.toLowerCase() ??
                            //             "")
                            //     .then((value) {
                            //   controller.removeCouponModel?.message != null
                            //       ? showCustomSnackBar(
                            //           "${controller.removeCouponModel?.message}",
                            //           isError: false)
                            //       : SizedBox();
                            //   getStorage.remove("couponCode");
                            // });
                            controller.isHaveCoupon = false;
                            controller.update();
                            getStorage.remove("couponCode");
                            getStorage.remove("discountAmount");
                          },
                          child: Text("remove".tr,
                              style:
                                  TextStyle(color: textColor, fontSize: 14))),
                      contentPadding: EdgeInsets.zero,
                      minLeadingWidth: 0,
                    ),
                  ),
                  size.HeightSpace(5),
                  Container(
                    width: double.infinity,
                    color: lightGreenColor,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      getStorage.read("couponMessage") ??
                          "coupon_code_applied_successfully".tr,
                      style: TextStyle(fontSize: 14, color: darkGreenColor),
                    ),
                  )
                ],
              ),
              replacement: ListTile(
                onTap: () {
                  Get.find<CartController>().fetchCouponList();
                  Get.to(CouponCodeScreen());
                },
                title: Text(
                  'have_a_coupon_code'.tr,
                  style: TextStyle(fontSize: 16, color: textColor),
                ),
                trailing: Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: iconColor),
                // contentPadding: EdgeInsets.zero,
              ),
            ),
            const Divider(height: 0),
          ],
        );
      },
    );
  }
}
