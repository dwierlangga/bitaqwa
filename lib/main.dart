import 'package:bitaqwa/dashboard/basicdashboard_screen.dart';
import 'package:bitaqwa/doa_harian/doa_screen.dart';
import 'package:bitaqwa/jadwal_sholat/jadwal_sholat_screen.dart';
import 'package:bitaqwa/kajian_online/video_kajian_screen.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:bitaqwa/zakat/zakat_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bitaqwa App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: ColorConstant.colorBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorConstant.colorPrimaryDark,
          primary: ColorConstant.colorPrimaryDark,
          secondary: ColorConstant.colorGold,
        ),
        useMaterial3: true,
        // PUSAT TEMA APPBAR GLOBAL: Seragam, rapi, dan tidak perlu diulang-ulang di setiap screen
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorConstant.colorPrimaryDark,
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          iconTheme: IconThemeData(color: Colors.white, size: 20),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const BasicDashboardScreen(),
        'zakat': (context) => const ZakatScreen(),
        '/zakat': (context) => const ZakatScreen(),
        'video-kajian': (context) => const VideoKajianScreen(),
        '/video-kajian': (context) => const VideoKajianScreen(),
        'doa': (context) => const DoaScreen(),
        '/doa': (context) => const DoaScreen(),
        'jadwal-sholat': (context) => const JadwalSholatScreen(),
        '/jadwal-sholat': (context) => const JadwalSholatScreen(),
      },
    );
  }
}
