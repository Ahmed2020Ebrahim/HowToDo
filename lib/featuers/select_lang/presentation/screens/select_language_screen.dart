import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/featuers/auth/presentation/screens/auth_selection_screen.dart';
import 'package:how_to_do/l10n/extension.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../auth/presentation/blocs/auth/bloc/auth_bloc.dart';
import '../widgets/select_language_button.dart';

class SelectLanguageScreen extends StatelessWidget {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        width: 1.sw,
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 1.sw,

              padding: EdgeInsets.only(top: 10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "select_language".tr(context),
                    style: TextStyle(fontSize: 26.sp, color: AppColors.white),
                  ),
                  Text(
                    "select_language_hint".tr(context),
                    style: TextStyle(fontSize: 12.sp, color: AppColors.white),
                  ),
                ],
              ),
            ),

            SizedBox(
              child: Column(
                children: [
                  LanguageSelectorButton(localCode: "en", lable: "English"),
                  SizedBox(height: 20.h),
                  LanguageSelectorButton(localCode: "ar", lable: "العربية"),
                ],
              ),
            ),

            SizedBox(
              height: 50.h,
              width: 180.w,

              child: ElevatedButton(
                onPressed: () {
                  //the app is no longer in the first start
                  context.read<AuthBloc>().add(FirstRunCompleted());

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AuthSelectionScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  foregroundColor: AppColors.primary,
                  backgroundColor: Colors.white,
                  disabledForegroundColor: Colors.grey,
                  textStyle: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text("let's_go".tr(context)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
