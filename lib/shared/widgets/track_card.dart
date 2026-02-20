import 'dart:convert';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class TrackCard extends StatelessWidget {
  final String imagePath; // asset OR url OR base64(data:image...)
  final String title;
  final String city;
  final String distance;
  final String subtitle;
  final String difficulty;
  final String status;

  final VoidCallback? onTap;

  // sizing
  final double width;
  final double height;

  const TrackCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.city,
    required this.distance,
    required this.subtitle,
    required this.difficulty,
    required this.status,
    this.onTap,
    this.width = double.infinity,
    this.height = 281,
  });

 
  Widget _buildTrackImage() {
    // 1) BASE64 image: data:image/jpeg;base64,xxxx
    if (imagePath.startsWith("data:image")) {
      try {
        final base64Str = imagePath.split(",").last;
        final bytes = base64Decode(base64Str);

        return Image.memory(
          bytes,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          errorBuilder: (_, __, ___) => _errorImage(),
        );
      } catch (_) {
        return _errorImage();
      }
    }

    // 2) NETWORK image: https://....
    if (imagePath.startsWith("http")) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => _errorImage(),
      );
    }

    // 3) ASSET image fallback
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: (_, __, ___) => _errorImage(),
    );
  }

  Widget _errorImage() {
    return Container(
      color: const Color(0xFFD94A4A),
      alignment: Alignment.center,
      child: const Icon(
        Icons.image,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.buttonGuest,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: _buildTrackImage(),
                        ),

                        // overlay
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.08),
                          ),
                        ),

                        // Left chip
                        Positioned(
                          left: 12,
                          top: 12,
                          child: _SmallChip(
                            text: difficulty,
                            bg: Colors.black.withValues(alpha: 0.28),
                            fg: Colors.white,
                          ),
                        ),

                        // Right chip
                        Positioned(
                          right: 12,
                          top: 12,
                          child: _SmallChip(
                            text: status,
                            bg: Colors.black.withValues(alpha: 0.28),
                            fg: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //  CONTENT
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Location + distance row
                        Row(
                          children: [
                            const _AssetIcon(
                              assetPath: "assets/icons/location.png",
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                city,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const _AssetIcon(
                              assetPath: "assets/icons/km.png",
                              size: 18,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              distance,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        // Title
                        Text(
                          title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w800,
                            color: Colors.black,
                          ),
                        ),

                        const SizedBox(height: 10),

                        // Subtitle
                        Text(
                          subtitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w600,
                            color: Colors.black45,
                            height: 1.25,
                          ),
                        ),

                        const Spacer(),

                        // Amenities row (static)
                        const Row(
                          children: [
                            _AmenityItem(
                              iconPath: "assets/icons/lighting.png",
                              label: 'Lighting',
                            ),
                            SizedBox(width: 14),
                            _AmenityItem(
                              iconPath: "assets/icons/water_statoins.png",
                              label: 'Water stataion',
                            ),
                            SizedBox(width: 14),
                            _AmenityItem(
                              iconPath: "assets/icons/restrooms.png",
                              label: 'Restroom',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class _SmallChip extends StatelessWidget {
  final String text;
  final Color bg;
  final Color fg;

  const _SmallChip({
    required this.text,
    required this.bg,
    required this.fg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 11.5,
          fontWeight: FontWeight.w800,
          color: fg,
        ),
      ),
    );
  }
}

class _AssetIcon extends StatelessWidget {
  final String assetPath;
  final double size;

  const _AssetIcon({
    required this.assetPath,
    this.size = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      assetPath,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) {
        return Icon(Icons.image, size: size, color: Colors.black54);
      },
    );
  }
}


class _AmenityItem extends StatelessWidget {
  final String iconPath;
  final String label;

  const _AmenityItem({
    required this.iconPath,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _AssetIcon(assetPath: iconPath, size: 16),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
