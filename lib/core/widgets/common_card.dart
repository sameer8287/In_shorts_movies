import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class CommonCard extends StatelessWidget {
  final double elevation;
  final Color color;
  final Color shadowColor;
  final Clip clip;
  final ShapeBorder? shapeBorder;
  final bool borderOnForeground;
  final Widget child;

  const CommonCard({
    super.key,
    this.elevation = 5,
    this.color = AppTheme.whiteClr,
    this.clip = Clip.hardEdge,
    this.shapeBorder,
    this.shadowColor = AppTheme.whiteClr,
    this.borderOnForeground = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      clipBehavior: clip,
      color: color,
      shadowColor: shadowColor,
      borderOnForeground: borderOnForeground,
      shape:
          shapeBorder ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // Change the radius as needed
          ),
      child: child,
    );
  }
}
