import 'package:bitaqwa/doa_harian/doa_list_screen.dart';
import 'package:bitaqwa/doa_harian/kategori_doa_ext.dart';
import 'package:bitaqwa/doa_harian/kategori_doa_model.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';

// WIDGET CARD DOA: Komponen kartu visual kategori doa bergaya soft modern Emerald
class CardDoa extends StatelessWidget {
  final KategoriDoaModel doa;

  const CardDoa({super.key, required this.doa});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DoaListScreen(category: doa.category),
            ),
          );
        },
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: ColorConstant.colorPrimary.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 5),
              ),
            ],
            border: Border.all(
              color: Colors.white,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE8F6F3), Color(0xFFD0EFE8)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.colorPrimary.withValues(alpha: 0.12),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset(
                  doa.category.image,
                  height: 48,
                  width: 48,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.auto_stories_rounded,
                    size: 38,
                    color: ColorConstant.colorPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  doa.category.title,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.colorText,
                    height: 1.25,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
