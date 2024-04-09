// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/checkout_controller.dart';
import 'package:ozone_london/screen/payment/add_new_debit_card.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({Key? key}) : super(key: key);

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<CheckOutController>(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: whiteColor,
          ),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'payment_method'.tr,
                  style: TextStyle(
                      fontSize: 18,
                      color: primaryBlackColor,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                size.HeightSpace(10),
                Visibility(
                  visible: !controller.isPaymentExist,
                  child: Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        contentPadding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: grayColor)),
                        title: Row(
                          children: [
                            Expanded(
                              child: SvgPicture.asset(
                                controller.paymentMethodList[0].svg,
                                alignment: AlignmentDirectional.centerStart,
                              ),
                            ),
                            size.WidthSpace(15),
                            Expanded(
                              flex: 5,
                              child: Text(
                                controller.paymentMethodList[0].title,
                                style: TextStyle(
                                    fontSize: 16, color: primaryBlackColor),
                              ),
                            ),
                          ],
                        ),
                        trailing: TextButton(
                          child: Text('add'.tr,
                              style: TextStyle(
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.bold)),
                          onPressed: () {
                            Get.to(AddPaymentCardScreen());
                          },
                        ),
                      ),
                      size.HeightSpace(15),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  primary: false,
                  padding: EdgeInsetsDirectional.zero,
                  itemCount: 1,
                  // controller.isPaymentExist
                  //     ? controller.paymentMethodList.length
                  //     : controller.paymentMethodList.length - 1,
                  separatorBuilder: (context, index) => size.HeightSpace(10),
                  itemBuilder: (context, index) =>
                      Visibility(
                        visible: controller.isPaymentExist,
                        child: RadioListTile(
                          value: index,
                          groupValue: controller.radioValue,
                          activeColor: primaryBlackColor,
                          onChanged: (dynamic val) {
                            controller.radioValue = val;
                            controller.update();
                          },
                          contentPadding: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: grayColor)),
                          title: Row(
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  controller.paymentMethodList[index].svg,
                                  alignment: AlignmentDirectional.centerStart,
                                ),
                              ),
                              size.WidthSpace(15),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  controller.paymentMethodList[index].title,
                                  style: TextStyle(
                                      fontSize: 16, color: primaryBlackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        replacement: RadioListTile(
                          value: index,
                          groupValue: controller.radioValue,
                          activeColor: primaryBlackColor,
                          contentPadding: EdgeInsets.zero,
                          onChanged: (dynamic val) {
                            controller.radioValue = val;
                            controller.update();
                          },
                          controlAffinity: ListTileControlAffinity.trailing,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: grayColor)),
                          title: Row(
                            children: [
                              Expanded(
                                child: SvgPicture.asset(
                                  controller.paymentMethodList[index + 1].svg,
                                  // width: size.width(40),
                                  height: size.height(30),
                                  alignment: AlignmentDirectional.centerStart,
                                ),
                              ),
                              size.WidthSpace(15),
                              Expanded(
                                flex: 5,
                                child: Text(
                                  controller.paymentMethodList[index + 1].title,
                                  style: TextStyle(
                                      fontSize: 16, color: primaryBlackColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
