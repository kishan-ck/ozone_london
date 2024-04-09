// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:ozone_london/constant/colors.dart';

class CustomRating extends StatelessWidget {
  final double size;
  final double initialRating;
  final AlignmentDirectional alignment;
  final Function? onRatingUpdate;
  final bool ignoreGestures;
  final Color? unratedColor;

  const CustomRating({
    this.onRatingUpdate,
    this.initialRating = 0,
    this.size = 30,
    this.alignment = AlignmentDirectional.centerStart,
    this.ignoreGestures = true,
    this.unratedColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: RatingBar(
        initialRating: initialRating,
        allowHalfRating: true,
        itemSize: size,
        ignoreGestures: ignoreGestures,
        glowColor: primaryBlackColor,
        ratingWidget: RatingWidget(
          full: Icon(
            Icons.star,
            color: iconColor,
          ),
          half: Icon(
            Icons.star_half,
            color: iconColor,
          ),
          empty: Icon(
            Icons.star_border_outlined,
            color: iconColor,
          ),
        ),
        onRatingUpdate: (rating) => onRatingUpdate!(rating),
      ),
    );
  }
}
