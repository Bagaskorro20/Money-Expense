import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryIcon extends StatelessWidget {
  final IconData? iconData;
  final String? assetIcon;
  final Color backgroundColor;
  final Color iconColor;
  final bool hasBackground;
  final double iconSize;

  const CategoryIcon({
    super.key,
    this.iconData,
    this.assetIcon,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.white,
    this.hasBackground = false,
    this.iconSize = 24,
  });

  Widget _buildIconWidget() {
    if (assetIcon != null) {
      return Image.asset(
        assetIcon!,
        width: iconSize,
        height: iconSize,
        color: iconColor,
      );
    } else if (iconData != null) {
      return Icon(
        // Ikon bawaan Flutter
        iconData,
        size: iconSize,
        color: iconColor,
      );
    }
    return SizedBox(width: iconSize, height: iconSize);
  }

  @override
  Widget build(BuildContext context) {
    if (hasBackground) {
      return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: _buildIconWidget(),
      );
    } else {
      return _buildIconWidget();
    }
  }
}
