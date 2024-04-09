// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/address_controller.dart';
import 'package:ozone_london/controller/cart_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/screen/cart/widget/order_summary_widget.dart';
import 'package:ozone_london/screen/checkout/widget/payment_method_widget.dart';
import 'package:ozone_london/screen/checkout/widget/ship_to_widget.dart';

class OrderConfirmationScreen extends StatefulWidget {
  final String? couponDiscount;
  final Function() placeOrderOnPress;

  const OrderConfirmationScreen(
      {Key? key, this.couponDiscount, required this.placeOrderOnPress})
      : super(key: key);

  @override
  State<OrderConfirmationScreen> createState() =>
      _OrderConfirmationScreenState();
}

class _OrderConfirmationScreenState extends State<OrderConfirmationScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      init: Get.find<AddressController>(),
      builder: (controller) {
        return Stack(
          children: [
            Scaffold(
              appBar:
                  commonPageAppBar(title: "checkout".tr, isNotification: false),
              backgroundColor: backgroundColor,
              body: SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShipToWidget(),
                      size.HeightSpace(15),
                      PaymentMethodWidget(),
                      size.HeightSpace(15),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: whiteColor),
                        child: OrderSummaryWidget(
                          couponDiscount: getStorage.read("discountAmount"),
                          subTotal:
                              '\$${Get.find<CartController>().cartSubTotal.toStringAsFixed(2)}',
                          discount: Get.find<CartController>()
                              .discount
                              .toStringAsFixed(2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("total".tr,
                                style: TextStyle(
                                    color: primaryBlackColor, fontSize: 18)),
                            Text(
                                Get.find<CartController>().isHaveCoupon
                                    ? '\$${Get.find<CartController>().total - double.parse(Get.find<CartController>().discountAmount)}'
                                    : '\$${Get.find<CartController>().total.toStringAsFixed(2)}',
                                style: TextStyle(
                                    color: primaryBlackColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18)),
                          ],
                        ),
                      ),
                      size.HeightSpace(25),
                      RichText(
                          text: TextSpan(children: [
                        TextSpan(
                          text:
                              "Your personal data will be used to process your order, support your experience throughout this website, and for other purposes described in our ",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                            fontFamily: "Jost",
                          ),
                        ),
                        TextSpan(
                          text: "privacy_policy".tr,
                          style: TextStyle(
                              color: primaryBlackColor,
                              fontSize: 12,
                              fontFamily: "Jost",
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                      size.HeightSpace(10),
                      AppButton(
                        buttonText: "place_order".tr,
                        onPressed: widget.placeOrderOnPress,
                      ),
                      size.HeightSpace(30),
                    ],
                  ),
                ),
              ),
            ),
            controller.isLoading ? loadingWidget() : SizedBox()
          ],
        );
      },
    );
  }
}
