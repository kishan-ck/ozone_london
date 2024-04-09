// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/constant/loader.dart';
import 'package:ozone_london/controller/order_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/order/order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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
        init: Get.find<OrderController>(),
        builder: (controller) {
          return Stack(
            children: [
              Scaffold(
                appBar:
                    commonPageAppBar(title: 'orders'.tr, isNotification: false),
                backgroundColor: backgroundColor,
                body: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return size.HeightSpace(15);
                        },
                        itemCount: controller.orderList.length,
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: whiteColor),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "order".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlackColor,
                                                    fontSize: 18),
                                              ),
                                              size.WidthSpace(5),
                                              Text(
                                                "#${controller.orderList[index].id}",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlackColor,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                          size.HeightSpace(5),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "date".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlackColor,
                                                    fontSize: 18),
                                              ),
                                              size.WidthSpace(5),
                                              SizedBox(
                                                width: size.width(180),
                                                child: Text(
                                                  "${controller.orderList[index].dateCreated?.split("T").first}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          size.HeightSpace(3),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "status".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlackColor,
                                                    fontSize: 18),
                                              ),
                                              size.WidthSpace(5),
                                              SizedBox(
                                                width: size.width(180),
                                                child: Text(
                                                  "${controller.orderList[index].status}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: Colors
                                                          .lightBlueAccent,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                          size.HeightSpace(3),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "total:".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: primaryBlackColor,
                                                    fontSize: 18),
                                              ),
                                              size.WidthSpace(5),
                                              SizedBox(
                                                width: size.width(180),
                                                child: Text(
                                                  "${controller.orderList[index].total}",
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      color: textColor,
                                                      fontSize: 16),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: primaryBlackColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Set the border radius
                                        ),
                                      ),
                                      child: Center(
                                          child: Text(
                                        "view".tr,
                                        style: TextStyle(
                                            color: whiteColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      onPressed: () {
                                        controller.orderDetail(
                                            orderID: int.parse(controller
                                                .orderList[index].id
                                                .toString()));
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                ),
              ),
              controller.isLoading ? loadingWidget() : SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
