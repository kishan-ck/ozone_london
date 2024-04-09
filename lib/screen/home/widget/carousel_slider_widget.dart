// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';

class CarouselSliderWidget extends StatelessWidget {
  CarouselSliderWidget({Key? key}) : super(key: key);

  int i = -1;
  final List<String> imgList = [
    'assets/images/h7_slide_mobile_01b.jpg',
    'assets/images/h7_slide_mobile_02b.jpg',
    'assets/images/h7_slide_mobile_03b.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
          aspectRatio: 1.8,
          // enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true),
      items: imgList.map((e) {
        i++;
        return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                child: Image.asset(e, fit: BoxFit.fill)));
      }).toList(),
    );
  }
}
