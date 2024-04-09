// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/screen/main_menu/widget/categories_section_widget.dart';
import 'package:ozone_london/screen/main_menu/widget/special_offer_widget.dart';

import '../../constant/dynamic_size.dart';

class mainMenuCategory extends StatelessWidget {
  const mainMenuCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          size.HeightSpace(30),
          CategoriesSection(),
          size.HeightSpace(30),
          SpecialOffersComponent(),
          size.HeightSpace(30),
        ],
      ),
    );
  }
}
