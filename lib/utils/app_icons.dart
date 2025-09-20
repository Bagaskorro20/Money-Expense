import 'package:flutter/material.dart';

// Definisi sebuah class untuk menyimpan informasi ikon
class IconDataWithColor {
  final IconData? iconData;
  final String? assetPath;
  final Color color;
  final Color backgroundColor;

  const IconDataWithColor({
    this.iconData,
    this.assetPath,
    required this.color,
    required this.backgroundColor,
  });
}

const Map<String, IconDataWithColor> categoryIcons = {
  'Makanan': IconDataWithColor(
    assetPath: 'assets/icons/pizza.png',
    color: Color(0xFFF2C94C),
    backgroundColor: Color(0xFFFFF7E0),
  ),
  'Internet': IconDataWithColor(
    assetPath: 'assets/icons/wifi.png',
    color: Color(0xFF56CCF2),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Edukasi': IconDataWithColor(
    assetPath: 'assets/icons/book.png',
    color: Color(0xFFF2994A),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Hadiah': IconDataWithColor(
    assetPath: 'assets/icons/kado.png',
    color: Color(0xFFEB5757),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Transportasi': IconDataWithColor(
    assetPath: 'assets/icons/car.png',
    color: Color(0xFF9B51E0),
    backgroundColor: Color(0xFFF3E5F5),
  ),
  'Belanja': IconDataWithColor(
    assetPath: 'assets/icons/shop.png',
    color: Color(0xFF27AE60),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Alat Rumah': IconDataWithColor(
    assetPath: 'assets/icons/home.png',
    color: Color(0xFFBB6BD9),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Olahraga': IconDataWithColor(
    assetPath: 'assets/icons/ball.png',
    color: Color(0xFF2D9CDB),
    backgroundColor: Color(0xFFE3F2FD),
  ),
  'Hiburan': IconDataWithColor(
    assetPath: 'assets/icons/film.png',
    color: Color(0xFF2F80ED),
    backgroundColor: Color(0xFFE3F2FD),
  ),
};
