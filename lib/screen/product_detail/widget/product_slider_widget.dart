// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/product_detail_controller.dart';
import 'package:ozone_london/presentation/gallery/gallery_widget.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class ProductSliderComponent extends StatefulWidget {
  const ProductSliderComponent({Key? key}) : super(key: key);

  @override
  State<ProductSliderComponent> createState() => _ProductSliderComponentState();
}

class _ProductSliderComponentState extends State<ProductSliderComponent> {
  @override
  Widget build(final BuildContext context) {
    return GetBuilder(
      init: Get.find<ProductDetailController>(),
      builder: (controller) {
        return SafeArea(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(GalleryWidget(
                      pics: controller.productDetailModel?.images,
                      currentImageIndex: controller.currentImageIndex));
                },
                child: CarouselSlider.builder(
                  itemCount: controller.productDetailModel?.images?.length,
                  options: CarouselOptions(
                      aspectRatio: 1.3,
                      viewportFraction: 1,
                      autoPlay: false,
                      onPageChanged:
                          (int indexImage, CarouselPageChangedReason x) {
                        controller.currentImageIndex = indexImage;
                        controller.update();
                      }),
                  itemBuilder:
                      (BuildContext context, int index, int pageViewIndex) =>
                          Hero(
                              tag: controller
                                      .productDetailModel?.images?[index].src ??
                                  "",
                              child: CustomNetworkImage(
                                  image: controller.productDetailModel
                                          ?.images?[index].src ??
                                      "")),
                ),
              ),
              size.HeightSpace(30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  controller.productDetailModel?.images?.length ?? 0,
                  (index) => Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          controller.currentImageIndex != index
                              ? whiteColor
                              : primaryBlackColor,
                          controller.currentImageIndex != index
                              ? shadowColor
                              : primaryBlackColor,
                        ],
                      ),
                      shape: controller.currentImageIndex != index
                          ? BoxShape.circle
                          : BoxShape.rectangle,
                      borderRadius: controller.currentImageIndex != index
                          ? null
                          : BorderRadiusDirectional.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
