// lib/shared/controllers/nav_bar_visibility.dart
import 'package:flutter/material.dart';

class NavBarVisibility {
  static final ValueNotifier<bool> isVisible = ValueNotifier(true);

  static void hide() => isVisible.value = false;
  static void show() => isVisible.value = true;
}
