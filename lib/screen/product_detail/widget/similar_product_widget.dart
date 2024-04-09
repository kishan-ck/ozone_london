// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/common_product_cell/basic_product_card.dart';
import 'package:ozone_london/screen/product_detail/product_detail_screen.dart';

class SimilarProductsComponent extends StatelessWidget {
  const SimilarProductsComponent({
    Key? key,
  }) : super(key: key);

  @override
  build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return controller.productDetailDataList!.isNotEmpty
            ? Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 5, horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "you_may_also_like".tr,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    size.HeightSpace(15),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: size.height(250),
                      child: ListView.separated(
                        itemCount: controller.productDetailDataList!.length,
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        controller: controller.scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 0),
                        separatorBuilder: (_, __) => size.WidthSpace(15),
                        itemBuilder: (final context, final index) =>
                            BasicProductCardWidget(
                          title:
                              controller.productDetailDataList?[index].name ??
                                  "",
                          image:
                              controller.productDetailDataList?[index].images !=
                                      null
                                  ? controller.productDetailDataList![index]
                                          .images?.first.src ??
                                      ""
                                  : "",
                          price:
                              '\$${controller.productDetailDataList?[index].price ?? controller.productDetailDataList?[index].salePrice}',
                          onTap: () {
                            Get.find<ProductDetailController>().productDetail(
                              productId:
                                  controller.productDetailDataList?[index].id ??
                                      0,
                              productsId: controller
                                  .productDetailDataList![index].relatedIds!
                                  .cast<int>(),
                            );
                            Get.to(ProductDetailScreen());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : SizedBox();
      },
    );
  }
}
