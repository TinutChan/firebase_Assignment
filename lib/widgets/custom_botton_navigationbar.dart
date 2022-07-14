import 'package:firebase_assignment/screens/home_screen.dart';
import 'package:firebase_assignment/screens/profile_screen.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedItem = 0;
  void _navigationBottomBar(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedItem],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _navigationBottomBar,
        currentIndex: _selectedItem,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: const IconThemeData(color: Colors.black),
        selectedFontSize: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: '',
            activeIcon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
            activeIcon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
