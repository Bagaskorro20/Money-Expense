import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String? assetPath;
  final IconData? iconData;
  final String name;
  final Color color;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    this.assetPath,
    this.iconData,
    required this.name,
    required this.color,
    required this.onTap,
  });

  Widget _buildIcon() {
    if (assetPath != null) {
      return Image.asset(assetPath!, width: 20, height: 20, color: color);
    } else if (iconData != null) {
      return Icon(iconData, size: 20, color: color);
    }
    return const SizedBox(width: 20, height: 20);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: _buildIcon(),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}
