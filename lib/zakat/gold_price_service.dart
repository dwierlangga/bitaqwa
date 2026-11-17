import 'dart:convert';
import 'package:http/http.dart' as http;

// SERVICE HARGA EMAS: Mengambil harga emas per gram terkini secara online via API publik
class GoldPriceService {
  // Nilai default cadangan jika internet offline atau API sedang tidak dapat dijangkau
  static const int fallbackGoldPricePerGram = 1450000;

  Future<int> getGoldPricePerGram() async {
    // 1. Coba Endpoint 1: GoldPrice Open JSON Feed (Global Spot Rate to IDR)
    try {
      final response = await http
          .get(
            Uri.parse('https://data-asg.goldprice.org/dbXRates/IDR'),
            headers: {'User-Agent': 'Mozilla/5.0 (Bitaqwa App)'},
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['items'] != null && (data['items'] as List).isNotEmpty) {
          final item = data['items'][0];
          final num? xauPricePerOunce = item['xauPrice'];
          if (xauPricePerOunce != null && xauPricePerOunce > 0) {
            // 1 Troy Ounce = 31.1034768 gram
            final double pricePerGram = xauPricePerOunce / 31.1034768;
            return pricePerGram.round();
          }
        }
      }
    } catch (_) {
      // Lanjut mencoba endpoint cadangan kedua
    }

    // 2. Coba Endpoint 2: GoldPrice.dev keyless convert endpoint
    try {
      final response = await http
          .get(
            Uri.parse('https://api.goldprice.dev/v1/convert?from=XAU&to=IDR&amount=1&unit=gram'),
          )
          .timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data != null && data['result'] != null) {
          final double? price = double.tryParse(data['result'].toString());
          if (price != null && price > 0) {
            return price.round();
          }
        }
      }
    } catch (_) {
      // Abaikan dan gunakan nilai cadangan pasar terkini
    }

    return fallbackGoldPricePerGram;
  }
}

