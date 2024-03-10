import 'package:flutter/material.dart';

class CommonBottomNavigationBar extends StatelessWidget {
  final Function(int) onTabTapped;
  final int currentIndex;

  const CommonBottomNavigationBar({
    required this.onTabTapped,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 10,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Colors.grey.withOpacity(0.5),
          unselectedItemColor: Colors.brown[200],
          currentIndex: currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: Icon(
                Icons.person_rounded,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

