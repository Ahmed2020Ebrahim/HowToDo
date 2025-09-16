import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../l10n/cubit/localiz_cubit.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';

class LanguageSelectorButton extends StatelessWidget {
  const LanguageSelectorButton({super.key, required this.localCode, required this.lable});
  final String localCode;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(50.r),
      onTap: () {
        context.read<LocalizCubit>().changeLocale(Locale(localCode));
      },
      child: Container(
        alignment: Alignment.center,
        width: 1.sw,
        padding: EdgeInsets.all(AppSizes.defaultSpace),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.r),
          color: Colors.white,
          border: Border.all(
            color:
                Localizations.localeOf(context).languageCode == localCode
                    ? AppColors.black
                    : Colors.transparent,
            width: 2.w,
          ),
        ),

        child: Text(lable, style: TextStyle(fontSize: 16.sp, color: Colors.black)),
      ),
    );
  }
}
