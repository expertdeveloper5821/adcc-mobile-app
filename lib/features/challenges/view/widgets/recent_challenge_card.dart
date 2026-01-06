import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RecentChallengeCard extends StatelessWidget {
  final String title;
  final String distance;
  final String duration;
  final String timeAgo;
  final VoidCallback? onTap;

  const RecentChallengeCard({
    super.key,
    required this.title,
    required this.distance,
    required this.duration,
    required this.timeAgo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.goldenOchre,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.directions_bike,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$distance • $duration • $timeAgo',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.charcoal.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            // Arrow
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.charcoal.withValues(alpha: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}

