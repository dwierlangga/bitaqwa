import 'package:bitaqwa/doa_harian/detail_doa_screen.dart';
import 'package:bitaqwa/doa_harian/doa_data.dart';
import 'package:bitaqwa/doa_harian/kategori_doa_enum.dart';
import 'package:bitaqwa/doa_harian/kategori_doa_ext.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';

// SCREEN DOA LIST: Menampilkan daftar bacaan doa dalam kategori dengan tema Emerald
class DoaListScreen extends StatelessWidget {
  final DoaCategory category;

  const DoaListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final doas = doaData[category] ?? [];

    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          category.title,
          style: const TextStyle(
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
      body: doas.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstant.colorAccent,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.menu_book_rounded,
                      size: 48,
                      color: ColorConstant.colorPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Belum Ada Doa Tersedia',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorConstant.colorText,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Daftar doa untuk kategori ini sedang disiapkan.',
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorConstant.colorTextSecondary,
                    ),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
              physics: const BouncingScrollPhysics(),
              itemCount: doas.length,
              itemBuilder: (context, index) {
                final doa = doas[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailDoaScreen(doa: doa),
                          ),
                        );
                      },
                      child: Ink(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.colorPrimary.withValues(alpha: 0.06),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                          border: Border.all(
                            color: const Color(0xFFF1F5F9),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFE8F6F3), Color(0xFFD0EFE8)],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: ColorConstant.colorPrimaryDark,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    doa.title,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: ColorConstant.colorText,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.bookmark_outline_rounded,
                                        size: 13,
                                        color: ColorConstant.colorPrimaryDark,
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          doa.reference,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: ColorConstant.colorTextSecondary,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: ColorConstant.colorBackground,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 12,
                                color: ColorConstant.colorPrimaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
