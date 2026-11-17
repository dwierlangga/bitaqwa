import 'package:bitaqwa/theme/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// SCREEN DETAIL VIDEO KAJIAN: Tampilan pemutar video YouTube modern, rapi, dan responsif
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
  late final YoutubePlayerController _controller;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();

    final videoId = YoutubePlayerController.convertUrlToId(widget.url);

    if (videoId == null) {
      throw Exception("URL Youtube tidak valid : ${widget.url}");
    }

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        enableJavaScript: true,
        strictRelatedVideos: true,
      ),
    );

    _controller.listen((value) {
      if (!_isPlayerReady && value.playerState != PlayerState.unknown) {
        setState(() {
          _isPlayerReady = true;
        });
      }
    });

    _controller.loadVideoById(videoId: videoId);
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
      controller: _controller,
      child: Scaffold(
        backgroundColor: ColorConstant.colorBackground,
        appBar: AppBar(
          backgroundColor: ColorConstant.colorPrimary,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            'Pemutar Kajian',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Frame Pemutar Video dengan Sudut Melengkung & Bayangan
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.15),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: YoutubePlayer(controller: _controller),
              ),
              if (!_isPlayerReady)
                const LinearProgressIndicator(
                  color: ColorConstant.colorPrimary,
                  backgroundColor: ColorConstant.colorAccent,
                ),

              // Detail Informasi Kajian
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Badge Akun & Ustadz
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                          decoration: BoxDecoration(
                            color: ColorConstant.colorAccent,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: ColorConstant.colorPrimaryLight.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.person_rounded,
                                size: 14,
                                color: ColorConstant.colorPrimaryDark,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.ustadz,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.colorPrimaryDark,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.account,
                            style: const TextStyle(
                              fontSize: 12,
                              color: ColorConstant.colorTextSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Judul Kajian
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.colorText,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Kotak Deskripsi Kajian Modern
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFFF1F5F9),
                          width: 1.5,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Icon(
                                Icons.notes_rounded,
                                size: 18,
                                color: ColorConstant.colorPrimary,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Ringkasan & Pembahasan',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: ColorConstant.colorText,
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            child: Divider(height: 1, color: Color(0xFFF1F5F9)),
                          ),
                          Text(
                            widget.description,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.65,
                              color: ColorConstant.colorTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
