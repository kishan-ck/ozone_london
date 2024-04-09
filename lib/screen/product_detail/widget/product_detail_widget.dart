// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/screen/product_detail/widget/about_product_component.dart';
import 'package:ozone_london/screen/product_detail/widget/about_the_brand_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_colors_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_detail_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_question_and_answer_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_review_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_size_component.dart';
import 'package:ozone_london/screen/product_detail/widget/product_slider_widget.dart';
import 'package:ozone_london/screen/product_detail/widget/similar_product_widget.dart';
import 'package:share_plus/share_plus.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductSliderComponent(),
              ProductDetailsComponent(),
              _ProductSizesAndColorsWidget(),
              AboutProductComponent(),
              // AboutTheBrandComponent(
              //     productBrand:
              //         controller.productDetailModel?.productBrand ?? []),
              ProductReviewsComponent(),
              ProductQuestionAndAnswerComponent(),
              SimilarProductsComponent(),
              size.HeightSpace(20)
            ],
          )),
        );
      },
    );
  }
}

class _ProductSizesAndColorsWidget extends StatelessWidget {
  const _ProductSizesAndColorsWidget({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: [
        ProductSizesComponent(),
        ProductColorsComponent(),
      ],
    );
  }
}
