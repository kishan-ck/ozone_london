// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';
import 'package:ozone_london/screen/product_detail/widget/ask_question_bottom_sheet.dart';
import 'package:ozone_london/screen/product_detail/widget/order_return_bottom_sheet.dart';

class ProductDetailsComponent extends StatelessWidget {
  const ProductDetailsComponent({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return Container(
          margin: EdgeInsets.only(top: 10),
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      controller.productDetailModel?.name ?? "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomRating(
                        initialRating: double.parse(controller
                                .productDetailModel?.averageRating
                                .toString() ??
                            ""),
                        size: 15,
                      ),
                      size.WidthSpace(10),
                      Text(
                        '(${controller.productDetailModel?.averageRating})',
                        style: TextStyle(color: textColor),
                      )
                    ],
                  )
                ],
              ),
              size.HeightSpace(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.productDetailModel?.price ?? "",
                      style: TextStyle(fontSize: 18, color: primaryBlackColor)),
                  Row(
                    children: [
                      Text(controller.productDetailModel?.regularPrice ?? "",
                          style: TextStyle(
                              fontSize: 18,
                              color: textColor,
                              decoration: TextDecoration.lineThrough)),
                      size.WidthSpace(10),
                      controller.isDiscount(
                                  controller.productDetailModel?.price,
                                  controller.productDetailModel?.salePrice) ==
                              null
                          ? SizedBox()
                          : Text(
                              '${controller.isDiscount(controller.productDetailModel?.price, controller.productDetailModel?.salePrice)}% off',
                              style: TextStyle(
                                  fontSize: 18, color: primaryBlackColor)),
                    ],
                  ),
                  //const CustomBadge('Fulfilled'),
                ],
              ),
              size.HeightSpace(15),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/delivery_icon.svg',
                    color: iconColor,
                    height: 18,
                  ),
                  SizedBox(width: size.width(10)),
                  Row(
                    children: [
                      Text(
                        'estimated_delivery'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      size.WidthSpace(3),
                      Text(
                        'May 30 - 06 Jun, 2023',
                        style: TextStyle(color: textColor),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
              size.HeightSpace(15),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/return_order.svg',
                    height: 20,
                    color: iconColor,
                  ),
                  SizedBox(width: size.width(10)),
                  Row(
                    children: [
                      Text(
                        'free_shipping_and_returns'.tr,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      size.WidthSpace(3),
                      InkWell(
                          onTap: () {
                            orderReturnBottomSheet(context);
                          },
                          child: Icon(Icons.info, color: iconColor))
                    ],
                  )
                ],
              ),
              size.HeightSpace(10),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/ic_question.svg',
                    height: 18,
                    color: iconColor,
                  ),
                  SizedBox(width: size.width(10)),
                  InkWell(
                    onTap: () {
                      askQuestionBottomSheet(context, submitOnTap: () {});
                    },
                    child: Text(
                      'ask_a_question'.tr,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
