import 'package:bitaqwa/dashboard/menu_model.dart';

// DATA MENU DASHBOARD: Daftar 4 tombol menu utama di beranda aplikasi
final List<MenuModel> menus = [
  // Menu 1: Kumpulan Doa - (Tugas 4, belum dihubungkan)
  MenuModel(
    title: "Doa-doa",
    image: "assets/images/ic_menu_doa.png",
    route: "doa",
    description: "Kumpulan doa harian",
  ),
  // Menu 2: Kalkulator Zakat - (Tugas 2, belum dihubungkan)
  MenuModel(
    title: "Zakat",
    image: "assets/images/ic_menu_zakat.png",
    route: "zakat",
    description: "Hitung zakat praktis",
  ),
  // Menu 3: Jadwal Sholat - (Tugas 5, belum dihubungkan)
  MenuModel(
    title: "Jadwal Sholat",
    image: "assets/images/ic_menu_jadwal_sholat.png",
    route: "jadwal-sholat",
    description: "Waktu sholat harian",
  ),
  // Menu 4: Video Kajian - (Tugas 3, belum dihubungkan)
  MenuModel(
    title: "Video Kajian",
    image: "assets/images/ic_menu_video_kajian.png",
    route: "video-kajian",
    description: "Kajian islami pilihan",
  ),
];
