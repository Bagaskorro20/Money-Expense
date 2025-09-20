import 'package:flutter/material.dart';

class CategoryIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool hasBackground;

  const CategoryIcon({
    super.key,
    required this.icon,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.grey,
    this.hasBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    if (hasBackground) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: iconColor,
        ),
      );
    } else {
      return Icon(
        icon,
        color: iconColor,
      );
    }
  }
}