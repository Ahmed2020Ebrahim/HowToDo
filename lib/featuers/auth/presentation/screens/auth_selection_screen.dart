import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/l10n/extension.dart';
import 'package:how_to_do/utils/constants/colors.dart';
import 'package:how_to_do/utils/constants/sizes.dart';

import '../../../../utils/constants/path.dart';
import 'login_screen.dart';
import 'register_screen.dart';

class AuthSelectionScreen extends StatelessWidget {
  const AuthSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSizes.appBarHeight),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image
            Image.asset(AppPath.idea, width: 200.w, height: 300.h),
            //title
            Text(
              'welcome'.tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.sp,
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            //subtitle
            Text(
              'welcome_subtitle'.tr(context),
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.white, fontSize: 16.sp),
            ),
            SizedBox(height: 80.h),
            //row for login and signup buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SelectAuthWayButton(
                  label: 'login',
                  onTap: () {
                    // Navigate to the login screen
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                ),
                SizedBox(width: 15.w),
                SelectAuthWayButton(
                  label: 'register',
                  onTap: () {
                    // Navigate to the signup screen
                    Navigator.of(
                      context,
                    ).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SelectAuthWayButton extends StatelessWidget {
  const SelectAuthWayButton({super.key, required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        width: 110.w,
        decoration: BoxDecoration(
          color: AppColors.primary,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        child: Text(
          label.tr(context),
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
