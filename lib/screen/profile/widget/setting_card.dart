// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ozone_london/constant/app_shadow.dart';
import 'package:ozone_london/constant/colors.dart';
import 'package:ozone_london/constant/dynamic_size.dart';
import 'package:ozone_london/controller/profile_controller.dart';

class SettingsCard extends StatefulWidget {
  const SettingsCard({Key? key}) : super(key: key);

  @override
  State<SettingsCard> createState() => _SettingsCardState();
}

class _SettingsCardState extends State<SettingsCard> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: Get.find<ProfileController>(),
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("setting".tr,
                style: TextStyle(color: grayColor, fontSize: 18)),
            size.HeightSpace(10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: whiteColor,
                boxShadow: AppShadows.buttonBoxShadow,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text("notification".tr,
                        style: TextStyle(fontSize: 16, color: textColor)),
                    leading: Icon(
                      Icons.notifications_outlined,
                      color: iconColor,
                    ),
                    trailing: Transform.scale(
                      scale: 0.85,
                      child: CupertinoSwitch(
                          value: controller.notificationStatus,
                          onChanged: (newStatus) {
                            controller.notificationStatus = newStatus;
                            controller.update();
                          },
                          activeColor: iconColor),
                    ),
                    horizontalTitleGap: 12,
                    onTap: () {
                      controller.notificationStatus =
                      !controller.notificationStatus;
                      controller.update();
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text("send_us_feedback".tr,
                        style: TextStyle(fontSize: 16, color: textColor)),
                    leading: Icon(
                      Icons.message,
                      color: iconColor,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    horizontalTitleGap: 12,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
