// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class WishlistWidget extends StatelessWidget {
  final String productName;
  final String productPrise;
  final String productDate;
  final String productImage;
  final String productVariation;
  final void Function() removeWishlistTap;
  final void Function() productVariationTap;

  const WishlistWidget(
      {super.key,
      required this.productName,
      required this.productPrise,
      required this.productDate,
      required this.productImage,
      required this.removeWishlistTap,
      required this.productVariation,
      required this.productVariationTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 0.0, right: 0.0),
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
            margin: EdgeInsets.only(top: 13.0, right: 8.0),
            decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: AppShadows.buttonBoxShadow,
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              children: [
                Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style: TextStyle(fontSize: 17),
                        ),
                        size.HeightSpace(5),
                        productPrise.isNotEmpty
                            ? Text(productPrise,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: primaryBlackColor))
                            : SizedBox(),
                        productPrise.isNotEmpty
                            ? size.HeightSpace(5)
                            : SizedBox(),
                        Text(productDate, style: TextStyle(color: textColor)),
                        size.HeightSpace(8),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: backgroundColor,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: primaryBlackColor),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          onPressed: productVariationTap,
                          child: Text(
                            productVariation,
                            style: TextStyle(
                                color: primaryBlackColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: EdgeInsets.all(10),
                  height: size.height(130),
                  width: size.width(130),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(
                      image: productImage,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            child: InkWell(
              onTap: removeWishlistTap,
              child: Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 14.0,
                  backgroundColor: whiteColor,
                  child: Icon(Icons.close, color: iconColor, size: 16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
