import 'package:flutter/material.dart';
import 'dart:math' as math;

class ImageRotation extends StatefulWidget {
  const ImageRotation({super.key, required this.image});
  final String image;
  @override
  _ImageRotationState createState() => _ImageRotationState();
}

class _ImageRotationState extends State<ImageRotation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -math.pi / 6, // Rotate left inward by 30 degrees
      end: math.pi / 6, // Rotate right inward by 30 degrees
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationY(_animation.value),
          child: Image.asset(
            widget.image, // Replace with your image asset
            width: MediaQuery.of(context).size.width*0.5,
            height: MediaQuery.of(context).size.height*0.5,
          ),
        );
      },
    );
  }
}
