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
          backgroundColor: Colors.brown[300],
          selectedItemColor: Colors.brown[900], // Highlighted color for activated page
          unselectedItemColor: Colors.brown[500], // Dull color for other pages
          currentIndex: currentIndex,
          onTap: (index) {
            // Only update the currentIndex if the tapped index is not the current index
            if (index != currentIndex) {
              onTabTapped(index);
            } else if (index == 2) {
              // For Profile icon, directly call onTabTapped to highlight and navigate
              onTabTapped(index);
            }
          },
          items: [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(
                Icons.home_rounded,
                size: 30,
              ),
            ),
            BottomNavigationBarItem(
              label: "Inventory",
              icon: Icon(
                Icons.inventory,
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
