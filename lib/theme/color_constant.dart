import 'package:flutter/material.dart';

// Kelas ColorConstant: Palet warna tema Earthy Islamic Gold (Elegan, Hangat, & Mewah Alami)
class ColorConstant {
  // 1. Deep Olive Charcoal / Paling Gelap (#28301C)
  static const Color colorPrimaryDark = Color(0xFF28301C);

  // 2. Forest Olive / Warna Primer (#323D25)
  static const Color colorPrimary = Color(0xFF323D25);

  // 3. Warm Ochre Gold / Aksen Emas (#9A7E3B)
  static const Color colorGold = Color(0xFF9A7E3B);
  static const Color colorPrimaryLight = Color(0xFF9A7E3B);

  // 4. Soft Sand Crema / Aksen Lembut & Background (#D2CF9A)
  static const Color colorSand = Color(0xFFD2CF9A);
  static const Color colorAccent = Color(0xFFF4F3E8);      // Versi pastel lembut dari #D2CF9A untuk kartu
  static const Color colorAccentLight = Color(0xFFFAF9F3); // Crema sangat lembut
  static const Color colorBackground = Color(0xFFF8F7F2);  // Sand off-white hangat

  // Gradien Header Utama Islami (Kombinasi Deep Olive & Gold yang Mewah)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF28301C), Color(0xFF3E4D2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradien Aksen Gold Islami
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFF9A7E3B), Color(0xFFBCA158)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradien Waktu Sholat Siang / Dzuhur
  static const LinearGradient dhuhrDayGradient = LinearGradient(
    colors: [Color(0xFF2980B9), Color(0xFF6DD5FA), Color(0xFFFFFFFF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradien Waktu Sholat Pagi / Subuh-Syuruq
  static const LinearGradient fajrMorningGradient = LinearGradient(
    colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
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

  // Warna Putih
  static const Color colorWhite = Color(0xFFFFFFFF);

  // Bayangan Halus Modern (Soft UI Shadow)
  static final List<BoxShadow> softShadow = [
    BoxShadow(
      color: const Color(0xFF1B5E20).withValues(alpha: 0.12),
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
  static const Color colorText = Color(0xFF1E293B);
  static const Color colorTextSecondary = Color(0xFF64748B);
  static const Color colorTextLight = Color(0xFF94A3B8);
}
