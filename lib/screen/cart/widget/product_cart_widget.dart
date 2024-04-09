// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/network_image/netwok_image.dart';
import 'package:ozone_london/screen/cart/model/cart_data_model.dart';

class ProductCartWidget extends StatelessWidget {
  final CartDataModel cartData;

  const ProductCartWidget({
    Key? key,
    required this.cartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(top: 10),
            height: size.height(130),
            decoration: BoxDecoration(
                boxShadow: AppShadows.buttonBoxShadow,
                color: whiteColor,
                borderRadius: BorderRadius.circular(15)),
            child: CustomNetworkImage(
              image: cartData.image ?? "",
            ),
          ),
        ),
        size.WidthSpace(15),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(cartData.name ?? 'Jenna Raffia Straw',
                    style: TextStyle(fontSize: 16, color: primaryBlackColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                size.HeightSpace(3),
                Text(cartData.price ?? '\$94.00',
                    style: TextStyle(
                        fontSize: 16,
                        color: primaryBlackColor,
                        fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                (cartData.selectedSize == null || cartData.selectedSize == "")
                    ? SizedBox()
                    : Row(
                        children: [
                          Text(
                              cartData.selectedSize == null ||
                                      cartData.selectedSize == ""
                                  ? ''
                                  : "Size: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Text(cartData.selectedSize ?? '',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
                (cartData.selectedColor == null || cartData.selectedColor == "")
                    ? SizedBox()
                    : Row(
                        children: [
                          Text(
                              cartData.selectedColor == null ||
                                      cartData.selectedColor == ""
                                  ? ''
                                  : "Color: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.w400),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          Text(cartData.selectedColor ?? '',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
