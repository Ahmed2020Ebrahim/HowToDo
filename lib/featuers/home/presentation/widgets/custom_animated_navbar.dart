import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../profile/presentation/views/profile_screen.dart';

class CustomAnimatedNavBar extends StatefulWidget {
  const CustomAnimatedNavBar({super.key});

  @override
  State<CustomAnimatedNavBar> createState() => _CustomAnimatedNavBarState();
}

class _CustomAnimatedNavBarState extends State<CustomAnimatedNavBar> {
  @override
  Widget build(BuildContext context) {
    int bottomNavIndex = 0;

    // Icons: left (home), right (profile)
    final iconList = <IconData>[Icons.home, Icons.person];
    return AnimatedBottomNavigationBar(
      elevation: 0,
      splashColor: Colors.transparent,
      shadow: const BoxShadow(color: Colors.transparent),
      borderColor: Colors.transparent,
      backgroundColor: Colors.deepOrange,
      icons: iconList,
      iconSize: 40,
      gapWidth: 150.w,
      activeIndex: bottomNavIndex == 1 ? 0 : bottomNavIndex, // mapping for FAB
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.verySmoothEdge,
      activeColor: Colors.white,
      inactiveColor: Colors.white,
      onTap: (index) {
        setState(() {
          bottomNavIndex = index;
          if (bottomNavIndex == 1) {
            Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (context) => const ProfileScreen()));
          }
        });
      },
    );
  }
}
