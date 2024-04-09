// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class WriteReviewScreen extends StatelessWidget {
  WriteReviewScreen({Key? key}) : super(key: key);

  double ratingValue = 0.0;

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
      child: GetBuilder(
        init: Get.find<ProductDetailController>(),
        builder: (controller) {
          return Scaffold(
            appBar: commonPageAppBar(
                title: "write_review".tr, isNotification: false),
            backgroundColor: backgroundColor,
            body: Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "you_rating".tr,
                    style: TextStyle(
                        fontSize: 22,
                        color: primaryBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  size.HeightSpace(10),
                  RatingBar(
                    allowHalfRating: false,
                    glow: false,
                    itemSize: 35,
                    ignoreGestures: false,
                    glowColor: primaryBlackColor,
                    ratingWidget: RatingWidget(
                      full: Icon(
                        Icons.star,
                        color: iconColor,
                      ),
                      half: Icon(
                        Icons.star_half,
                        color: iconColor,
                      ),
                      empty: Icon(
                        Icons.star_border_outlined,
                        color: iconColor,
                      ),
                    ),
                    onRatingUpdate: (value) {
                      ratingValue = value;
                    },
                  ),
                  size.HeightSpace(25),
                  Text(
                    "add_a_written_review".tr,
                    style: TextStyle(
                        fontSize: 22,
                        color: primaryBlackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  size.HeightSpace(10),
                  appTextField(
                      textEditingController: controller.reviewController,
                      hintText: "what_did_you_like_or_dislike".tr,
                      hintTextStyle: TextStyle(color: textColor),
                      maxLines: 5),
                  size.HeightSpace(25),
                  AppButton(
                    buttonText: "write_review".tr,
                    onPressed: () {
                      if (ratingValue == 0.0) {
                        showCustomSnackBar("please_select_a_rating".tr);
                      } else {
                        Get.back();
                        controller.writeReview(body: {
                          "product_id": controller.productDetailModel?.id,
                          "review": controller.reviewController.text,
                          "reviewer": getStorage.read("name"),
                          "reviewer_email": getStorage.read("email"),
                          "rating": ratingValue,
                        });
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
