// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/common_appbar/common_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/cart/empty_cart_screen.dart';
import 'package:ozone_london/screen/cart/widget/coupon_widget.dart';
import 'package:ozone_london/screen/cart/widget/free_shipping_widget.dart';
import 'package:ozone_london/screen/cart/widget/my_product_cart_widget.dart';
import 'package:ozone_london/screen/cart/widget/order_summary_widget.dart';
import 'package:ozone_london/screen/cart/widget/product_note_widget.dart';
import 'package:ozone_london/screen/checkout/order_checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: Get.find<CartController>(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: commonAppBar(),
            backgroundColor: backgroundColor,
            body: Stack(
              children: [
                Container(
                  // margin: EdgeInsets.symmetric(horizontal: 15),
                  child: controller.cartList.isEmpty
                      ? EmptyCartScreen()
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyProductsCartWidget(),
                              CouponWidget(
                                couponCode: controller.couponCode ?? "",
                              ),
                              OrderNoteWidget(
                                  noteController: TextEditingController()),
                              OrderSummaryWidget(
                                couponDiscount: controller.discountAmount,
                                subTotal:
                                    '\$${controller.cartSubTotal.toStringAsFixed(2)}',
                                discount:
                                    controller.discount.toStringAsFixed(2),
                              ),
                              size.HeightSpace(20),
                              Container(
                                color: whiteColor,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("total".tr,
                                            style: TextStyle(
                                                color: primaryBlackColor,
                                                fontSize: 18)),
                                        Text(
                                            controller.isHaveCoupon
                                                ? '\$${controller.total - double.parse(controller.discountAmount)}'
                                                : '\$${controller.total.toStringAsFixed(2)}',
                                            style: TextStyle(
                                                color: primaryBlackColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18)),
                                      ],
                                    ),
                                    size.HeightSpace(20),
                                    AppButton(
                                      buttonText: "secure_checkout".tr,
                                      onPressed: () {
                                        Get.find<AddressController>()
                                            .fetchAddress();
                                        Get.to(OrderConfirmationScreen(
                                          couponDiscount:
                                              controller.discountAmount,
                                          placeOrderOnPress: () {
                                            controller.makePayment();
                                          },
                                        ));
                                      },
                                    )
                                  ],
                                ),
                              ),
                              size.HeightSpace(30),
                            ],
                          ),
                        ),
                ),
                controller.isRemove ? loadingWidget() : SizedBox()
              ],
            ),
          );
        });
  }
}
