import 'package:flutter/material.dart';

class Clickable extends StatelessWidget {
  const Clickable({
    Key? key,
    required this.child,
    this.onTap,
    this.borderRadius,
    this.hoverColor,
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Color? hoverColor;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        hoverColor: hoverColor,
        borderRadius: borderRadius ?? BorderRadius.circular(7.0),
        onTap: onTap,
        child: child,
      ),
    );
  }
}
