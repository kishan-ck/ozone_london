import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomNetworkImage extends StatelessWidget {
  final String image;
  final double? width;

  const CustomNetworkImage({
    Key? key,
    required this.image,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width,
      fit: BoxFit.cover,
      placeholder: (context, url) => SvgPicture.asset(
        "assets/images/ic_image_placeholder.svg",
      ),
      errorWidget: (context, url, error) => SvgPicture.asset(
        "assets/images/ic_image_placeholder.svg",
      ),
    );
  }
}
