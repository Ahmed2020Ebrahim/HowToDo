import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/texts.dart';
import '../../../../utils/helpers/helper_functions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});
  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return AppBar(
      toolbarHeight: 100,

      elevation: 0,
      leadingWidth: 90,
      scrolledUnderElevation: 0,
      actions: [
        Icon(Icons.search, size: 35, color: isDark ? Colors.white : Colors.black),
        SizedBox(width: 20),
        Icon(
          Icons.notifications_none_outlined,
          size: 35,
          color: isDark ? Colors.white : Colors.black,
        ),
        SizedBox(width: 5),
      ],
      actionsPadding: EdgeInsets.only(right: 20),

      leading: Container(
        margin: EdgeInsets.only(left: 20, right: 20),
        child: CircleAvatar(
          backgroundColor: AppColors.primary,
          child: Center(
            child: Text(
              AppTexts.dummyLetter,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
