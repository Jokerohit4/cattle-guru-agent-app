// ignore_for_file: must_be_immutable

import 'package:cattle_guru_agent_app/screens/Details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Earnings/My_earnings_screen.dart';
import 'package:cattle_guru_agent_app/screens/Home_screen.dart';
import 'package:cattle_guru_agent_app/screens/Orders/Order_details_screen.dart';
import 'package:cattle_guru_agent_app/screens/Products_screen.dart';
import 'package:cattle_guru_agent_app/utils/Colors.dart';
import 'package:cattle_guru_agent_app/utils/Strings.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  late int tabIndex;
  NavigationScreen({super.key, this.tabIndex = 2});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  void changeTabIndex(int index) {
    setState(() {
      widget.tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: widget.tabIndex,
          children: const [
            HomeScreen(),
            OrderDetailsScreen(),
            ProductsScreen(),
            MyEarningsScreen(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide(color: kPrimaryColor)),
        ),
        height: 80,
        child: BottomNavigationBar(
          unselectedItemColor: Colors.black,
          selectedItemColor: kPrimaryColor,
          onTap: changeTabIndex,
          iconSize: 15.0,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: widget.tabIndex,
          items: [
            _bottomNavigationBarItem(
              icon: home,
              selected: widget.tabIndex == 0 ? true : false,
              label: "Home",
            ),
            _bottomNavigationBarItem(
              icon: fornewcustomer,
              selected: widget.tabIndex == 1 ? true : false,
              label: "New Orders",
            ),
            _bottomNavigationBarItem(
              selected: widget.tabIndex == 2 ? true : false,
              icon: productsic,
              label: "Products",
            ),
            _bottomNavigationBarItem(
              selected: widget.tabIndex == 3 ? true : false,
              icon: earnings,
              label: "My Earnings",
            ),
          ],
        ),
      ),
    );
  }

  _bottomNavigationBarItem({required String icon, required String label,required bool selected}) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        icon,
        scale: 1.7,
        height: 28,
        color: Colors.black54,
      ),
      activeIcon:
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
        ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(icon, scale: 1, height: 30, color: Colors.white),
            )),
      label: label,
    );
  }
}
