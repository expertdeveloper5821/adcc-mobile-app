import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/adaptive_image.dart';

class AcceptedNewBadgeSection extends StatelessWidget {
  final String badgeName;
  final String badgeDescription;
  final String? imagePath;

  const AcceptedNewBadgeSection({
    super.key,
    required this.badgeName,
    required this.badgeDescription,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image on the left - aligned to top, stretches to content height
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AdaptiveImage(
              imagePath: imagePath ?? 'assets/images/cycling_1.png',
              width: 120,
              height: 150,
              fit: BoxFit.cover,
              placeholderColor: AppColors.softCream,
            ),
          ),
          const SizedBox(width: 16),
          // Badge info on the right
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Badge icon - circular with badge inside
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.goldenOchre.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Container(
                      width: 55,
                      height: 55,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.dustyRose,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        'assets/svg/win_badge.svg',
                         fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // "New Badge Earned!" text
                const Text(
                  'New Badge Earned!',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 8),
                // Badge name
                Text(
                  badgeName,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                // Badge description
                Text(
                  badgeDescription,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.charcoal.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
