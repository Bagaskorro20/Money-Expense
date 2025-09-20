import 'package:flutter/material.dart';

class CategoryInputField extends StatelessWidget {
  final String categoryName;
  final IconData? categoryIcon;
  final String? categoryAssetPath;
  final Color? categoryIconColor;
  final VoidCallback onTap;

  const CategoryInputField({
    super.key,
    required this.categoryName,
    this.categoryIcon,
    this.categoryAssetPath,
    this.categoryIconColor,
    required this.onTap,
  });

  Widget _buildIconWidget() {
    Color iconColor = categoryIconColor ?? Colors.grey;

    if (categoryAssetPath != null) {
      return Image.asset(
        categoryAssetPath!,
        width: 20,
        height: 20,
        color: iconColor,
      );
    } else if (categoryIcon != null) {
      return Icon(categoryIcon, color: iconColor);
    }
    return Icon(Icons.category, color: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade600),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            _buildIconWidget(),
            const SizedBox(width: 12),
            Text(
              categoryName,
              style: TextStyle(fontSize: 16, color: Colors.grey.shade700),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
