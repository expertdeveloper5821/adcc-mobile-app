import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:flutter/material.dart';

class CommunityHorizontalCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final VoidCallback onExplore;

  const CommunityHorizontalCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.onExplore,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.lightOliveGreen.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.charcoal,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      maxLines: 4,               
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: onExplore,
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.softCream,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Text(
                      'Explore Community →',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.deepRed,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          /// RIGHT IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AdaptiveImage(
              imagePath: imagePath,
              width: 150,
              height: 200,
              fit: BoxFit.cover,
              placeholderColor: AppColors.softCream,
            ),
          ),
        ],
      ),
    );
  }
}
