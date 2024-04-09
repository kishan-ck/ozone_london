// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class Product2x2CardWidget extends StatelessWidget {
  final String image;
  final String productName;
  final String price;

  const Product2x2CardWidget(
      {Key? key,
      required this.image,
      required this.productName,
      required this.price})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
          color: kBackgroundCardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                height: size.height(150),
                width: size.width(150),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(image: image),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(productName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  // Html(data: """$price"""),
                  Text(
                    price,
                    style: TextStyle(color: primaryBlackColor, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
