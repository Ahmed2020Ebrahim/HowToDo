import 'package:flutter/material.dart';

import '../../../../utils/constants/path.dart';
import '../../../../utils/constants/texts.dart';
import '../widgets/custom_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSplashScreen(
      endWidget: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppPath.myLogo, width: 30, height: 30),
          Text(
            AppTexts.myName,
            style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 40),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          //circuler
          shape: BoxShape.circle,
        ),
        child: Image.asset(AppPath.appLogo, width: 120, height: 120),
      ),
    );
  }
}
