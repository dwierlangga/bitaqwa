import 'package:bitaqwa/doa_harian/doa_model.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';

// SCREEN DETAIL DOA: Desain mushaf Emerald yang nyaman dibaca
class DetailDoaScreen extends StatelessWidget {
  final Doa doa;

  const DetailDoaScreen({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          doa.title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KOTAK BACAAN ARAB (DESAIN KARTU MUSHAF)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorPrimary.withValues(alpha: 0.08),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFD4EFE9),
                  width: 1.5,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F6F3),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: const [
                            Icon(
                              Icons.menu_book_rounded,
                              size: 16,
                              color: ColorConstant.colorPrimaryDark,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Lafadz Doa',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: ColorConstant.colorPrimaryDark,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: const Color(0xFFBBE5DC)),
                          ),
                          child: const Text(
                            'Bahasa Arab',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: ColorConstant.colorPrimaryDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(22, 28, 22, 32),
                    child: Text(
                      doa.arabicText,
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        height: 2.2,
                        color: Color(0xFF1E293B),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // KOTAK TERJEMAHAN
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(
                  color: const Color(0xFFF1F5F9),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: ColorConstant.colorAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.translate_rounded,
                          size: 18,
                          color: ColorConstant.colorPrimaryDark,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Artinya / Terjemahan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: ColorConstant.colorText,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                  ),
                  Text(
                    doa.translation,
                    style: const TextStyle(
                      fontSize: 15,
                      color: ColorConstant.colorText,
                      height: 1.65,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // KOTAK SUMBER HADITS
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE8F6F3), Color(0xFFD4EFE9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFFBBE5DC),
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.bookmark_rounded,
                      size: 20,
                      color: ColorConstant.colorPrimaryDark,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Sumber & Rujukan Hadits',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: ColorConstant.colorPrimaryDark,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          doa.reference,
                          style: const TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: ColorConstant.colorTextSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
