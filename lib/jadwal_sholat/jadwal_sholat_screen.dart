import 'package:bitaqwa/jadwal_sholat/lokasi_model.dart';
import 'package:bitaqwa/jadwal_sholat/lokasi_service.dart';
import 'package:bitaqwa/jadwal_sholat/sholat_helper.dart';
import 'package:bitaqwa/jadwal_sholat/sholat_service.dart';
import 'package:bitaqwa/jadwal_sholat/time.dart';
import 'package:bitaqwa/jadwal_sholat/waktu_sholat_model.dart';
import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// SCREEN JADWAL SHOLAT: Menampilkan jadwal sholat harian dengan tema visual dinamis sesuai waktu
class JadwalSholatScreen extends StatefulWidget {
  const JadwalSholatScreen({super.key});

  @override
  State<JadwalSholatScreen> createState() => _JadwalSholatScreenState();
}

class _JadwalSholatScreenState extends State<JadwalSholatScreen> {
  String _location = "Mengambil lokasi...";
  bool _isLoading = true;
  PrayerTimeModel? prayerTime;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // 1. Koordinat default awal (Jakarta) agar UI langsung responsif tanpa nunggu GPS
      double lat = -6.2088;
      double lon = 106.8456;
      String cityName = "Jakarta";

      // 2. Coba deteksi lokasi asli di background (maksimal 2 detik)
      try {
        final location = await LocationService()
            .getCurrentLocation()
            .timeout(const Duration(seconds: 2));
        lat = location.latitude;
        lon = location.longitude;
        cityName = location.city.isNotEmpty ? location.city : "Jakarta";
      } catch (e) {
        debugPrint("Location fallback default to Jakarta: $e");
      }

      if (!mounted) return;

      // 3. Ambil data sholat (maksimal 3 detik)
      final prayer = await PrayerService().getPrayerTimes(
        latitude: lat,
        longitude: lon,
      );

      if (!mounted) return;

      setState(() {
        _location = cityName;
        prayerTime = prayer;
      });
    } catch (e) {
      debugPrint("Error loadData sholat: $e");
      if (!mounted) return;
      setState(() {
        prayerTime = null;
        _location = "Jakarta";
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Mendapatkan gradasi langit sesuai waktu sholat (Dzuhur cerah siang hari, Maghrib senja, dll)
  LinearGradient _getPrayerGradient(String prayerName) {
    switch (prayerName) {
      case 'Dzuhur':
        // Langit siang hari yang cerah, terang, dan segar
        return const LinearGradient(
          colors: [Color(0xFF0072B5), Color(0xFF33A9DC), Color(0xFF86E3CE)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Ashar':
        // Langit sore hangat menjelang senja
        return const LinearGradient(
          colors: [Color(0xFF1E528E), Color(0xFF4389A2), Color(0xFF7CB88F)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Maghrib':
        // Warna langit senja yang syahdu
        return const LinearGradient(
          colors: [Color(0xFF2C3E50), Color(0xFF8E44AD), Color(0xFFE67E22)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Isya':
        // Langit malam bertabur bintang
        return const LinearGradient(
          colors: [Color(0xFF0B192C), Color(0xFF1E3E62), Color(0xFF000000)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case 'Subuh':
      default:
        // Fajar pagi hari yang tenang dan sejuk
        return const LinearGradient(
          colors: [Color(0xFF0D5C75), Color(0xFF1995AD), Color(0xFFA1D6E2)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.colorBackground,
      appBar: AppBar(
        title: const Text('Jadwal Sholat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacementNamed(context, '/');
            }
          },
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: ColorConstant.colorPrimary),
      );
    }

    if (prayerTime == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: ColorConstant.colorAccent,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.cloud_off_rounded,
                  size: 48,
                  color: ColorConstant.colorPrimary,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Gagal Mengambil Jadwal Sholat",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorText,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Pastikan izin lokasi dan koneksi internet Anda aktif.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  color: ColorConstant.colorTextSecondary,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: loadData,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text("Coba Lagi"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.colorPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return _buildContent();
  }

  Widget _buildContent() {
    final nextPrayer = prayerTime != null
        ? PrayerHelper.getNextPrayer(prayerTime!)
        : null;

    final prayerName = nextPrayer?['name'] ?? 'Dzuhur';
    final prayerGradient = _getPrayerGradient(prayerName);

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // BANNER HEADER WAKTU SHOLAT DINAMIS
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: prayerGradient,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Ornamen Awan / Dekorasi
                Positioned(
                  top: 20,
                  left: 20,
                  child: Icon(
                    Icons.cloud_rounded,
                    color: Colors.white.withValues(alpha: 0.35),
                    size: 40,
                  ),
                ),
                Positioned(
                  top: 80,
                  right: 24,
                  child: Icon(
                    Icons.cloud_rounded,
                    color: Colors.white.withValues(alpha: 0.25),
                    size: 32,
                  ),
                ),
                if (prayerName == 'Dzuhur')
                  Positioned(
                    top: 25,
                    right: 30,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.amber.withValues(alpha: 0.4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.amber.withValues(alpha: 0.5),
                            blurRadius: 20,
                            spreadRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.wb_sunny_rounded,
                        color: Colors.amber,
                        size: 32,
                      ),
                    ),
                  ),

                // Konten Waktu Sholat
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 34),
                  child: Column(
                    children: [
                      // Tanggal Hari Ini
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Text(
                          DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now()),
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),

                      // Badge Nama Sholat Berikutnya
                      Text(
                        'Menuju Waktu $prayerName',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.95),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Waktu Jam Sholat Besar
                      Text(
                        nextPrayer?['time'] ?? '--:--',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 46,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Lokasi GPS Pengguna
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              size: 16,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              _location,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // LIST KARTU 5 WAKTU SHOLAT
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildPrayerCard(prayerName),
          ),
          const SizedBox(height: 36),
        ],
      ),
    );
  }

  Widget _buildPrayerCard(String currentNextPrayer) {
    final prayers = [
      {"name": "Subuh", "time": prayerTime!.fajr},
      {"name": "Dzuhur", "time": prayerTime!.dhuhr},
      {"name": "Ashar", "time": prayerTime!.asr},
      {"name": "Maghrib", "time": prayerTime!.maghrib},
      {"name": "Isya", "time": prayerTime!.isha},
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFF1F5F9),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorConstant.colorPrimary.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(
                Icons.access_time_filled_rounded,
                size: 20,
                color: ColorConstant.colorPrimary,
              ),
              SizedBox(width: 8),
              Text(
                'Waktu Sholat Hari Ini',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.colorText,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 14),
            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prayers.length,
            separatorBuilder: (_, _) => const Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Divider(height: 1, color: Color(0xFFF8FAFC)),
            ),
            itemBuilder: (context, index) {
              final prayer = prayers[index];
              final isCurrent = prayer["name"] == currentNextPrayer;

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  color: isCurrent
                      ? ColorConstant.colorAccent
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(14),
                  border: isCurrent
                      ? Border.all(
                          color: ColorConstant.colorPrimaryLight.withValues(alpha: 0.6),
                          width: 1.5,
                        )
                      : null,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? ColorConstant.colorPrimary
                            : ColorConstant.colorBackground,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.alarm_rounded,
                        size: 18,
                        color: isCurrent
                            ? Colors.white
                            : ColorConstant.colorTextSecondary,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      prayer["name"] as String,
                      style: TextStyle(
                        color: isCurrent
                            ? ColorConstant.colorPrimaryDark
                            : ColorConstant.colorText,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    if (isCurrent) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: ColorConstant.colorPrimaryDark,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Berikutnya',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      prayer["time"] as String,
                      style: TextStyle(
                        color: isCurrent
                            ? ColorConstant.colorPrimaryDark
                            : ColorConstant.colorText,
                        fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
