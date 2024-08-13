// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hpaan_viewpoint/pages/home_page/home_page.dart';
import 'package:hpaan_viewpoint/pages/profile_page/profile_page.dart';
import 'package:hpaan_viewpoint/pages/search_page/search_page.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<dynamic> _page = [
    const HomePage(),
    const SearchPage(),
    const ProfilePage(),
  ];
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        //color: Colors.blueAccent,
        child: _page[_activePage],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0.4,
        selectedItemColor: Colors.teal,
        selectedIconTheme: const IconThemeData(size: 25),
        selectedLabelStyle: const TextStyle(
          fontFamily: "SF-Pro",
          fontSize: 12,
        ),
        currentIndex: _activePage,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_rounded,
              size: 26,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.search,
              size: 24,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_rounded,
              size: 26,
            ),
            label: "Profile",
          ),
        ],
        onTap: (value) {
          setState(() {
            _activePage = value;
          });
        },
      ),
    );
  }
}
