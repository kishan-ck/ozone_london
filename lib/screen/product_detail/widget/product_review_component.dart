// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';
import 'package:ozone_london/screen/product_detail/widget/product_review_card_widget.dart';
import 'package:ozone_london/screen/review/write_review_screen.dart';
import 'package:ozone_london/screen/see_more/see_more_button.dart';

class ProductReviewsComponent extends StatelessWidget {
  const ProductReviewsComponent({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('rating_and_review'.tr,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlackColor)),
              size.HeightSpace(25),
              ListView.separated(
                  itemCount: controller.productReviewDataModel?.length ?? 0,
                  shrinkWrap: true,
                  primary: false,
                  controller: controller.scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.zero,
                  separatorBuilder: (final context, final index) => Divider(
                        height: size.height(10),
                        color: grayColor,
                      ),
                  itemBuilder: (final context, final index) =>
                      ProductReviewCardWidget(
                        ratingValue: double.parse(controller
                                .productReviewDataModel?[index].rating
                                .toString() ??
                            ""),
                        name: controller
                                .productReviewDataModel?[index].reviewer ??
                            "",
                        date: controller
                                .productReviewDataModel?[index].dateCreated
                                ?.split("T")
                                .first ??
                            "",
                        review:
                            controller.productReviewDataModel?[index].review ??
                                "",
                      )),
              size.HeightSpace(10),
              SeeMoreButton(
                title: 'write_review'.tr,
                onTap: () {
                  Get.to(WriteReviewScreen());
                },
              ),
              size.HeightSpace(25),
            ],
          ),
        );
      },
    );
  }
}
