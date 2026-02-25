import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


class MyJoinedEventsSection extends StatelessWidget {
  const MyJoinedEventsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          /// -------- HEADER --------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Joined Events",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "View All",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.charcoal,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.chevron_right,
                      size: 18,
                      color: AppColors.charcoal,
                    ),
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 16),

          /// -------- CARD LIST --------
          SizedBox(
            height: 230,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              physics: const BouncingScrollPhysics(),
              itemCount: 3,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                return const _EventCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  const _EventCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 310,
      height: 230,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [

            /// -------- IMAGE --------
            Positioned.fill(
              child: Image.asset(
                "assets/images/cycling_1.png",
                fit: BoxFit.cover,
              ),
            ),

            /// Overlay
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.12),
              ),
            ),

            /// Featured chip
            Positioned(
              top: 12,
              left: 12,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.deepRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Featured",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// Share button
            Positioned(
              top: 12,
              right: 12,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.25),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.share,
                  size: 18,
                  color: Colors.red,
                ),
              ),
            ),

            /// Bottom Info Card
            Positioned(
              left: 12,
              right: 12,
              bottom: 12,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// Registered chip
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3EE606).withOpacity(0.30),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Registered",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF328700),
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      "Bike Abu Dhabi Gran Fondo 2025",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.charcoal,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Row(
                      children: const [
                        _MetaItem(icon: Icons.calendar_today, text: "Every Sunday"),
                        SizedBox(width: 12),
                        _MetaItem(icon: Icons.location_on_outlined, text: "Abu Dhabi"),
                        SizedBox(width: 12),
                        _MetaItem(icon: Icons.speed, text: "150 km"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MetaItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _MetaItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          Icon(icon, size: 14, color: AppColors.textSecondary),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}