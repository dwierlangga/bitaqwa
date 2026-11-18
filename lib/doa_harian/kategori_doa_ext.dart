import 'package:bitaqwa/doa_harian/kategori_doa_enum.dart';
import 'package:flutter/material.dart';

// EXTENSION: Memberikan kemampuan tambahan pada enum DoaCategory
// Membantu mengubah kode enum menjadi Judul Teks dan Gambar/Icon yang sesuai
extension DoaCategoryExtension on DoaCategory {
  // 1. Mengubah kode enum menjadi Teks Judul yang rapi dibaca manusia
  String get title {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "Makanan & Minuman";
      case DoaCategory.pagiMalam:
        return "Pagi & Malam";
      case DoaCategory.rumah:
        return "Rumah";
      case DoaCategory.perjalanan:
        return "Perjalanan";
      case DoaCategory.sholat:
        return "Sholat";
      case DoaCategory.etikaBaik:
        return "Etika Baik";
    }
  }

  // 2. Icon Vector Modern (Ringan, Halus, & Estetik)
  IconData get icon {
    switch (this) {
      case DoaCategory.makananMinuman:
        return Icons.restaurant_rounded;
      case DoaCategory.pagiMalam:
        return Icons.nights_stay_rounded;
      case DoaCategory.rumah:
        return Icons.roofing_rounded;
      case DoaCategory.perjalanan:
        return Icons.explore_rounded;
      case DoaCategory.sholat:
        return Icons.mosque_rounded;
      case DoaCategory.etikaBaik:
        return Icons.favorite_rounded;
    }
  }

  // 3. Fallback path gambar jika diperlukan
  String get image {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "assets/images/ic_doa_makanan_minuman.png";
      case DoaCategory.pagiMalam:
        return "assets/images/ic_doa_pagi_malam.png";
      case DoaCategory.rumah:
        return "assets/images/ic_doa_rumah.png";
      case DoaCategory.perjalanan:
        return "assets/images/ic_doa_perjalanan.png";
      case DoaCategory.sholat:
        return "assets/images/ic_doa_sholat.png";
      case DoaCategory.etikaBaik:
        return "assets/images/ic_doa_etika_baik.png";
    }
  }
}
