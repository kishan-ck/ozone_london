// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class GridProductCard extends StatelessWidget {
  final String image;
  final String title;
  final String price;
  final String salePrice;
  final VoidCallback onTap;
  final String ratingValue;

  const GridProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.salePrice,
    required this.onTap,
    required this.ratingValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            // size.HeightSpace(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryBlackColor,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  size.HeightSpace(5),
                  CustomRating(
                      initialRating: double.parse(ratingValue), size: 15),
                  size.HeightSpace(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          price,
                          style:
                              TextStyle(fontSize: 16, color: primaryBlackColor),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      size.WidthSpace(5),
                      Expanded(
                        child: Text(
                          salePrice != '0.0 JOD' ? salePrice : '',
                          style: TextStyle(
                            fontSize: 14,
                            color: textColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  size.HeightSpace(5),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
