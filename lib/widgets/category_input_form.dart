import 'package:flutter/material.dart';

//INI YANG MUNCUL POPUP

class CategoryInputField extends StatelessWidget {
  final String categoryName;
  final IconData categoryIcon;
  final VoidCallback onTap;

  const CategoryInputField({
    super.key,
    required this.categoryName,
    required this.categoryIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(categoryIcon, color: Colors.grey.shade700),
            const SizedBox(width: 12),
            Text(
              categoryName,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}