import 'package:flutter/material.dart';

// MODEL MENU: Kerangka data untuk tombol menu di Dashboard utama
class MenuModel {
  // 1. Label nama menu (misal: 'Doa-doa', 'Zakat')
  final String title;
  // 2. Gambar ikon menu (opsional jika menggunakan icon vector)
  final String image;
  // 3. Alamat rute navigasi saat tombol ditekan
  final String route;
  // 4. Icon Vector Modern
  final IconData? icon;

  const MenuModel({
    required this.title,
    required this.image,
    required this.route,
    this.icon,
  });
}
