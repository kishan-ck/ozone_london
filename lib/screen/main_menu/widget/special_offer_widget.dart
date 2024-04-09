// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class SpecialOffersComponent extends StatelessWidget {
  const SpecialOffersComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: size.height(150),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: whiteColor, borderRadius: BorderRadius.circular(10)),
        width: double.infinity,
        child: Image.asset('assets/images/ic_offer.png'),
      ),
    );
  }
}
