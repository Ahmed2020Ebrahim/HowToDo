import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:how_to_do/featuers/auth/data/user_model.dart';
import 'package:how_to_do/l10n/extension.dart';
import 'package:how_to_do/utils/constants/colors.dart';

import '../../../../common/clipper/auth_header_clipper.dart';
import '../../../../common/widgets/buttons/social_icon_button.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../../utils/constants/path.dart';
import '../../../../utils/validators/app_validators.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../blocs/auth/bloc/auth_bloc.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isConfirmVisible = false;
  bool agreedToTerms = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String get userName => userNameController.text.trim();
  String get email => emailController.text.trim();
  String get password => passwordController.text;
  String get confirmPassword => confirmPasswordController.text;

  //toggle password visablety
  void togglePassword() {
    setState(() {
      isVisible = !isVisible;
    });
  }

  //toggle confirm password visablety
  void toggleConfirmPassword() {
    setState(() {
      isConfirmVisible = !isConfirmVisible;
    });
  }

  //toggle terms and conditions
  void toggleAgreedToTerms(bool? value) {
    setState(() {
      agreedToTerms = value ?? false;
    });
  }

  //validate register
  void validatAndSubmit() {
    if (!agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("please_agree_to_terms".tr(context)), backgroundColor: Colors.red),
      );
      return;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("passwords_do_not_match".tr(context)), backgroundColor: Colors.red),
      );
      return;
    }
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthBloc>(
        context,
      ).add(Register(user: UserModel(email: email, name: userName), password: password));
    }
  }

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
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //user name
                    TextFormField(
                      controller: userNameController,
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
                      controller: emailController,
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
                      controller: passwordController,
                      validator: (value) => AppValidators.validatePassword(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        hintText: "password".tr(context),
                        suffixIcon: IconButton(
                          onPressed: () {
                            togglePassword();
                          },
                          icon: Icon(
                            isVisible ? Icons.visibility : Icons.visibility_off,
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
                    SizedBox(height: 15.h),
                    TextFormField(
                      controller: confirmPasswordController,
                      validator: (value) => AppValidators.validatePassword(value),
                      cursorColor: Colors.deepOrange,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !isConfirmVisible,
                      decoration: InputDecoration(
                        hintText: "confirm_password".tr(context),
                        suffixIcon: IconButton(
                          onPressed: () {
                            toggleConfirmPassword();
                          },
                          icon: Icon(
                            isConfirmVisible ? Icons.visibility : Icons.visibility_off,
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
                    SizedBox(height: 10.h),

                    //remember me
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: agreedToTerms,
                          onChanged: (value) {
                            toggleAgreedToTerms(value);
                          },
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
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is AuthLoading) {
                            // Show loading indicator
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              barrierColor: Colors.black.withValues(alpha: 0.3),
                              builder:
                                  (context) => Center(
                                    child: CircularProgressIndicator(color: Colors.deepOrange),
                                  ),
                            );
                          } else {
                            // Hide loading indicator
                            Navigator.of(context, rootNavigator: true).pop();
                          }

                          if (state is AuthError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                            );
                          }

                          if (state is Authenticated) {
                            // Navigate to home screen or wherever
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => HomeScreen()),
                              (route) => false,
                            );
                          }
                        },
                        child: ElevatedButton(
                          onPressed: () {
                            validatAndSubmit();
                          },

                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            shadowColor: Colors.transparent,
                            backgroundColor: Colors.deepOrange,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            textStyle: TextStyle(fontSize: 18),
                          ),
                          child: Text(
                            "register".tr(context),
                            style: TextStyle(color: Colors.white),
                          ),
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
