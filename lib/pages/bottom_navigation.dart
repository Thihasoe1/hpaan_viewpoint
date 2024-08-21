// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpaan_viewpoint/pages/favourite_page/favourite_page.dart';
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
    const FavouritePage(),
    const ProfilePage(),
  ];
  int _activePage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 250, 1),
      body: SizedBox(
        child: _page[_activePage],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          HapticFeedback.mediumImpact();
          setState(() {
            _activePage = index;
          });
        },
        indicatorColor: Colors.teal.shade300,
        selectedIndex: _activePage,
        destinations: const [
          NavigationDestination(
            selectedIcon: Icon(
              Icons.home_rounded,
              color: Colors.white,
            ),
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.search_outlined,
              color: Colors.white,
            ),
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.favorite_rounded,
              color: Colors.white,
            ),
            icon: Icon(Icons.favorite_outline_rounded),
            label: 'Favourite',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            icon: Icon(Icons.account_circle_outlined),
            label: 'Profile',
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.4,
      //   selectedItemColor: Colors.teal,
      //   selectedIconTheme: const IconThemeData(size: 25),
      //   selectedLabelStyle: const TextStyle(
      //     fontFamily: "SF-Pro",
      //     fontSize: 12,
      //   ),
      //   unselectedItemColor: Colors.grey.shade400,
      //   currentIndex: _activePage,
      //   type: BottomNavigationBarType.fixed,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_rounded,
      //         size: 26,
      //       ),
      //       label: "Home",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         CupertinoIcons.search,
      //         size: 24,
      //       ),
      //       label: "Search",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.favorite_outline_rounded,
      //         size: 24,
      //       ),
      //       label: "Favourite",
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.account_circle_rounded,
      //         size: 26,
      //       ),
      //       label: "Profile",
      //     ),
      //   ],
      //   onTap: (value) {
      //     setState(() {
      //       _activePage = value;
      //     });
      //   },
      // ),
    );
  }
}
