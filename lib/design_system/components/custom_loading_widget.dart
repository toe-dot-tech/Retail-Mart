import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomLoadingWidget extends ConsumerStatefulWidget {
  final Duration animationDuration;
  final double scaleMin;
  final double scaleMax;
  final double rotationMin;
  final double rotationMax;

  const CustomLoadingWidget({
    super.key,
    this.animationDuration = const Duration(milliseconds: 2500),
    this.scaleMin = 0.95,
    this.scaleMax = 1.05,
    this.rotationMin = -0.75,
    this.rotationMax = 0.75,
  });

  @override
  ConsumerState<CustomLoadingWidget> createState() =>
      _CustomLoadingWidgetState();
}

class _CustomLoadingWidgetState extends ConsumerState<CustomLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();

    // Use the provided animation duration and range
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    )..repeat();

    // 1. Panning In and Out (Subtle Scale Pulse)
    _scaleAnimation =
        Tween<double>(begin: widget.scaleMin, end: widget.scaleMax).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeInOut),
          ),
        );

    // 2. Counter Rotation (Full Steering Wheel Effect)
    _rotationAnimation =
        Tween<double>(
          begin: widget.rotationMin,
          end: widget.rotationMax,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 0.9, curve: Curves.easeInOut),
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The AnimatedBuilder rebuilds the icon based on the controller's value.
    return Center(
      child: Material(
        type: MaterialType.transparency,
        child: Semantics(
          label: 'Loading',
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final currentScale = _scaleAnimation.value;
              final currentRotation = _rotationAnimation.value;

              return Transform.scale(
                scale: currentScale,
                child: Transform.rotate(
                  angle:
                      currentRotation *
                      (2 * 3.14159), // Convert turns to radians
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(
                            28,
                          ), // subtle shadow color
                          offset: const Offset(
                            2,
                            2,
                          ), // slight offset to simulate elevation
                          blurRadius: 40, // subtle blur for soft edges
                          spreadRadius: 6, // slight spread of the shadow
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/logo/app-icon.png', // your image path
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover, // How the image should fit its box
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
