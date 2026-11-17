import 'package:bitaqwa/theme/color_constant.dart';
import 'package:bitaqwa/zakat/card_result_harta.dart';
import 'package:bitaqwa/zakat/gold_price_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// SCREEN ZAKAT: Kalkulator pintar zakat mal dengan format titik ribuan otomatis
class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  final TextEditingController _totalHartaController = TextEditingController();

  // State Data Perhitungan
  int _totalHarta = 0;
  int _zakatDikeluarkan = 0;
  bool _isWajibZakat = false;

  // State Harga Emas & Nishab Otomatis
  int _goldPricePerGram = GoldPriceService.fallbackGoldPricePerGram;
  bool _isLoadingGoldPrice = true;
  bool _isLivePrice = false;

  final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  final NumberFormat _thousandFormat = NumberFormat.decimalPattern('id_ID');

  // Nilai Nishab: 85 gram x Harga Emas per Gram Terkini
  int get _calculatedNishab => _goldPricePerGram * 85;

  @override
  void initState() {
    super.initState();
    _fetchLiveGoldPrice();
  }

  @override
  void dispose() {
    _totalHartaController.dispose();
    super.dispose();
  }

  // Mengambil harga emas pasar terkini secara otomatis via API
  Future<void> _fetchLiveGoldPrice() async {
    setState(() {
      _isLoadingGoldPrice = true;
    });

    try {
      final price = await GoldPriceService().getGoldPricePerGram();
      setState(() {
        _goldPricePerGram = price;
        _isLivePrice = (price != GoldPriceService.fallbackGoldPricePerGram);
        _isLoadingGoldPrice = false;
      });
      if (_totalHarta > 0) {
        _hitungZakat();
      }
    } catch (_) {
      setState(() {
        _isLoadingGoldPrice = false;
      });
    }
  }

  void _hitungZakat() {
    final String cleanText =
        _totalHartaController.text.replaceAll(RegExp(r'[^0-9]'), '');
    final int harta = int.tryParse(cleanText) ?? 0;

    setState(() {
      _totalHarta = harta;
      if (_totalHarta >= _calculatedNishab) {
        _isWajibZakat = true;
        _zakatDikeluarkan = (_totalHarta * 0.025).round();
      } else {
        _isWajibZakat = false;
        _zakatDikeluarkan = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Kalkulator Zakat Mal',
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
        actions: [
          IconButton(
            tooltip: 'Perbarui Harga Emas',
            icon: _isLoadingGoldPrice
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : const Icon(Icons.refresh_rounded, color: Colors.white),
            onPressed: _isLoadingGoldPrice ? null : _fetchLiveGoldPrice,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // KARTU EDUKASI & LIVE STATUS HARGA EMAS OTOMATIS
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFE8F6F3), Color(0xFFD4EFE9)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: const Color(0xFFBBE5DC),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorPrimary.withValues(alpha: 0.08),
                    blurRadius: 14,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.auto_graph_rounded,
                            color: ColorConstant.colorPrimaryDark,
                            size: 20,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'Harga Emas Terkini (Live)',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.colorPrimaryDark,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: _isLivePrice
                              ? const Color(0xFF16A34A).withValues(alpha: 0.15)
                              : ColorConstant.colorPrimary
                                  .withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _isLoadingGoldPrice
                              ? 'Sinkronisasi...'
                              : (_isLivePrice ? '● Real-time API' : '● Pasar Est.'),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: _isLivePrice
                                ? const Color(0xFF15803D)
                                : ColorConstant.colorPrimaryDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Harga Emas / Gram:',
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorConstant.colorTextSecondary,
                        ),
                      ),
                      Text(
                        _currencyFormat.format(_goldPricePerGram),
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.colorText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Standar Nishab (85g Emas):',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: ColorConstant.colorPrimaryDark,
                        ),
                      ),
                      Text(
                        _currencyFormat.format(_calculatedNishab),
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: ColorConstant.colorPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Divider(height: 1, color: Color(0xFFBBE5DC)),
                  ),
                  const Text(
                    'Kewajiban zakat mal 2.5% berlaku jika total kepemilikan harta selama 1 tahun (haul) telah mencapai atau melebihi batas nishab di atas.',
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.45,
                      color: ColorConstant.colorTextSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // FORM INPUT DENGAN ELEVASI CARD MODERN
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: ColorConstant.colorPrimary.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 5),
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
                  const Text(
                    'Jumlah Harta Anda',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: ColorConstant.colorText,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Masukkan total tabungan, simpanan, atau aset lancar',
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorConstant.colorTextSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _totalHartaController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      ThousandsSeparatorInputFormatter(_thousandFormat),
                    ],
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: ColorConstant.colorText,
                      letterSpacing: 0.5,
                    ),
                    decoration: InputDecoration(
                      prefixText: 'Rp ',
                      prefixStyle: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.colorPrimaryDark,
                      ),
                      hintText: 'Contoh: 150.000.000',
                      hintStyle: const TextStyle(
                        fontSize: 14,
                        color: ColorConstant.colorTextLight,
                        fontWeight: FontWeight.normal,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF8FAFC),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(
                          color: ColorConstant.colorPrimary,
                          width: 2,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.account_balance_wallet_outlined,
                        color: ColorConstant.colorPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol Hitung Gradasi Emerald
                  Container(
                    width: double.infinity,
                    height: 52,
                    decoration: BoxDecoration(
                      gradient: ColorConstant.primaryGradient,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstant.colorPrimary
                              .withValues(alpha: 0.35),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: _hitungZakat,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.calculate_rounded,
                              color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Hitung Zakat Sekarang',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // KARTU HASIL PERHITUNGAN
            if (_totalHarta > 0) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    Container(
                      width: 4,
                      height: 16,
                      decoration: BoxDecoration(
                        color: ColorConstant.colorPrimary,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Ringkasan Perhitungan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.colorText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              CardResultHarta(
                title: 'Total Harta Anda',
                value: _currencyFormat.format(_totalHarta),
                icon: Icons.payments_outlined,
              ),
              const SizedBox(height: 12),
              CardResultHarta(
                title: 'Status Kewajiban (Nishab: ${_currencyFormat.format(_calculatedNishab)})',
                value: _isWajibZakat
                    ? 'Wajib Bayar Zakat'
                    : 'Belum Wajib (Belum Nishab)',
                isHighlight: _isWajibZakat,
                icon: _isWajibZakat
                    ? Icons.check_circle_outline_rounded
                    : Icons.info_outline_rounded,
              ),
              const SizedBox(height: 12),
              CardResultHarta(
                title: 'Zakat yang Dikeluarkan (2.5%)',
                value: _currencyFormat.format(_zakatDikeluarkan),
                isImportant: true,
                icon: Icons.volunteer_activism_outlined,
              ),
              const SizedBox(height: 30),
            ],
          ],
        ),
      ),
    );
  }
}

// FORMATTER: Menambahkan tanda titik pemisah ribuan secara otomatis saat pengguna mengetik
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  final NumberFormat formatter;

  ThousandsSeparatorInputFormatter(this.formatter);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Ambil hanya angka murni
    final digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.isEmpty) {
      return const TextEditingValue();
    }

    final number = int.tryParse(digitsOnly);
    if (number == null) {
      return oldValue;
    }

    // Format menjadi format ribuan dengan titik (contoh: 100 -> 100, 1000 -> 1.000, 1000000 -> 1.000.000)
    final formatted = formatter.format(number);

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
