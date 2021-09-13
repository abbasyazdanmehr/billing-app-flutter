import 'package:billing_app/constants/constants.dart';
import 'package:billing_app/enums/turnover_type.dart';
import 'package:billing_app/views/home_view.dart';
import 'package:billing_app/views/home_views/list_views/turnovers_list_view.dart';
import 'package:billing_app/views/profile_view.dart';
import 'package:billing_app/views/report_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BaseView extends StatefulWidget {
  final int index;
  BaseView(this.index);

  @override
  _BaseViewState createState() => _BaseViewState();
}

class _BaseViewState extends State<BaseView> {
  int _selectedIndex = 0;
  final box = GetStorage();

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

  Widget drawerContent() {
    return Center(
      child: ElevatedButton(
        child: Text('All Turnovers'),
        onPressed: () {
          Navigator.pop(context);
          box.write('turnoverIndex', TurnoverType.All.index);
          Get.to(() => TurnoversListView());
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size.width.toString() + 'px');
    print(size.height.toString() + 'px');
    return Scaffold(
      drawer: Drawer(
        child: drawerContent(),
      ),
      appBar: Constants.customAppBar(),
      body: Stack(
        children: [
          Container(
            width: size.width,
            height: size.height,
          ),
          showScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 5,
        type: BottomNavigationBarType.shifting,
        backgroundColor: Constants.themeColor,
        selectedItemColor: Constants.textColor,
        unselectedItemColor: Constants.lightColor,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Constants.themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.note),
            label: 'Report',
            backgroundColor: Constants.themeColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            backgroundColor: Constants.themeColor,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
