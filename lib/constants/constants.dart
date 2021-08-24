import 'package:billing_app/views/profile_views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:sizer/sizer.dart';

class Constants {
  static const Color themeColor = Colors.green;
  static const Color detailColor = Colors.deepPurple;
  static const Color hideColor = Colors.teal;
  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.amber;

  static Widget customAppBar() {
    return AppBar(
      title: Text('Billing'),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(SettingsView());
            },
            icon: Icon(Icons.settings))
      ],
    );
  }

  static isInteger(String string) {
    if (string == null || string.isEmpty) {
      return false;
    }
    final number = int.tryParse(string);

    if (number == null) {
      return false;
    }

    return true;
  }

  static Widget responsiveGlassBlock(
      {BuildContext context, heightRatio, widthRatio, Widget content}) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 0.005 * size.height, horizontal: 0.005 * size.width),
      child: Container(
        width: size.width * widthRatio,
        height: size.height * heightRatio,
        child: GlassmorphicContainer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: 10,
          blur: 20,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.8),
                Color(0xFFFFFFFF)
                    .withOpacity(0.01), // low: glass   high: plastic
              ],
              stops: [
                0.3,
                0.8, // low: glass   high: plastic
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.3),
              Color((0xFFFFFFFF)).withOpacity(0.1),
            ],
          ),
          child: content,
        ),
      ),
    );
  }
}
