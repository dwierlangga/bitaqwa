import 'package:bitaqwa/dashboard/menu_data.dart';
import 'package:bitaqwa/dashboard/color_constant.dart';
import 'package:flutter/material.dart';

// SCREEN BASIC DASHBOARD: Tampilan beranda aplikasi yang menyapa pengguna dan menampilkan menu fitur
class BasicDashboardScreen extends StatelessWidget {
  const BasicDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. BANNER HEADER ATAS DENGAN GRADIENT & SHADOW ELEGAN
            Container(
              height: 250,
              width: double.infinity,
              decoration: BoxDecoration(
                image: const DecorationImage(
                  image: AssetImage('assets/images/dashboard.jpg'),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorPrimaryDark.withValues(
                      alpha: 0.25,
                    ),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(28),
                    bottomRight: Radius.circular(28),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorConstant.colorPrimaryDark.withValues(alpha: 0.35),
                      Colors.black.withValues(alpha: 0.65),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // BAR ATAS: Tagline di kiri dan Logo IDN di kanan
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Chip Tagline Islami kecil
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.18),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.25),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.stars_rounded,
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Islamic Lifestyle',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Logo IDN
                        Container(
                          height: 38,
                          width: 48,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.15),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ],
                    ),

                    // TEKS SAPAAN DI BAGIAN BAWAH BANNER
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Assalamu\'alaikum,',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Bitaqwa App',
                          style: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // LABEL SECTION
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Menu Utama',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorText,
                  letterSpacing: 0.2,
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 2. GRID MENU FITUR (4 TOMBOL MENU UTAMA DENGAN MATERIAL & CARD EFFECT)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.95,
                ),
                itemCount: menus.length,
                itemBuilder: (context, index) {
                  final menu = menus[index];
                  return Material(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(18),
                    elevation: 1.5,
                    shadowColor: Colors.black.withValues(alpha: 0.12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      hoverColor: ColorConstant.colorPrimary.withValues(
                        alpha: 0.12,
                      ),
                      splashColor: ColorConstant.colorPrimary.withValues(
                        alpha: 0.12,
                      ),
                      highlightColor: ColorConstant.colorPrimary.withValues(
                        alpha: 0.15,
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, menu.route);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: Colors.black.withValues(alpha: 0.04),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Lingkaran background icon lembut
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: ColorConstant.colorAccent,
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                menu.image,
                                height: 44,
                                width: 44,
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Label Judul Menu
                            Text(
                              menu.title,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.colorText,
                              ),
                            ),
                            const SizedBox(height: 3),
                            // Deskripsi Tombol Menu
                            Text(
                              menu.description,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                color: ColorConstant.colorText.withValues(
                                  alpha: 0.65,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
