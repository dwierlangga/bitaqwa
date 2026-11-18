import 'package:bitaqwa/dashboard/menu_model.dart';
import 'package:flutter/material.dart';

// DATA MENU DASHBOARD: Daftar 4 tombol menu utama di beranda aplikasi
final List<MenuModel> menus = [
  // Menu 1: Kumpulan Doa
  const MenuModel(
    title: "Doa-doa",
    image: "assets/images/ic_menu_doa.png",
    route: "doa",
    icon: Icons.menu_book_rounded,
  ),
  // Menu 2: Kalkulator Zakat
  const MenuModel(
    title: "Zakat Mal",
    image: "assets/images/ic_menu_zakat.png",
    route: "zakat",
    icon: Icons.account_balance_wallet_rounded,
  ),
  // Menu 3: Jadwal Sholat
  const MenuModel(
    title: "Jadwal Sholat",
    image: "assets/images/ic_menu_jadwal_sholat.png",
    route: "jadwal-sholat",
    icon: Icons.access_time_filled_rounded,
  ),
  // Menu 4: Video Kajian
  const MenuModel(
    title: "Video Kajian",
    image: "assets/images/ic_menu_video_kajian.png",
    route: "video-kajian",
    icon: Icons.play_circle_fill_rounded,
  ),
];
