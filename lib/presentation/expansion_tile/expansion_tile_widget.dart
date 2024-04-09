// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';

class ExpansionTileWidget extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const ExpansionTileWidget(
      {required this.title, required this.children, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: EdgeInsetsDirectional.only(start: 0, end: 5),
        iconColor: primaryBlackColor,
        initiallyExpanded: true,
        title: Text(
          title,
          style: TextStyle(
              fontSize: 20,
              color: primaryBlackColor,
              fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        children: children,
      ),
    );
  }
}
