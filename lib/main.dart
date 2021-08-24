import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/views/base_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newTextTheme = Theme.of(context).textTheme.apply(
          bodyColor: Constants.textColor,
          displayColor: Constants.textColor,
          fontFamily: 'dubay',
        );

    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Billing App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Constants.themeColor,
          fontFamily: 'dubay',
          scaffoldBackgroundColor: Constants.backgroundsColor,
          textTheme: newTextTheme,
        ),
        home: BaseView(0),
      );
    });
  }
}
