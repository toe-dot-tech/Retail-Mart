// lib/layout/main_shell.dart

import 'package:flutter/material.dart';
import 'package:retail_mart/router/nav_bar_visibility.dart';
import 'package:retail_mart/router/persistent_nav_bar.dart';


class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    // Check if the keyboard is visible
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          child,
          ValueListenableBuilder<bool>(
            valueListenable: NavBarVisibility.isVisible,
            builder: (context, isVisible, _) {
              return (isVisible && !isKeyboardVisible)
                  ? const PersistentNavBar()
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
      // bottomNavigationBar: ValueListenableBuilder<bool>(
      //   valueListenable: NavBarVisibility.isVisible,
      //   builder: (context, isVisible, _) {
      //     return isVisible ? const PersistentNavBar() : const SizedBox.shrink();
      //   },
      // ),
    );
  }
}
