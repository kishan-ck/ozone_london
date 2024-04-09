// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';

class BasicProductCardWidget extends StatelessWidget {
  final String title;
  final String image;
  final String price;
  final VoidCallback onTap;

  const BasicProductCardWidget({
    Key? key,
    required this.title,
    required this.image,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: FittedBox(
        child: SizedBox(
          width: size.width(130),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height(130),
                width: size.width(130),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(
                    image: image,
                  ),
                ),
              ),
              size.HeightSpace(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        // fontSize: 16,
                        color: primaryBlackColor,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis),
                  size.HeightSpace(5),
                  Text(price,
                      style: TextStyle(
                          // fontSize: 16,
                          color: primaryBlackColor,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
