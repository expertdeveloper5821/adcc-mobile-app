import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteEventsSection extends StatelessWidget {
  final List<Map<String, dynamic>> events;

  const RouteEventsSection({
    super.key,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = events.isNotEmpty
        ? events
        : [
            {
              "image": "assets/images/cycling_1.png",
              "featured": true,
              "status": "Registered",
              "title": "Bike Abu Dhabi Gran Fondo 2025",
              "frequency": "Every Sunday",
              "location": "Abu Dhabi",
              "distance": "150 km",
            },
            {
              "image": "assets/images/cycling_1.png",
              "featured": false,
              "status": "Open",
              "title": "Hudayriyat Community Ride",
              "frequency": "Friday",
              "location": "Abu Dhabi",
              "distance": "35 km",
            },
            {
              "image": "assets/images/cycling_1.png",
              "featured": true,
              "status": "Registered",
              "title": "Night Ride at Yas Marina",
              "frequency": "Tomorrow",
              "location": "Abu Dhabi",
              "distance": "18 km",
            },
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Events on this track",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 210,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final e = data[index];

                return _EventCard(
                  imagePath: e["image"] as String,
                  title: e["title"] as String,
                  status: e["status"] as String,
                  frequency: e["frequency"] as String,
                  location: e["location"] as String,
                  distance: e["distance"] as String,
                  featured: e["featured"] as bool? ?? false,
                  onShareTap: () {},
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String status;
  final String frequency;
  final String location;
  final String distance;
  final bool featured;

  final VoidCallback onTap;
  final VoidCallback onShareTap;

  const _EventCard({
    required this.imagePath,
    required this.title,
    required this.status,
    required this.frequency,
    required this.location,
    required this.distance,
    required this.featured,
    required this.onTap,
    required this.onShareTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                // Background Image
                Positioned.fill(
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Container(color: AppColors.softCream);
                    },
                  ),
                ),

                // Overlay
                Positioned.fill(
                  child: Container(
                    color: Colors.black.withValues(alpha: 0.12),
                  ),
                ),

                // Featured chip
                if (featured)
                  const Positioned(
                    top: 12,
                    left: 12,
                    child: _MiniChip(text: "Featured"),
                  ),

                // Share button (image)
                Positioned(
                  top: 12,
                  right: 12,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.22),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onShareTap,
                      child: SizedBox(
                        width: 34,
                        height: 34,
                        child: Center(
                          child: Image.asset(
                            "assets/icons/share.png",
                            width: 18,
                            height: 18,
                            fit: BoxFit.contain,
                            errorBuilder: (_, __, ___) {
                              return const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 18,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Bottom info card
                Positioned(
                  left: 10,
                  right: 10,
                  bottom: 10,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Status chip
                        _MiniChip(text: status),

                        const SizedBox(height: 6),

                        Text(
                          title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Meta row (icons -> image)
                        Row(
                          children: [
                            const _AssetMetaIcon(
                              iconPath: "assets/icons/lighting.png",
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                frequency,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            const _AssetMetaIcon(
                              iconPath: "assets/icons/location.png",
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                location,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),

                            const SizedBox(width: 12),

                            const _AssetMetaIcon(
                              iconPath: "assets/icons/km.png",
                            ),
                            const SizedBox(width: 6),
                            Text(
                              distance,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textSecondary,
                              ),
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

/// ✅ Asset icon for meta row
class _AssetMetaIcon extends StatelessWidget {
  final String iconPath;

  const _AssetMetaIcon({
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      iconPath,
      width: 14,
      height: 14,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) {
        return const SizedBox(width: 14, height: 14);
      },
    );
  }
}

class _MiniChip extends StatelessWidget {
  final String text;

  const _MiniChip({
    required this.text,
  });

  bool get _isRegistered => text.toLowerCase().contains("registered");

  bool get _isFeatured => text.toLowerCase().contains("featured");

  @override
  Widget build(BuildContext context) {
    // Registered (Screenshot style)
    final Color bg = _isRegistered
        ? const Color(0xFF3EE606).withValues(alpha: 0.33)
        : _isFeatured
            ? AppColors.deepRed
            : const Color(0xFF328700);

    final Color fg = _isRegistered ? const Color(0xFF328700) : Colors.white;

    return Container(
      height: _isRegistered ? 20 : 24,
      width: _isRegistered ? 74 :74,
      padding: EdgeInsets.fromLTRB(
        9,
        _isRegistered ? 3 : 5,
        9,
        _isRegistered ? 4 : 5,
      ),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(_isRegistered ? 4.969 : 7.52),
      ),
      child: Center(
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: _isRegistered ? 9.983 : 11,
            fontWeight: FontWeight.w600,
            height: 1,
            color: fg,
          ),
        ),
      ),
    );
  }
}
