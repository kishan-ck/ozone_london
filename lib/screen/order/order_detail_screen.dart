// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/order_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<OrderController>(),
      builder: (controller) {
        return OfflineBuilder(
          connectivityBuilder: (context, value, child) {
            if (value == ConnectivityResult.none) {
              return Scaffold(
                body: InternetError(),
              );
            }
            return child;
          },
          child: Scaffold(
            backgroundColor: backgroundColor,
            appBar: commonPageAppBar(
                title: 'order_detail'.tr, isNotification: false),
            body: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          customRow(
                              title: "product:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.lineItems?.first.name} x ${controller.orderDetailDataModel?.lineItems?.first.quantity}"),
                          size.HeightSpace(5),
                          customRow(
                              title: "shipping:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.shippingTotal} ${controller.orderDetailDataModel?.currency}"),
                          size.HeightSpace(5),
                          customRow(
                              title: "payment_method:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.paymentMethodTitle}"),
                          size.HeightSpace(5),
                          customRow(
                              title: "gst:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.totalTax} ${controller.orderDetailDataModel?.currency}"),
                          size.HeightSpace(5),
                          customRow(
                              title: "subtotal:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.lineItems?.first.subtotal} ${controller.orderDetailDataModel?.currency}"),
                          size.HeightSpace(5),
                          customRow(
                              title: "total:".tr,
                              value:
                                  "${controller.orderDetailDataModel?.total} ${controller.orderDetailDataModel?.currency}"),
                        ],
                      ),
                    ),
                    size.HeightSpace(15),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "billing_address".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: primaryBlackColor),
                          ),
                          size.HeightSpace(10),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.company}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.firstName} ${controller.orderDetailDataModel?.billing?.lastName}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.address1}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.address2}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.city} ${controller.orderDetailDataModel?.billing?.postcode}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.state} ${controller.orderDetailDataModel?.billing?.country}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.phone}"),
                          size.HeightSpace(20),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.billing?.email}"),
                        ],
                      ),
                    ),
                    size.HeightSpace(15),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "shipping_address".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: primaryBlackColor),
                          ),
                          size.HeightSpace(10),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.company}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.firstName} ${controller.orderDetailDataModel?.shipping?.lastName}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.address1}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.address2}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.city} ${controller.orderDetailDataModel?.shipping?.postcode}"),
                          size.HeightSpace(3),
                          addressString(
                              name:
                                  "${controller.orderDetailDataModel?.shipping?.state} ${controller.orderDetailDataModel?.shipping?.country}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget customRow({required String title, required String value}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: primaryBlackColor),
      ),
      size.WidthSpace(5),
      Expanded(
        child: Text(value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 16, color: textColor)),
      )
    ],
  );
}

Widget addressString({required String name}) {
  return Row(
    children: [
      Text(
        name,
        style: TextStyle(fontSize: 16, color: textColor),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    ],
  );
}
