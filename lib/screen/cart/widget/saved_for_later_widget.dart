// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/presentation/common_button/app_button.dart';

class SavedForLaterWidget extends StatefulWidget {
  const SavedForLaterWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SavedForLaterWidget> createState() => _SavedForLaterWidgetState();
}

class _SavedForLaterWidgetState extends State<SavedForLaterWidget> {
  bool _isFavorite = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'saved_for_later'.tr,
          style: TextStyle(
              fontSize: 22,
              color: primaryBlackColor,
              fontWeight: FontWeight.bold),
        ),
        size.HeightSpace(15),
        SizedBox(
          height: size.height(230),
          child: ListView.separated(
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, __) => size.WidthSpace(20),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {},
              child: FittedBox(
                child: SizedBox(
                  width: size.width(250),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topEnd,
                        children: [
                          Image.network(
                            'https://cdn2.dumyah.com/image/cache/data/2022/05/1653130074297907869-520x520.jpg',
                            width: double.infinity,
                          ),
                          IconButton(
                            onPressed: () =>
                                setState(() => _isFavorite = !_isFavorite),
                            padding: EdgeInsets.zero,
                            icon: _isFavorite
                                ? Icon(
                                    Icons.favorite_rounded,
                                    color: primaryBlackColor,
                                    size: 30,
                                  )
                                : Icon(
                                    Icons.favorite_border_rounded,
                                    color: textColor,
                                    size: 30,
                                  ),
                          ),
                        ],
                      ),
                      size.HeightSpace(10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ball',
                              style: TextStyle(
                                  color: primaryBlackColor, fontSize: 16),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          size.HeightSpace(10),
                          Text('94.00',
                              style: TextStyle(
                                  color: primaryBlackColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                              overflow: TextOverflow.ellipsis),
                          size.HeightSpace(15),
                          AppButton(
                            buttonText: 'add_to_cart'.tr,
                            onPressed: () {},
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
