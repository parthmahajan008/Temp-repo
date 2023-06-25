import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBarHome extends StatelessWidget {
  final void Function(int) ontabChange;
  NavBarHome({
    super.key,
    required this.ontabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: GNav(
        haptic: true,
        color: Colors.black,
        tabBackgroundColor: Colors.grey[300]!,
        backgroundColor: Colors.white,
        gap: 8,
        activeColor: Colors.black,
        rippleColor: Colors.black12,
        padding: const EdgeInsets.all(16),
        tabs: const [
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.search,
            text: 'Search',
          ),
          GButton(
            icon: Icons.message,
            text: 'Messages',
          ),
          GButton(
            icon: Icons.person,
            text: 'Profile',
          ),
        ],
        selectedIndex: 0,
        onTabChange: ontabChange,
      ),
    );
  }
}
