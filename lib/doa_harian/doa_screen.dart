import 'package:bitaqwa/doa_harian/card_doa.dart';
import 'package:bitaqwa/doa_harian/kategori_doa_data.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';

// SCREEN DOA: Kumpulan kategori doa dengan tema Emerald Islamic
class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kumpulan Doa Harian',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: ColorConstant.primaryGradient,
          ),
        ),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Banner Info Estetik dengan Gradien Emerald
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            decoration: const BoxDecoration(
              gradient: ColorConstant.primaryGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      color: ColorConstant.colorPrimaryDark,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Amalan Doa Sehari-hari',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 3),
                        Text(
                          'Pilih kategori doa yang ingin kamu pelajari dan amalkan setiap hari.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Grid Kategori Doa
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.95,
              ),
              itemCount: doaCategoryData.length,
              itemBuilder: (context, index) {
                return CardDoa(
                  doa: doaCategoryData[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
