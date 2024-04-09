// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/common_text_field/text_field.dart';

class OrderNoteWidget extends StatelessWidget {
  final TextEditingController noteController;

  const OrderNoteWidget({super.key, required this.noteController});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "add_note_for_seller".tr,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: primaryBlackColor),
              ),
              Text(
                "save".tr,
                style: TextStyle(color: textColor, fontSize: 18),
              )
            ],
          ),
          size.HeightSpace(3),
          appTextField(
              textEditingController: noteController,
              inputType: TextInputType.multiline,
              maxLines: 4,
              hintText: 'note_about_your_order'.tr)
        ],
      ),
    );
  }
}
