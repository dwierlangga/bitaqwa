import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:bitaqwa/dashboard/color_constant.dart';

// SCREEN DETAIL VIDEO KAJIAN: Memutar video YouTube langsung di dalam aplikasi
class DetailVideoKajianScreen extends StatefulWidget {
  final String url;
  final String account;
  final String ustadz;
  final String title;
  final String description;

  const DetailVideoKajianScreen({
    super.key,
    required this.url,
    required this.account,
    required this.ustadz,
    required this.title,
    required this.description,
  });

  @override
  State<DetailVideoKajianScreen> createState() =>
      _DetailVideoKajianScreenState();
}

class _DetailVideoKajianScreenState extends State<DetailVideoKajianScreen> {
  // Kontroler pemutar YouTube
  late final YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    // 1. Mengubah URL YouTube menjadi Video ID (misal: "kOnZ_Jv_C6k")
    final videoId = YoutubePlayerController.convertUrlToId(widget.url);

    if (videoId == null) {
      throw Exception("URL Youtube tidak valid : \${widget.url}");
    }

    // 2. Konfigurasi kontroler YouTube player
    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableJavaScript: true,
        strictRelatedVideos: true,
      ),
    );

    // 3. Listener saat video siap dimainkan
    _controller.listen((value) {
      if (!_isPlayerReady && value.playerState != PlayerState.unknown) {
        setState(() {
          _isPlayerReady = true;
        });
      }
    });

    // 4. Memuat video berdasarkan videoId
    _controller.loadVideoById(videoId: videoId);
  }

  @override
  void dispose() {
    // Menutup pemutar saat keluar dari layar agar memori HP bersih
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8FAFC),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: ColorConstant.colorText,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Detail Kajian',
            style: TextStyle(
              color: ColorConstant.colorText,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Player YouTube dengan rounded corner halus
              Container(
                margin: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: YoutubePlayer(controller: _controller),
                ),
              ),
              if (!_isPlayerReady)
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: LinearProgressIndicator(),
                ),

              const SizedBox(height: 8),

              // Kotak Informasi Konten Video
              Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Ustadz & Channel
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.colorAccent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            widget.ustadz,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: ColorConstant.colorPrimaryDark,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.account,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Judul Video
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.colorText,
                        height: 1.35,
                      ),
                    ),

                    const Divider(height: 28),

                    // Label Deskripsi
                    const Text(
                      'Deskripsi Kajian',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.colorText,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Isi Deskripsi
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.6,
                        color: ColorConstant.colorText.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
