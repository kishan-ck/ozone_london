// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';

class ProductReviewCardWidget extends StatelessWidget {
  final String name;
  final String date;
  final double ratingValue;
  final String review;

  const ProductReviewCardWidget(
      {Key? key,
      required this.name,
      required this.date,
      required this.ratingValue,
      required this.review})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 18, color: primaryBlackColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  size.WidthSpace(15),
                  Text(date,
                      style: TextStyle(
                        fontSize: 16,
                        color: textColor,
                      )),
                ],
              ),
              size.HeightSpace(5),
              CustomRating(initialRating: ratingValue, size: 15),
            ],
          ),
          size.HeightSpace(15),
          Html(data: review),
          size.HeightSpace(15),
        ],
      ),
    );
  }
}
