import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/l10n/extension.dart';
import 'package:how_to_do/utils/constants/colors.dart';

import '../../../../common/clipper/auth_header_clipper.dart';
import '../../../../common/widgets/buttons/social_icon_button.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../blocs/login_button/bloc/login_button_bloc.dart';
import '../../../../utils/constants/path.dart';
import '../../../../utils/validators/app_validators.dart';
import '../blocs/auth/bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: AuthHeaderClipper(),
              child: Container(
                width: double.infinity,
                height: 300,
                color: Colors.deepOrange,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 60),
                  child: Text(
                    "register".tr(context),
                    style: TextStyle(color: Colors.white, fontSize: 30),
                  ),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Form(
                // key: loginController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //user name
                    TextFormField(
                      // controller: loginController.emailController,
                      validator: (value) => AppValidators.validateName(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "userName".tr(context),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                        ),
                        prefixIcon: Icon(Icons.person, color: Colors.deepOrange),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      // controller: loginController.emailController,
                      validator: (value) => AppValidators.validateEmail(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "email".tr(context),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                        ),
                        prefixIcon: Icon(Icons.email, color: Colors.deepOrange),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      // controller: loginController.passwordController,
                      validator: (value) => AppValidators.validatePassword(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "password".tr(context),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off, color: Colors.deepOrange),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.deepOrange),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    TextFormField(
                      // controller: loginController.passwordController,
                      validator: (value) => AppValidators.validatePassword(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "confirm_password".tr(context),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.visibility_off, color: Colors.deepOrange),
                        ),

                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange, width: 2),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.deepOrange, width: 2),
                        ),
                        prefixIcon: Icon(Icons.lock, color: Colors.deepOrange),
                      ),
                    ),
                    SizedBox(height: 10.h),

                    //remember me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                          activeColor: Colors.deepOrange,
                        ),
                        Text.rich(
                          TextSpan(
                            text: "agreement".tr(context),
                            children: [
                              TextSpan(
                                text: "terms".tr(context),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                              TextSpan(text: "and".tr(context)),
                              TextSpan(
                                text: "conditions".tr(context),
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 5.h),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 80,
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () async {
                          // if (loginController.formKey.currentState!.validate()) {
                          //   await loginController.login();
                          // }
                          BlocProvider.of<LoginButtonBloc>(context).add(LoginButtonPressedEvent());
                          await Future.delayed(Duration(seconds: 2));

                          // Handle login logic here
                          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
                        },

                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          backgroundColor: Colors.deepOrange,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          textStyle: TextStyle(fontSize: 18),
                        ),
                        child: BlocBuilder<LoginButtonBloc, LoginButtonState>(
                          builder: (context, state) {
                            if (state is LoginButtonLoading) {
                              return Center(
                                child: SizedBox(
                                  width: 30.w,
                                  height: 30.w,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,

                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            } else {
                              return Text(
                                "register".tr(context),
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIconButton(
                          iconPath: AppPath.facebookIcon,
                          onTap: () {
                            // Handle Facebook login
                          },
                        ),
                        SizedBox(width: 10.w),
                        SocialIconButton(
                          iconPath: AppPath.googleIcon,
                          onTap: () {
                            // Handle Google login
                          },
                        ),
                        SizedBox(width: 10.w),
                        SocialIconButton(
                          iconPath: AppPath.appleIcon,
                          color: HelperFunctions.isDarkMode(context) ? Colors.white : Colors.black,
                          onTap: () {
                            // Handle Apple login
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 5.h),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => LoginScreen()));
                      },
                      style: TextButton.styleFrom(overlayColor: Colors.deepOrange),
                      child: Text(
                        "login".tr(context),
                        style: TextStyle(color: Colors.deepOrange, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
