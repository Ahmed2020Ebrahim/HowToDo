import 'package:flutter/material.dart';
import '../../common/widgets/snackbars/snackbars.dart';

class AppPopups {
  AppPopups._();

  //fullscreen loader

  //show cancel full screen

  //warning snackbar
  static void showWarningSnackBar({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    SnackBars.warningSnackBar(title: title, message: message, context: context);
  }

  //error snackbar
  static void showErrorSnackBar({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    SnackBars.errorSnackBar(title: title, message: message, context: context);
  }

  //success snackbar
  static void showSuccessSnackBar({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    SnackBars.successSnackBar(title: title, message: message, context: context);
  }

  // stop loading
  static stopLoading(BuildContext context) {
    Navigator.of(context).pop();
  }
}
