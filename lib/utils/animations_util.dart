
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class AnimationsUtil {
  static Widget sharedAxisTransition(Widget child, Animation<double> primaryAnimation,
      Animation<double> secondaryAnimation) {
    return SharedAxisTransition(
      animation: primaryAnimation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.horizontal,
      child: child,
    );
  }
}