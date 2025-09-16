import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialIconButton extends StatelessWidget {
  const SocialIconButton({super.key, required this.iconPath, required this.onTap, this.color});

  final String iconPath;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.r),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepOrange, width: 1.w),
          //circular
          shape: BoxShape.circle,
        ),
        child: Image.asset(iconPath, height: 40.sp, width: 40.sp, color: color),
      ),
    );
  }
}
