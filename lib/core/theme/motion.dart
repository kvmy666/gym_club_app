import 'package:flutter/animation.dart';

class AppMotion {
  static const Duration pageTransition = Duration(milliseconds: 420);
  static const Duration cardEntrance = Duration(milliseconds: 320);
  static const Duration chipSwitch = Duration(milliseconds: 220);
  static const Duration hero = Duration(milliseconds: 500);
  static const Duration microInteraction = Duration(milliseconds: 140);

  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeInOut = Curves.easeInOutCubic;
  static const Curve emphasized = Curves.easeInOutBack;
  static const Curve spring = Curves.easeInOutQuad;
}
