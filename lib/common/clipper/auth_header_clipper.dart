import 'package:flutter/material.dart';

//custom clippath
class AuthHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, ((size.height * 2) / 3) - 20);
    //first offset
    final firstOffset = Offset(size.width / 4, size.height / 4);
    final secondOffset = Offset(size.width / 2, ((size.height * 2) / 3) - 20);
    path.quadraticBezierTo(firstOffset.dx, firstOffset.dy, secondOffset.dx, secondOffset.dy);

    final thirdOffset = Offset(size.width * 3 / 4, size.height);
    final fourthOffset = Offset(size.width, ((size.height * 2) / 3) - 20);
    path.quadraticBezierTo(thirdOffset.dx, thirdOffset.dy, fourthOffset.dx, fourthOffset.dy);

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
