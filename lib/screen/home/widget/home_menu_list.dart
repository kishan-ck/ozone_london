// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ozone_london/constant/colors.dart';
// import 'package:ozone_london/constant/dynamic_size.dart';
// import 'package:ozone_london/controller/home_controller.dart';
//
// class HomeMenuList extends StatelessWidget {
//   const HomeMenuList({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder(
//       init: Get.find<HomeController>(),
//       builder: (controller) {
//         return SizedBox(
//           height: size.height(50),
//           child: ListView.separated(
//               itemCount: controller.homeMenuList.length,
//               scrollDirection: Axis.horizontal,
//               padding: EdgeInsetsDirectional.fromSTEB(size.height(25),
//                   size.height(10), size.height(25), size.height(10)),
//               separatorBuilder: (_, __) => SizedBox(width: size.width(25)),
//               itemBuilder: (final context, final index) {
//                 return Align(
//                   alignment: AlignmentDirectional.bottomCenter,
//                   child: InkWell(
//                     onTap: () {
//                       controller.selectedIndex.value = index;
//                       controller.update();
//                     },
//                     child: Text(controller.homeMenuList[index],
//                         style: Theme.of(context).textTheme.headline6!.copyWith(
//                               color: controller.selectedIndex.value == index
//                                   ? primaryBlackColor
//                                   : inActiveIconColor,
//                               fontSize: controller.selectedIndex.value == index
//                                   ? 22
//                                   : 18,
//                               fontWeight:
//                                   controller.selectedIndex.value == index
//                                       ? FontWeight.w600
//                                       : FontWeight.w500,
//                             )),
//                   ),
//                 );
//               }),
//         );
//       },
//     );
//   }
// }
