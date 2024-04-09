// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';

import '../../../presentation/network_image/netwok_image.dart';

class ProductListWidget extends StatelessWidget {
  final String image;
  final String productName;
  final String price;
  final String salePrice;
  final String discount;
  final String ratingValue;

  const ProductListWidget({
    Key? key,
    required this.image,
    required this.productName,
    required this.price,
    required this.salePrice,
    required this.discount,
    required this.ratingValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: size.height(130),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, blurRadius: 2, offset: Offset(2, 1)),
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: whiteColor),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                height: size.height(130),
                width: size.width(130),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(image: image),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(productName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          CustomRating(
                              size: 15,
                              initialRating: double.parse(ratingValue)),
                          size.WidthSpace(5),
                          Text(
                            '($ratingValue)',
                            style: TextStyle(color: textColor),
                          )
                        ],
                      ),
                      salePrice.isEmpty || discount.isEmpty || discount == "0"
                          ? SizedBox()
                          : Text(salePrice,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: textColor,
                                  decoration: TextDecoration.lineThrough)),
                      Row(
                        children: [
                          price.isEmpty
                              ? SizedBox()
                              : Text(price,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: primaryBlackColor,
                                  )),
                          size.WidthSpace(10),
                          discount.isEmpty || discount == "0"
                              ? SizedBox()
                              : Text('$discount% off',
                                  style: TextStyle(
                                      fontSize: 16, color: primaryBlackColor)),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
