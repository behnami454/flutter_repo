import 'package:flutter/material.dart';

BottomNavigationBar buildBottomNavigationBar(int currentIndex, void Function(int) onTabTapped) {
  return BottomNavigationBar(
    type: BottomNavigationBarType.fixed,
    currentIndex: currentIndex,
    onTap: onTabTapped,
    selectedItemColor: Colors.green,
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.home, size: 35),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.search, size: 35),
        label: 'Search',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.add_circle_outline, size: 35),
        label: 'Create',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.chat, size: 35),
        label: 'Chat',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person, size: 35),
        label: 'Profile',
      ),
    ],
  );
}
