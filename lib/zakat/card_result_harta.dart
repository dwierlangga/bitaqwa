import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';

// WIDGET CARD RESULT HARTA: Kotak kartu ringkasan hasil perhitungan zakat bergaya Emerald modern
class CardResultHarta extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final bool isHighlight;
  final bool isImportant;

  const CardResultHarta({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.isHighlight = false,
    this.isImportant = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isImportant ? const Color(0xFFE8F6F3) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isImportant
              ? const Color(0xFFBBE5DC)
              : (isHighlight
                  ? const Color(0xFF86EFAC)
                  : const Color(0xFFF1F5F9)),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: isImportant
                ? ColorConstant.colorPrimary.withValues(alpha: 0.1)
                : Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isImportant
                    ? ColorConstant.colorPrimary.withValues(alpha: 0.15)
                    : (isHighlight
                        ? const Color(0xFFDCFCE7)
                        : ColorConstant.colorAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: isImportant
                    ? ColorConstant.colorPrimaryDark
                    : (isHighlight
                        ? const Color(0xFF16A34A)
                        : ColorConstant.colorPrimary),
              ),
            ),
            const SizedBox(width: 14),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: ColorConstant.colorTextSecondary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isImportant ? 18 : 16,
                    fontWeight: FontWeight.bold,
                    color: isImportant
                        ? ColorConstant.colorPrimaryDark
                        : (isHighlight
                            ? const Color(0xFF15803D)
                            : ColorConstant.colorText),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
