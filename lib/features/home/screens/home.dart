import 'package:creator_connect/common/widgets/navbar_main.dart';
import 'package:creator_connect/features/home/screens/BusinessHome.dart';
import 'package:creator_connect/features/profile/screens/profile_page.dart';
import 'package:creator_connect/features/search/screens/search_screen.dart';
import 'package:flutter/material.dart';

import '../../chat/screens/chat_list_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home-screen';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;

  final _pageOptions = const [
    BusinessHome(),
    SearchScreen(),
    ChatListScreen(),
    ProfilePage(),
  ];

  void ontabChange(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pageOptions[_selectedPage],
      bottomNavigationBar: NavBarHome(
        ontabChange: ontabChange,
      ),
    );
  }
}
