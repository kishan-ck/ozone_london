// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/controller/home_controller.dart';
import 'package:ozone_london/controller/product_category_controller.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/controller/product_list_controller.dart';
import 'package:ozone_london/presentation/common_appbar/page_appbar.dart';
import 'package:ozone_london/presentation/connectivity/connection_error_widget.dart';
import 'package:ozone_london/screen/product/short_by_button.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constant/dynamic_size.dart';
import '../filter/filter_button.dart';
import '../filter/widget/filter_bottom_sheet.dart';
import '../product/widget/product_list_widget.dart';
import '../product/widget/short_by_widget.dart';

class CategoryListScreen extends StatelessWidget {
  final String title;
  final int id;

  const CategoryListScreen({super.key, required this.title, required this.id});

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
        init: Get.find<ProductCategoryController>(),
        builder: (controller) {
          return Scaffold(
            appBar: commonPageAppBar(title: title),
            backgroundColor: backgroundColor,
            body: controller.isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: primaryBlackColor,
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(10),
                    child: SmartRefresher(
                      controller: controller.refreshController,
                      enablePullDown: false,
                      enablePullUp: true,
                      onLoading: () {
                        controller.onRefresh(categoryId: id);
                      },
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
                      child: controller.productDetailList.isEmpty
                          ? Center(
                              child: Text("no_data_found".tr),
                            )
                          : SingleChildScrollView(
                              controller: controller.scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
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
                                  size.HeightSpace(10),
                                  ListView.separated(
                                      separatorBuilder: (context, index) {
                                        return size.HeightSpace(10);
                                      },
                                      controller: controller.scrollController,
                                      itemCount:
                                          controller.productDetailList.length,
                                      shrinkWrap: true,
                                      padding: EdgeInsets.zero,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Get.find<ProductDetailController>()
                                                .productDetail(
                                              productId: controller
                                                      .productDetailList[index]
                                                      .id ??
                                                  0,
                                              productsId: controller
                                                  .productDetailList[index]
                                                  .relatedIds!
                                                  .cast<int>(),
                                            );

                                            Get.to(ProductDetailScreen());
                                          },
                                          child: ProductListWidget(
                                            image: controller
                                                    .productDetailList[index]
                                                    .images
                                                    ?.first
                                                    .src
                                                    .toString() ??
                                                "",
                                            price: controller
                                                    .productDetailList[index]
                                                    .price ??
                                                "",
                                            productName: controller
                                                    .productDetailList[index]
                                                    .name ??
                                                "",
                                            salePrice: controller
                                                    .productDetailList[index]
                                                    .salePrice ??
                                                "",
                                            discount: controller.isDiscount(
                                                        controller
                                                            .productDetailList[
                                                                index]
                                                            .price,
                                                        controller
                                                            .productDetailList[
                                                                index]
                                                            .salePrice) ==
                                                    null
                                                ? ""
                                                : controller
                                                    .isDiscount(
                                                        controller
                                                            .productDetailList[
                                                                index]
                                                            .price,
                                                        controller
                                                            .productDetailList[
                                                                index]
                                                            .salePrice)
                                                    .toString(),
                                            ratingValue: controller
                                                    .productDetailList[index]
                                                    .averageRating ??
                                                "",
                                          ),
                                        );
                                      }),
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
