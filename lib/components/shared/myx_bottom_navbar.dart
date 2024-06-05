import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:tournamyx_mobile/features/auth/screen/login.dart';
import 'package:tournamyx_mobile/features/favourite/screen/favourite_page.dart';
import 'package:tournamyx_mobile/utils/theme/tournamyx_theme.dart';

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
  const MyxBottomNavbar({super.key});

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
      label: 'Dashboard',
      icon: const Icon(Icons.home),
      iconOutline: const Icon(Icons.home_outlined),
      screen: LoginScreen(), //TODO: replace with dashboard screen
    ),
    BottomBarItem(
      label: 'Favourite',
      icon: const Icon(Ionicons.star),
      iconOutline: const Icon(Ionicons.star_outline),
      screen: const FavouriteScreen(),
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
          backgroundColor: TournamyxTheme.background,
          items: _bottomBarItems
              .map((e) => BottomNavigationBarItem(
                    icon: _selectedIndex == _bottomBarItems.indexOf(e)
                        ? e.icon
                        : e.iconOutline,
                    label: e.label,
                  ))
              .toList(),
          currentIndex: _selectedIndex,
          selectedItemColor: TournamyxTheme.primary,
          unselectedItemColor: TournamyxTheme.primary.withOpacity(0.7),
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
