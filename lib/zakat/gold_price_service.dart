import 'dart:convert';
import 'package:http/http.dart' as http;

// SERVICE HARGA EMAS: Mengambil harga emas per gram terkini secara online via API publik
class GoldPriceService {
  // Nilai default cadangan jika internet offline atau API sedang tidak dapat dijangkau
  static const int fallbackGoldPricePerGram = 1450000;

  // In-Memory Cache: simpan harga yang sudah didapat agar tidak perlu menembak internet berulang kali
  static int? _cachedPrice;
  static DateTime? _lastFetchTime;

  Future<int> getGoldPricePerGram() async {
    // Jika sudah ada cache kurang dari 30 menit, pakai cache langsung (0 detik, tanpa lemot)
    if (_cachedPrice != null &&
        _lastFetchTime != null &&
        DateTime.now().difference(_lastFetchTime!).inMinutes < 30) {
      return _cachedPrice!;
    }

    // 1. Coba Endpoint 1: GoldPrice Open JSON Feed (Global Spot Rate to IDR)
    try {
      final response = await http
          .get(
            Uri.parse('https://data-asg.goldprice.org/dbXRates/IDR'),
            headers: {'User-Agent': 'Mozilla/5.0 (Bitaqwa App)'},
          )
          .timeout(const Duration(seconds: 2)); // Timeout dipersingkat agar tidak lemot

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['items'] != null && (data['items'] as List).isNotEmpty) {
          final item = data['items'][0];
          final num? xauPricePerOunce = item['xauPrice'];
          if (xauPricePerOunce != null && xauPricePerOunce > 0) {
            final double pricePerGram = xauPricePerOunce / 31.1034768;
            _cachedPrice = pricePerGram.round();
            _lastFetchTime = DateTime.now();
            return _cachedPrice!;
          }
        }
      }
    } catch (_) {}

    return _cachedPrice ?? fallbackGoldPricePerGram;
  }
}

