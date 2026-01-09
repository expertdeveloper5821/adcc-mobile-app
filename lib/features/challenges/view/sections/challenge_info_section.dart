import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChallengeInfoSection extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onShare;

  const ChallengeInfoSection({
    super.key,
    required this.title,
    required this.description,
    required this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepRed,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textDark,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: onShare,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.paleGreen.withValues(alpha: 0.36),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.share_outlined,
                color: AppColors.brand_green,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

