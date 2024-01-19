import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
    this.borderRadius,
    required this.child,
    this.padding,
  });

  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4.0)),
        color: Colors.white.withOpacity(0.75),
      ),
      width: double.maxFinite,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4.0)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromARGB(200, 60, 97, 197),
              Color.fromARGB(200, 35, 169, 145),
            ],
          ),
        ),
        padding:
            padding ?? EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        width: double.maxFinite,
        child: child,
      ),
    );
  }
}
