import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteDetailsGridSection extends StatelessWidget {
  final Map<String, String> routeDetails;

  const RouteDetailsGridSection({
    super.key,
    required this.routeDetails,
  });

  @override
  Widget build(BuildContext context) {
    final entries = routeDetails.entries.toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Route Details",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          LayoutBuilder(
            builder: (context, constraints) {
            
              const figmaTotalWidth = 357.0;

              // scale down only if screen is smaller
              final scale = (constraints.maxWidth / figmaTotalWidth).clamp(0.85, 1.0);

              return Transform.scale(
                scale: scale,
                alignment: Alignment.topLeft,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ✅ Left 2x2
                    Column(
                      children: [
                        Row(
                          children: [
                            _RouteDetailSmallCard(
                              label: entries.isNotEmpty ? entries[0].key : "Distance",
                              value: entries.isNotEmpty ? entries[0].value : "10 km",
                            ),
                            const SizedBox(width: 12),
                            _RouteDetailSmallCard(
                              label: entries.length > 1 ? entries[1].key : "Elevation",
                              value: entries.length > 1 ? entries[1].value : "+12m",
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _RouteDetailSmallCard(
                              label: entries.length > 2 ? entries[2].key : "Type",
                              value: entries.length > 2 ? entries[2].value : "Loop Track",
                            ),
                            const SizedBox(width: 12),
                            _RouteDetailSmallCard(
                              label: entries.length > 3 ? entries[3].key : "Avg Time",
                              value: entries.length > 3 ? entries[3].value : "18–25 min",
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(width: 12),

                    // ✅ Right Tall Card
                    _RouteDetailTallCard(
                      label: entries.length > 4 ? entries[4].key : "Pace",
                      value: entries.length > 4 ? entries[4].value : "Beginner / Casual",
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

// =========================
// ✅ Small Card (111x75)
// =========================
class _RouteDetailSmallCard extends StatelessWidget {
  final String label;
  final String value;

  const _RouteDetailSmallCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 102,
      height: 75,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon + label
            Row(
              children: [
                Image.asset(
                  "assets/icons/star.png",
                  width: 16,
                  height: 16,
                  fit: BoxFit.contain,
                  errorBuilder: (_, __, ___) {
                    return const Icon(
                      Icons.star_outline,
                      size: 16,
                      color: AppColors.deepRed,
                    );
                  },
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      height: 1,
                      color: AppColors.charcoal,
                    ),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // value aligned under label
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textDark,
                  height: 1.15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =========================
// ✅ Tall Card (111x163)
// =========================
class _RouteDetailTallCard extends StatelessWidget {
  final String label;
  final String value;

  const _RouteDetailTallCard({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 111,
      height: 163, // ✅ figma exact
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // icon top
            Image.asset(
              "assets/icons/star.png",
              width: 16,
              height: 16,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) {
                return const Icon(
                  Icons.star_outline,
                  size: 16,
                  color: AppColors.deepRed,
                );
              },
            ),

            const Spacer(),

            // label + value bottom
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                height: 1,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 6),

            Text(
              value,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textDark,
                height: 1.15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
