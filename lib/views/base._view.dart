import 'package:billing_app/constants.dart';
import 'package:billing_app/views/home_view.dart';
import 'package:billing_app/views/profile_view.dart';
import 'package:billing_app/views/report_view.dart';
import 'package:flutter/material.dart';

class BaseView extends StatefulWidget {
  final int index;
  BaseView(this.index);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;

  @override
  initState() {
    super.initState();
    _selectedIndex = widget.index;
  }

  Widget showScreen() {
    if (_selectedIndex == 0) {
      return HomeView();
    } else if (_selectedIndex == 1) {
      return ReportView();
    } else {
      return ProfileView();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width.toString() + 'px');
    print(size.height.toString() + 'px');
    return Scaffold(
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
            child: Image.asset(
              'assets/images/colori.jpg',
              fit: BoxFit.fill,
            ),
          ),
          showScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Constants.themeColor,
        selectedItemColor: Constants.detailColor,
        unselectedItemColor: Constants.darkColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Constants.themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Report',
            backgroundColor: Constants.hideColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Constants.lightColor,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
