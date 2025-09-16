import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HelperFunctions {
  HelperFunctions._();

  //! ---> show snack Bar
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  //! ---> show alert
  static void showAlert(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (BuildContext context) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text("OK")),
            ],
          ),
    );
  }

  //! ---> navigate to screen
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  //! ---> truncate Text
  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return "${text.substring(0, maxLength)}...";
    }
  }

  //! ---> is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  //! ---> get screen size
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  //! ---> get screen width
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  //! ---> get formated date
  static String getFormattedDate(DateTime date, {String format = "dd MMM yyy"}) {
    return DateFormat(format).format(date);
  }

  //! ---> remove dublicates
  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  //*---------------------------------------------------------------------*//
  //! ---> combine date and time
  static DateTime? combineDateAndTime(String dateString, String timeString) {
    try {
      // Parse date string (example format: "2025-09-07")
      DateTime date = DateFormat("yyyy-MM-dd").parse(dateString);

      // Parse time string (example format: "2:30 PM")
      TimeOfDay time = TimeOfDay.fromDateTime(DateFormat.jm().parse(timeString));

      // Combine into single DateTime
      return DateTime(date.year, date.month, date.day, time.hour, time.minute);
    } catch (e) {
      print("Error parsing date or time: $e");
      return null; // return null if parsing fails
    }
  }

  //! ---> enum from string
  static T? enumFromString<T extends Enum>(List<T> values, String value) {
    try {
      return values.firstWhere((e) => e.name.toLowerCase() == value.toLowerCase());
    } catch (_) {
      return null; // return null if not found
    }
  }
}
