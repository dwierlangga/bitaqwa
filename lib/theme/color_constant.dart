import 'package:flutter/material.dart';

// Kelas ColorConstant: Palet warna Emerald Islamic khas Bitaqwa App (Tenang, Teduh, & Modern)
class ColorConstant {
  // Warna Utama (Emerald Islamic / Hijau Zamrud Elegan)
  static const Color colorPrimary = Color(0xFF107A68);
  static const Color colorPrimaryDark = Color(0xFF095246);
  static const Color colorPrimaryLight = Color(0xFF34A692);

  // Gradien Header Utama Islami
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0D6B5B), Color(0xFF169882)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradien Waktu Sholat Siang / Dzuhur (Cerah, Hangat, Langit Siang)
  static const LinearGradient dhuhrDayGradient = LinearGradient(
    colors: [Color(0xFF2980B9), Color(0xFF6DD5FA), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradien Waktu Sholat Pagi / Subuh-Syuruq
  static const LinearGradient fajrMorningGradient = LinearGradient(
    colors: [Color(0xFF0D6B5B), Color(0xFF2E8B75)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradien Waktu Sholat Sore / Ashar
  static const LinearGradient asrAfternoonGradient = LinearGradient(
    colors: [Color(0xFF3A7BD5), Color(0xFF3A6073)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradien Waktu Sholat Maghrib / Senja
  static const LinearGradient maghribSunsetGradient = LinearGradient(
    colors: [Color(0xFF53346C), Color(0xFFBD3F32)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradien Waktu Sholat Isya / Malam
  static const LinearGradient ishaNightGradient = LinearGradient(
    colors: [Color(0xFF1B2A47), Color(0xFF2C3E50)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Aksen Warna & Background
  static const Color colorAccent = Color(0xFFE8F6F3);       // Mint lembut
  static const Color colorAccentLight = Color(0xFFF2FBF9);  // Mint sangat lembut
  static const Color colorBackground = Color(0xFFF7FAF9);   // Off-white kehijauan segar
  static const Color colorWhite = Color(0xFFFFFFFF);

  // Bayangan Halus Modern (Soft UI Shadow)
  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: const Color(0xFF107A68).withValues(alpha: 0.12),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
  ];

  static final List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.04),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  // Hierarki Warna Teks
  static const Color colorText = Color(0xFF1E293B);          // Slate tajam modern
  static const Color colorTextSecondary = Color(0xFF64748B); // Slate medium
  static const Color colorTextLight = Color(0xFF94A3B8);     // Slate soft
}
