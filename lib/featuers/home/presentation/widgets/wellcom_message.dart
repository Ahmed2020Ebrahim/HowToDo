import 'package:flutter/material.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';
import 'package:how_to_do/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/texts.dart';

class WellcomMessage extends StatelessWidget {
  const WellcomMessage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //titile
              Text(
                "${AppTexts.helloMessage + (CurrentUser.user?.name ?? "")} ",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              //wellcome hand
              SizedBox(width: 10),
              Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(3.1416), // 180° in radians (horizontal flip)
                child: Icon(Icons.waving_hand, size: 40, color: Colors.deepOrange),
              ),
            ],
          ),
          //subtitle
          Text(AppTexts.subHelloMessage, style: TextStyle(color: Colors.grey, fontSize: 15)),
        ],
      ),
    );
  }
}
