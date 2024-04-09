// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/filter/filter_button.dart';
import 'package:ozone_london/screen/filter/widget/filter_bottom_sheet.dart';
import 'package:ozone_london/screen/product/short_by_button.dart';
import 'package:ozone_london/screen/product/widget/grid_product_card.dart';
import 'package:ozone_london/screen/product/widget/product_list_widget.dart';
import 'package:ozone_london/screen/product/widget/short_by_widget.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({Key? key}) : super(key: key);

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
        init: Get.find<ProductListController>(),
        builder: (controller) {
          return Scaffold(
            appBar: commonPageAppBar(title: 'product_list'.tr),
            backgroundColor: backgroundColor,
            body: Container(
              margin: EdgeInsets.all(10),
              child: SmartRefresher(
                controller: controller.refreshController,
                enablePullDown: false,
                enablePullUp: true,
                onLoading: controller.onRefresh,
                footer: CustomFooter(
                  height: size.height(60),
                  builder: (context, mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = SizedBox();
                    } else if (mode == LoadStatus.loading) {
                      body = CircularProgressIndicator(
                        color: primaryBlackColor,
                      );
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Center(child: body),
                    );
                  },
                ),
                child: SingleChildScrollView(
                  controller: controller.scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.isListView = true;
                                  controller.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: controller.isListView
                                          ? shadowColor
                                          : whiteColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.list,
                                    color: iconColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              size.WidthSpace(10),
                              InkWell(
                                onTap: () {
                                  controller.isListView = false;
                                  controller.update();
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                      left: 5, right: 5, top: 5, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: controller.isListView
                                          ? whiteColor
                                          : shadowColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.grid_view,
                                    color: iconColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ShortByButton(
                                onTap: () {
                                  shortByBottomSheet(
                                      context, ProductListController());
                                },
                              ),
                              size.WidthSpace(10),
                              FilterButton(
                                onTap: () {
                                  filterBottomSheet(
                                      context, ProductListController());
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      size.HeightSpace(10),
                      controller.isListView
                          ? ListView.separated(
                              separatorBuilder: (context, index) {
                                return size.HeightSpace(10);
                              },
                              controller: controller.scrollController,
                              itemCount: controller.productDetailList.length,
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    Get.find<ProductDetailController>()
                                        .productDetail(
                                      productId: controller
                                              .productDetailList[index].id ??
                                          0,
                                      productsId: controller
                                          .productDetailList[index].relatedIds!
                                          .cast<int>(),
                                    );

                                    Get.to(ProductDetailScreen());
                                  },
                                  child: ProductListWidget(
                                    image: controller.productDetailList[index]
                                            .images!.isNotEmpty
                                        ? controller.productDetailList[index]
                                                .images?.first.src ??
                                            ""
                                        : "",
                                    price: controller
                                            .productDetailList[index].price ??
                                        "",
                                    productName: controller
                                            .productDetailList[index].name ??
                                        "",
                                    salePrice: controller
                                            .productDetailList[index]
                                            .salePrice ??
                                        "",
                                    discount: controller.isDiscount(
                                                controller
                                                    .productDetailList[index]
                                                    .price,
                                                controller
                                                    .productDetailList[index]
                                                    .salePrice) ==
                                            null
                                        ? ""
                                        : controller
                                            .isDiscount(
                                                controller
                                                    .productDetailList[index]
                                                    .price,
                                                controller
                                                    .productDetailList[index]
                                                    .salePrice)
                                            .toString(),
                                    ratingValue: controller
                                            .productDetailList[index]
                                            .averageRating ??
                                        "",
                                  ),
                                );
                              })
                          : GridView.builder(
                              itemCount: controller.productDetailList.length,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsets.zero,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 15,
                                childAspectRatio: 0.75,
                              ),
                              itemBuilder: (context, index) {
                                return GridProductCard(
                                    image: controller.productDetailList[index]
                                            .images!.isNotEmpty
                                        ? controller.productDetailList[index]
                                                .images?.first.src ??
                                            ""
                                        : "",
                                    ratingValue: controller
                                            .productDetailList[index]
                                            .averageRating ??
                                        "",
                                    title: controller
                                            .productDetailList[index].name ??
                                        "",
                                    price: controller
                                            .productDetailList[index].price ??
                                        "",
                                    salePrice: controller
                                            .productDetailList[index]
                                            .salePrice ??
                                        "",
                                    onTap: () {
                                      Get.find<ProductDetailController>()
                                          .productDetail(
                                        productId: controller
                                                .productDetailList[index].id ??
                                            0,
                                        productsId: controller
                                            .productDetailList[index]
                                            .relatedIds!
                                            .cast<int>(),
                                      );

                                      Get.to(ProductDetailScreen());
                                    });
                              },
                            ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
