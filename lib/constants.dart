import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Constants {
  static const Color themeColor = Colors.green;
  static const Color detailColor = Colors.white;
  static const Color hideColor = Colors.brown;
  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.amber;

  static Widget customAppBar() {
    return AppBar(
      title: Text('Billing'),
      centerTitle: true,
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
    );
  }

  static Widget responsiveGlassBlock(
      {BuildContext context, heightRatio, widthRatio, Widget content}) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(0.01 * size.width),
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
                Color(0xFFffffff).withOpacity(0.5),
                Color(0xFFFFFFFF)
                    .withOpacity(0.001), // low: glass   high: plastic
              ],
              stops: [
                0.1,
                0.5, // low: glass   high: plastic
              ]),
          borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFffffff).withOpacity(0.3),
              Color((0xFFFFFFFF)).withOpacity(0.1),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: content,
          ),
        ),
      ),
    );
  }
}
