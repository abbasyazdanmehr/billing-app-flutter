import 'package:billing_app/views/profile_views/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Constants {
  static const Color themeColor = Colors.cyan;
  static const Color textColor = Colors.black;
  static const Color backgroundsColor = Colors.white;
  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.grey;

  static Widget customAppBar() {
    return AppBar(
      title: Text('Billing'),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {
              Get.to(() => SettingsView());
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
          blur: 5,
          alignment: Alignment.bottomCenter,
          border: 2,
          linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFffffff).withOpacity(0.3),
                Color(0xFFFFFFFF).withOpacity(0.1),
              ],
              stops: [
                0.1,
                0.9
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            colors: [
              Color(0xFFffffff).withOpacity(0.5),
              Color((0xFFFFFFFF)).withOpacity(0.5),
            ],
          ),
          child: content,
        ),
      ),
    );
  }
}
