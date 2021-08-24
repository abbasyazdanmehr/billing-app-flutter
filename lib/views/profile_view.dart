import 'package:billing_app/constants.dart';
import 'package:billing_app/views/home_views/accounts_list_view.dart';
import 'package:billing_app/views/profile_views/about_us_view.dart';
import 'package:billing_app/views/profile_views/my_notes_view.dart';
import 'package:billing_app/views/profile_views/profile_data_view.dart';
import 'package:billing_app/views/profile_views/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget choiceBlock(String choiceText) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 1,
        heightRatio: 0.12,
        content: TextButton(
          onPressed: () {
            if (choiceText == 'Profile Data') {
              Get.to(ProfileData());
            } else if (choiceText == 'Settings') {
              Get.to(Settings());
            } else if (choiceText == 'About Us') {
              Get.to(AboutUs());
            } else if (choiceText == 'My Bank Accounts') {
              Get.to(AccountsList());
            } else {
              Get.to(MyNotes());
            }
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              choiceText,
              style: TextStyle(
                color: Constants.darkColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.account_circle,
            color: Colors.black,
            size: 120.sp,
          ),
          choiceBlock('Profile Data'),
          choiceBlock('Settings'),
          choiceBlock('My Bank Accounts'),
          choiceBlock('About Us'),
          choiceBlock('My Notes'),
        ],
      ),
    );
  }
}
