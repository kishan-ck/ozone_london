// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/checkout_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class AddPaymentCardScreen extends StatefulWidget {
  const AddPaymentCardScreen({super.key});

  @override
  State<AddPaymentCardScreen> createState() => _AddPaymentCardScreenState();
}

class _AddPaymentCardScreenState extends State<AddPaymentCardScreen> {
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
        init: Get.find<CheckOutController>(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: backgroundColor,
            appBar:
                commonPageAppBar(title: 'payment'.tr, isNotification: false),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  CreditCardWidget(
                    cardNumber: controller.cardNumberController.text,
                    expiryDate: controller.expDateController.text,
                    cardHolderName: controller.cardHolderNameController.text,
                    isHolderNameVisible: true,
                    isSwipeGestureEnabled: true,
                    textStyle: TextStyle(
                        fontFamily: "Jost", color: whiteColor, fontSize: 14),
                    cvvCode: controller.cvvController.text,
                    obscureCardCvv: true,
                    showBackView: false,
                    onCreditCardWidgetChange: (CreditCardBrand
                        creditCardBrand) {}, //true when you want to show cvv(back) view
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "card_number".tr,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: primaryBlackColor),
                        ),
                        size.HeightSpace(10),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      color: shadowColor,
                                      blurRadius: 3),
                                ]),
                            child: appTextField(
                                textEditingController:
                                    controller.cardNumberController,
                                onChanged: (p0) {
                                  controller.update();
                                },
                                inputType: TextInputType.number,
                                hintText: "1000 2000 3000 4000")),
                        size.HeightSpace(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(0, 0),
                                          color: shadowColor,
                                          blurRadius: 3),
                                    ]),
                                child: appTextField(
                                  textEditingController:
                                      controller.expDateController,
                                  maxLines: 1,
                                  hintText: 'exp_date'.tr,
                                  isReadOnly: true,
                                  onChanged: (p0) {
                                    controller.update();
                                  },
                                  onTap: () {
                                    controller.selectDate(context: context);
                                  },
                                ),
                              ),
                            ),
                            size.WidthSpace(40),
                            Expanded(
                                child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: Offset(0, 0),
                                        color: shadowColor,
                                        blurRadius: 3),
                                  ]),
                              child: appTextField(
                                  textEditingController:
                                      controller.cvvController,
                                  inputType: TextInputType.number,
                                  hintText: "cvv".tr),
                            )),
                          ],
                        ),
                        size.HeightSpace(10),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 0),
                                      color: shadowColor,
                                      blurRadius: 3),
                                ]),
                            child: appTextField(
                                textEditingController:
                                    controller.cardHolderNameController,
                                onChanged: (p0) {
                                  controller.update();
                                },
                                inputType: TextInputType.text,
                                hintText: "card_holder_name".tr)),
                        size.HeightSpace(30),
                        AppButton(
                          buttonText: 'confirm'.tr,
                          onPressed: () {},
                        )
                      ],
                    ),
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
