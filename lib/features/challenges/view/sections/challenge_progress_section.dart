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
        width: 358,
        height: 158,
        padding: const EdgeInsets.fromLTRB(19, 22, 19, 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF0DDAF),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// TITLE ROW
            Row(
              children: [
                Image.asset(
                  "assets/icons/achive.png",
                  width: 19.99,
                  height: 19.99,
                  color: AppColors.charcoal,
                ),

                const SizedBox(width: 8),

                const Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            /// PROGRESS LABEL + VALUE
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Your Progress",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal,
                  ),
                ),
                Text(
                  "$progress / $target $unit",
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            /// PROGRESS BAR
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progressPercentage,
                minHeight: 8,
                backgroundColor: Colors.white.withValues(alpha: 0.7),
                valueColor: const AlwaysStoppedAnimation(
                  AppColors.goldenOchre,
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// REMAINING TEXT
            Text(
              "$percentage% to go • $remaining $unit remaining",
              style: const TextStyle(
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