// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:ozone_london/constant/colors.dart';

class CheckboxListTileWidget extends StatelessWidget {
  final String title;
  final bool value;
  final Function(bool val) onChanged;

  const CheckboxListTileWidget(
      {required this.title,
      required this.value,
      required this.onChanged,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      contentPadding: EdgeInsets.zero,
      activeColor: primaryBlackColor,
      title: Text(title,
          style: TextStyle(fontSize: 18, color: primaryBlackColor),
          maxLines: 1,
          overflow: TextOverflow.ellipsis),
      onChanged: (bool? val) => onChanged(val!),
    );
  }
}
