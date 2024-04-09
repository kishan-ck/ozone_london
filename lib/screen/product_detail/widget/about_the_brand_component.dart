// // ignore_for_file: prefer_const_constructors
//
// import 'package:ck_woocommerce_api/Models/productDetailsDataModel.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ozone_london/constant/colors.dart';
// import 'package:ozone_london/constant/dynamic_size.dart';
// import 'package:ozone_london/presentation/network_image/netwok_image.dart';
//
// class AboutTheBrandComponent extends StatelessWidget {
//   final List<ProductBrand> productBrand;
//   const AboutTheBrandComponent({Key? key, required this.productBrand})
//       : super(key: key);
//
//   @override
//   Widget build(final BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Text('about_the_brand'.tr,
//               style: TextStyle(
//                   fontSize: 20,
//                   color: primaryBlackColor,
//                   fontWeight: FontWeight.bold)),
//           for (int i = 0; i < productBrand.length; i++)
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 size.HeightSpace(15),
//                 Center(
//                     child: CustomNetworkImage(
//                   image: productBrand[i].thumbnailId ?? "",
//                 )),
//                 size.HeightSpace(10),
//                 Text(productBrand[i].name ?? "",
//                     style: TextStyle(
//                         fontSize: 18,
//                         color: primaryBlackColor,
//                         fontWeight: FontWeight.bold)),
//                 size.HeightSpace(10),
//                 Text(productBrand[i].description ?? "",
//                     style: TextStyle(fontSize: 16, color: textColor)),
//               ],
//             ),
//         ],
//       ),
//     );
//   }
// }
