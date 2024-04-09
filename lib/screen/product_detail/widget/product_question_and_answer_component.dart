// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/common_snack_bar/custom_snack_bar.dart';
import 'package:ozone_london/screen/product_detail/widget/ask_question_bottom_sheet.dart';
import 'package:ozone_london/screen/product_detail/widget/product_question_answer_widget.dart';
import 'package:ozone_london/screen/see_more/see_more_button.dart';

class ProductQuestionAndAnswerComponent extends StatelessWidget {
  const ProductQuestionAndAnswerComponent({Key? key}) : super(key: key);

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
              Text('question_and_answer'.tr,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: primaryBlackColor)),
              size.HeightSpace(25),
              ListView.separated(
                  itemCount: controller.productQuestionAnswerList.length,
                  shrinkWrap: true,
                  primary: false,
                  controller: controller.scrollController,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsetsDirectional.zero,
                  separatorBuilder: (final context, final index) =>
                      controller.productQuestionAnswerList[index].commentType ==
                              "question"
                          ? Divider(
                              height: size.height(10),
                              color: grayColor,
                            )
                          : controller.productQuestionAnswerList[index]
                                      .commentType ==
                                  "comment"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: Divider(
                                    height: size.height(10),
                                    color: grayColor,
                                  ),
                                )
                              : SizedBox(),
                  itemBuilder: (final context, final index) => Column(
                        children: [
                          controller.productQuestionAnswerList[index]
                                      .commentType ==
                                  "question"
                              ? ProductQuestionAnswerWidget(
                                  name: controller
                                          .productQuestionAnswerList[index]
                                          .commentAuthor ??
                                      "",
                                  date:
                                      "on ${controller.productQuestionAnswerList[index].commentDate?.split(" ").first ?? ""}",
                                  question: controller
                                          .productQuestionAnswerList[index]
                                          .commentContent ??
                                      "",
                                  reply: "Reply",
                                  replyOnTap: () {
                                    askQuestionBottomSheet(context,
                                        submitOnTap: () {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        controller.questionReply(
                                            productId: controller
                                                    .productDetailModel?.id ??
                                                0,
                                            parentId: index);
                                        controller.getProductQuestionAnswerList(
                                            productId: controller
                                                    .productDetailModel?.id ??
                                                0);
                                        Get.back();
                                        controller.askQuestionController
                                            .clear();
                                        showCustomSnackBar(
                                            controller.questionModel?.data
                                                    ?.message ??
                                                "",
                                            isError: false);
                                      }
                                    });
                                  },
                                )
                              : SizedBox(),
                          controller.productQuestionAnswerList[index]
                                      .commentType ==
                                  "comment"
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 30.0),
                                  child: ProductQuestionAnswerWidget(
                                    name: controller
                                            .productQuestionAnswerList[index]
                                            .commentAuthor ??
                                        "",
                                    date:
                                        "on ${controller.productQuestionAnswerList[index].commentDate?.split(" ").first ?? ""}",
                                    question: controller
                                            .productQuestionAnswerList[index]
                                            .commentContent ??
                                        "",
                                    reply: "",
                                  ),
                                )
                              : SizedBox(),
                        ],
                      )),
              size.HeightSpace(10),
              SeeMoreButton(
                title: 'ask_a_question'.tr,
                onTap: () {
                  askQuestionBottomSheet(context, submitOnTap: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.submitQuestion(
                          productID: controller.productDetailModel?.id ?? 0);
                      controller.getProductQuestionAnswerList(
                          productId: controller.productDetailModel?.id ?? 0);
                      Get.back();
                      controller.askQuestionController.clear();
                      showCustomSnackBar(
                          controller.submitQuestionModel?.data?.message ?? "",
                          isError: false);
                    }
                  });
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
