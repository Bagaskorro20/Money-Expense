import 'package:flutter/material.dart';

// Definisi sebuah class untuk menyimpan informasi ikon
class IconDataWithColor {
  final IconData icon;
  final Color color;
  final Color backgroundColor;

  const IconDataWithColor({
    required this.icon,
    required this.color,
    required this.backgroundColor,
  });
}

// Map yang memetakan nama kategori ke ikon dan warna yang sesuai
const Map<String, IconDataWithColor> categoryIcons = {
  'Makanan': IconDataWithColor(
    icon: Icons.fastfood,
    color: Colors.amber,
    backgroundColor: Color(0xFFFFF7E0),
  ),
  'Internet': IconDataWithColor(
    icon: Icons.wifi,
    color: Colors.blue,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Edukasi': IconDataWithColor(
    icon: Icons.book,
    color: Colors.orange,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Hadiah': IconDataWithColor(
    icon: Icons.rectangle_outlined,
    color: Colors.red,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Transport': IconDataWithColor(
    icon: Icons.car_rental,
    color: Colors.purple,
    backgroundColor: Color(0xFFF3E5F5),
  ),
  'Belanja': IconDataWithColor(
    icon: Icons.shop,
    color: Colors.green,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Alat Rumah': IconDataWithColor(
    icon: Icons.home,
    color: Colors.pink,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Olahraga': IconDataWithColor(
    icon: Icons.sports_baseball,
    color: Colors.blueAccent,
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'HIburan': IconDataWithColor(
    icon: Icons.movie_creation_outlined,
    color: Colors.blueGrey,
    backgroundColor: Color(0xFFE3F2FD),
  ),
};

// ini berada pada UI
// import 'package:baru/utils/app_icons.dart'; // Impor file utilitas ikon
// // ... (impor lainnya)
//
// // ... (kode di dalam HomeScreen) ...
//
// // Contoh di _buildCategoryList()
// final categoryName = 'Makanan'; // Nama kategori dari database
//
// final iconData = categoryIcons[categoryName]?.icon ?? Icons.error;
// final iconColor = categoryIcons[categoryName]?.color ?? Colors.red;
// final backgroundColor = categoryIcons[categoryName]?.backgroundColor ?? Colors.transparent;
//
// // Menggunakan widget CategoryIcon yang sebelumnya kita buat
// // Ikon dengan background (untuk kartu kategori)
// CategoryIcon(
// icon: iconData,
// backgroundColor: backgroundColor,
// iconColor: iconColor,
// hasBackground: true,
// )
//
// // ...
//
// // Contoh di _buildTransactionTile()
// final transactionCategory = 'Makanan'; // Kategori transaksi dari database
//
// final transactionIcon = categoryIcons[transactionCategory]?.icon ?? Icons.error;
// final transactionIconColor = categoryIcons[transactionCategory]?.color ?? Colors.grey;
//
// // Ikon tanpa background (untuk list transaksi)
// CategoryIcon(
// icon: transactionIcon,
// iconColor: transactionIconColor,
// hasBackground: false,
// )
