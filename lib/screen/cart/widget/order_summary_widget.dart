// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/cart_controller.dart';

class OrderSummaryWidget extends StatelessWidget {
  final Color? backgroundColor;
  final String? couponDiscount;
  final String subTotal;
  final String discount;

  const OrderSummaryWidget({
    this.backgroundColor,
    Key? key,
    this.couponDiscount,
    required this.subTotal,
    required this.discount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'order_summary'.tr,
            style: TextStyle(
                fontSize: 18,
                color: primaryBlackColor,
                fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          size.HeightSpace(5),
          _buildOrderDescription(context, 'sub_total'.tr, subTotal),
          size.HeightSpace(5),
          _buildOrderDescription(context, 'discount'.tr, '- \$$discount'),
          size.HeightSpace(5),
          _buildOrderDescription(context, 'shipping'.tr, '\$0'),
          size.HeightSpace(5),
          Visibility(
            visible: Get.find<CartController>().isHaveCoupon,
            replacement: SizedBox(),
            child: _buildOrderDescription(
                context, 'discount_coupon'.tr, '\$$couponDiscount'),
          )
        ],
      ),
    );
  }

  Row _buildOrderDescription(
      BuildContext context, String title, String number) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 15, color: primaryBlackColor)),
        Text(number, style: TextStyle(fontSize: 15, color: primaryBlackColor)),
      ],
    );
  }
}
