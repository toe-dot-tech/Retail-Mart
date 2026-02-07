import 'package:flutter/material.dart';

// Define the custom transition for slide animation
Widget createSlideRightTransition(Animation<double> animation, Widget child) {
  const begin = Offset(1.0, 0.0); // Slide from the right
  const end = Offset.zero; // End position (no offset)
  const curve = Curves.easeInOut; // Animation curve

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
  var offsetAnimation = animation.drive(tween);

  return SlideTransition(position: offsetAnimation, child: child);
}
