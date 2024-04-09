// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';

class SeeMoreButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;

  const SeeMoreButton({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Container(
      alignment: AlignmentDirectional.center,
      decoration: BoxDecoration(
        boxShadow: AppShadows.buttonBoxShadow,
        color: whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            width: double.infinity,
            height: size.height(50),
            alignment: AlignmentDirectional.center,
            child: Text(
              title,
              style: TextStyle(color: primaryBlackColor, fontSize: 18),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
