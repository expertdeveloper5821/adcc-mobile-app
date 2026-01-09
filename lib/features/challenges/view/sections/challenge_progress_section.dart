import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChallengeProgressSection extends StatelessWidget {
  final int progress;
  final int target;
  final String unit;
  final int percentage;
  final int remaining;

  const ChallengeProgressSection({
    super.key,
    required this.progress,
    required this.target,
    required this.unit,
    required this.percentage,
    required this.remaining,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = (progress / target).clamp(0.0, 1.0);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.buttonGuest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title at the top (centered)
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.public,
                  size: 20,
                  color: AppColors.charcoal,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Label and numbers row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Your Progress',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal,
                  ),
                ),
                Text(
                  '$progress / $target $unit',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Progress bar
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercentage,
                minHeight: 8,
                backgroundColor: AppColors.softCream,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.goldenOchre,
                ),
              ),
            ),
            const SizedBox(height: 12),
            // Remaining text
            Text(
              '$percentage% to go • $remaining $unit remaining',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

