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
    return Theme(
      data: ThemeData.dark(),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(4.0)),
          color: Colors.white,
        ),
        width: double.maxFinite,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:
                borderRadius ?? BorderRadius.all(Radius.circular(4.0)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF3C61C5),
                Color(0xFF23A991),
              ],
            ),
          ),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          width: double.maxFinite,
          child: child,
        ),
      ),
    );
  }
}
