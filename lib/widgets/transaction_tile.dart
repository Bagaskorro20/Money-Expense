import 'package:flutter/material.dart';
import 'package:baru/widgets/category_icon.dart';

class TransactionTile extends StatelessWidget {
  final IconData? iconData;
  final String? assetIcon;
  final Color iconColor;
  final String title;
  final String amount;

  // final VoidCallback onDelete;

  const TransactionTile({
    super.key,
    this.iconData,
    this.assetIcon,
    required this.iconColor,
    required this.title,
    required this.amount,
    // required this.onDelete, // Menambahkan callback delete
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CategoryIcon(
                iconData: iconData,
                assetIcon: assetIcon,
                iconColor: iconColor,
                hasBackground: false,
              ),
              const SizedBox(width: 15),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Text(
            amount,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          // Anda bisa menambahkan tombol delete jika perlu
          // IconButton(
          //   icon: const Icon(Icons.delete, color: Colors.red),
          //   onPressed: onDelete,
          // ),
        ],
      ),
    );
  }
}
