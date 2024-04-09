// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ozone_london/constant/app_language.dart';
import 'package:ozone_london/constant/behavior/my_behavior.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/root_binding/initial_root_binding.dart';
import 'package:ozone_london/screen/splash/splash_screen.dart';

Future<void> main() async {
  await GetStorage.init();
  Stripe.publishableKey =
      "pk_test_51MVlbaIKGm5xzOMezu111SNVY6ccK1cJQ6BtLMwlLwHQYKTmqHCcdmJUCor14YF7M7WGxnEW2qDwZs1JkWJOSm8N00Vg2GYYc0";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'app_name'.tr,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Jost',
        ),
        locale: Get.deviceLocale,
        translations: AppTranslation(),
        fallbackLocale: Locale('en', 'US'),
        initialBinding: RootBinding(),
        builder: (context, child) {
          return ScrollConfiguration(
            behavior: MyBehavior(),
            child: child!,
          );
        },
        home: SplashScreen(),
      ),
    );
  }
}
