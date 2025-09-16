import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/common/clipper/auth_header_clipper.dart';
import 'package:how_to_do/featuers/auth/presentation/screens/register_screen.dart';
import 'package:how_to_do/featuers/home/presentation/screens/home_screen.dart';
import 'package:how_to_do/l10n/extension.dart';
import 'package:how_to_do/utils/helpers/helper_functions.dart';
import '../../../../common/widgets/buttons/social_icon_button.dart';
import '../blocs/login_button/bloc/login_button_bloc.dart';
import '../../../../utils/constants/path.dart';
import '../../../../utils/validators/app_validators.dart';
import '../blocs/auth/bloc/auth_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisable = false;

  //toggle password visablety
  void togglePassword() {
    setState(() {
      isVisable = !isVisable;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          //custom app bar has a custom clippath
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
                    "login".tr(context),
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
                    SizedBox(height: 30),
                    TextFormField(
                      // controller: loginController.passwordController,
                      validator: (value) => AppValidators.validatePassword(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isVisable,
                      decoration: InputDecoration(
                        hintText: "password".tr(context),
                        suffixIcon: IconButton(
                          onPressed: () {
                            togglePassword();
                          },
                          icon: Icon(
                            isVisable ? Icons.visibility : Icons.visibility_off,
                            color: Colors.deepOrange,
                          ),
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
                    SizedBox(height: 30),
                    //remember me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (value) {},
                          activeColor: Colors.deepOrange,
                        ),
                        Text(
                          "remember_me".tr(context),
                          style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w500),
                        ),
                        //forget password
                        Spacer(),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "forget_password".tr(context),
                            style: TextStyle(color: Colors.deepOrange),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
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

                          //navigate to home screen
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) => HomeScreen()),
                            (route) => false,
                          );
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
                                "login".tr(context),
                                style: TextStyle(color: Colors.white),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 45.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SocialIconButton(
                          iconPath: AppPath.facebookIcon,
                          onTap: () {
                            // Handle Facebook login
                          },
                        ),
                        SizedBox(width: 15.w),
                        SocialIconButton(
                          iconPath: AppPath.googleIcon,
                          onTap: () {
                            // Handle Google login
                          },
                        ),
                        SizedBox(width: 15.w),
                        SocialIconButton(
                          iconPath: AppPath.appleIcon,
                          color: HelperFunctions.isDarkMode(context) ? Colors.white : Colors.black,
                          onTap: () {
                            // Handle Apple login
                          },
                        ),
                      ],
                    ),

                    SizedBox(height: 25.h),
                    TextButton(
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                      },
                      style: TextButton.styleFrom(overlayColor: Colors.deepOrange),
                      child: Text(
                        "create_account".tr(context),
                        style: TextStyle(color: Colors.deepOrange, fontSize: 15.sp),
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
