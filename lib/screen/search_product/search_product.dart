// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../constant/colors.dart';
import '../../constant/dynamic_size.dart';
import '../../controller/product_detail_controller.dart';
import '../../controller/product_list_controller.dart';
import '../../controller/searchController.dart';
import '../filter/filter_button.dart';
import '../filter/widget/filter_bottom_sheet.dart';
import '../product/short_by_button.dart';
import '../product/widget/product_list_widget.dart';
import '../product/widget/short_by_widget.dart';
import '../product_detail/product_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<searchController>(),
      builder: (controller) {
        return Container(
          margin: EdgeInsets.all(10),
          child: controller.isSearchLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: primaryBlackColor,
                  ),
                )
              : SmartRefresher(
                  controller: refreshController,
                  enablePullDown: false,
                  enablePullUp: true,
                  onLoading: () async {
                    await controller.onRefresh().then((value) {
                      refreshController.refreshCompleted();
                      refreshController.loadComplete();
                      refreshController.resetNoData();
                    });
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
                  child: SingleChildScrollView(
                    controller: controller.scrollController,
                    child: controller.productDetailList.isEmpty
                        ? Center(
                            child: Text("no_data_found".tr),
                          )
                        : Column(
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
        );
      },
    );
  }
}
