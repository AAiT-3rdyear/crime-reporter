import 'package:flutter/material.dart';

class TopLeftClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    final double _xScaling = size.width / 414;
    final double _yScaling = size.height / 896;
    path.lineTo(0.775838 * _xScaling, 608.999 * _yScaling);
    path.cubicTo(
      0.775838 * _xScaling,
      608.999 * _yScaling,
      1.87744 * _xScaling,
      0 * _yScaling,
      1.87744 * _xScaling,
      0 * _yScaling,
    );
    path.cubicTo(
      9.94785 * _xScaling,
      111.207 * _yScaling,
      30.2932 * _xScaling,
      205.708 * _yScaling,
      55.1346 * _xScaling,
      265.768 * _yScaling,
    );
    path.cubicTo(
      85.713 * _xScaling,
      339.699 * _yScaling,
      124.729 * _xScaling,
      389.661 * _yScaling,
      162.925 * _xScaling,
      428.195 * _yScaling,
    );
    path.cubicTo(
      200.147 * _xScaling,
      465.747 * _yScaling,
      246.371 * _xScaling,
      482.882 * _yScaling,
      296.441 * _xScaling,
      493.833 * _yScaling,
    );
    path.cubicTo(
      341.239 * _xScaling,
      503.631 * _yScaling,
      394.747 * _xScaling,
      518.534 * _yScaling,
      437.984 * _xScaling,
      494.089 * _yScaling,
    );
    path.cubicTo(
      437.984 * _xScaling,
      494.089 * _yScaling,
      437.775 * _xScaling,
      609.789 * _yScaling,
      437.775 * _xScaling,
      609.789 * _yScaling,
    );
    path.cubicTo(
      437.775 * _xScaling,
      609.789 * _yScaling,
      0.775838 * _xScaling,
      608.999 * _yScaling,
      0.775838 * _xScaling,
      608.999 * _yScaling,
    );
    path.cubicTo(
      0.775838 * _xScaling,
      608.999 * _yScaling,
      0.775838 * _xScaling,
      608.999 * _yScaling,
      0.775838 * _xScaling,
      608.999 * _yScaling,
    );
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}