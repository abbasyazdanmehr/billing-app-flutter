import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/views/home_views/list_views/accounts_list_view.dart';
import 'package:billing_app/views/profile_views/about_us_view.dart';
import 'package:billing_app/views/profile_views/notes_list_view.dart';
import 'package:billing_app/views/profile_views/personal_data_view.dart';
import 'package:billing_app/views/profile_views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget choiceBlock(String choiceText) {
      return Constants.responsiveGlassBlock(
        context: context,
        widthRatio: 0.8,
        heightRatio: 0.13,
        content: TextButton(
          onPressed: () {
            if (choiceText == 'Edit Profile') {
              Get.to(() => PersonalDataView());
            } else if (choiceText == 'Settings') {
              Get.to(() => SettingsView());
            } else if (choiceText == 'About Us') {
              Get.to(() => AboutUsView());
            } else if (choiceText == 'Bank Accounts') {
              Get.to(() => AccountsListView());
            } else {
              Get.to(() => NotesListView());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(5),
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
        ),
      );
    }

    blocks() {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            choiceBlock('Edit Profile'),
            choiceBlock('Settings'),
            choiceBlock('Bank Accounts'),
            choiceBlock('About Us'),
            choiceBlock('My Notes'),
          ],
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Constants.responsiveGlassBlock(
              context: context,
              heightRatio: 0.73,
              widthRatio: 0.9,
              content: blocks(),
            ),
          ],
        ),
      ),
    );
  }
}
