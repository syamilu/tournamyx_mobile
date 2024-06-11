import 'package:flutter/material.dart';

import 'package:tournamyx_mobile/features/auth/screen/login.dart';
import 'package:tournamyx_mobile/features/favourites/screen/favourite_page.dart';
import 'package:tournamyx_mobile/features/home/screen/home_screen.dart';

//type or model for bottombar
class BottomBarItem {
  final String label;
  final Icon icon;
  final Icon iconOutline;
  final Widget screen;
  final GlobalKey? key;

  BottomBarItem({
    required this.label,
    required this.icon,
    required this.iconOutline,
    required this.screen,
    this.key,
  });
}

//bottom navbar class
class MyxBottomNavbar extends StatefulWidget {
  const MyxBottomNavbar({Key? key}) : super(key: key);

  @override
  _MyxBottomNavbarState createState() => _MyxBottomNavbarState();
}

class _MyxBottomNavbarState extends State<MyxBottomNavbar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<BottomBarItem> _bottomBarItems = [
    BottomBarItem(
      label: 'Home',
      icon: const Icon(Icons.home),
      iconOutline: const Icon(Icons.home_outlined),
      screen: const HomeScreen(),
    ),
    BottomBarItem(
      label: 'Login',
      icon: const Icon(Icons.person),
      iconOutline: const Icon(Icons.person_outlined),
      screen: LoginScreen(),
    ),
    BottomBarItem(
      label: 'Search',
      icon: const Icon(Icons.search),
      iconOutline: const Icon(Icons.search_outlined),
      screen: FavouriteScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _bottomBarItems.map((e) => e.screen).toList(),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: _bottomBarItems
              .map((e) => BottomNavigationBarItem(
                    icon: _selectedIndex == _bottomBarItems.indexOf(e)
                        ? e.icon
                        : e.iconOutline,
                    label: e.label,
                  ))
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
