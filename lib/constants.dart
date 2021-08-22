import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';

class Constants {
  static const Color themeColor = Colors.green;
  static const Color detailColor = Colors.white;
  static const Color hideColor = Colors.brown;
  static const Color darkColor = Colors.black;
  static const Color lightColor = Colors.amber;

  static Widget simpleBlock(height, width, String myText) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.fromLTRB(10, 3, 10, 3),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: 10,
        blur: 25,
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
              0.4, // low: glass   high: plastic
            ]),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFffffff).withOpacity(0.3),
            Color((0xFFFFFFFF)).withOpacity(0.1),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              myText,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
