// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/custom_rating/custom_rating.dart';

class ProductQuestionAnswerWidget extends StatelessWidget {
  final String name;
  final String date;
  final String question;
  final String reply;
  final Function()? replyOnTap;

  const ProductQuestionAnswerWidget(
      {Key? key,
      required this.name,
      required this.date,
      required this.question,
      required this.reply,
      this.replyOnTap})
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
            ],
          ),
          size.HeightSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                question,
                style: TextStyle(color: textColor),
              ),
              InkWell(
                onTap: replyOnTap,
                child: Text(
                  reply,
                  style: TextStyle(fontSize: 18, color: primaryBlackColor),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          size.HeightSpace(15),
        ],
      ),
    );
  }
}
