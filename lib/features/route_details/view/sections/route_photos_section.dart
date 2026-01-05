import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RoutePhotosSection extends StatelessWidget {
  final List<String> photoPaths;

  const RoutePhotosSection({
    super.key,
    required this.photoPaths,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Route Views & Community Photos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // First column: Long image (wider)
              Expanded(
                flex: 3, // More width for long image
                child: photoPaths.isNotEmpty
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          photoPaths[0],
                          height: 200, // Tall image height
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 200,
                              color: AppColors.softCream,
                              child: const Icon(
                                Icons.image,
                                size: 48,
                                color: AppColors.textSecondary,
                              ),
                            );
                          },
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
              const SizedBox(width: 12),
              // Second column: Two images stacked (narrower)
              Expanded(
                flex: 2, // Less width for right column
                child: Column(
                  children: [
                    // Top image
                    if (photoPaths.length > 1)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          photoPaths[1],
                          height: 94, // Half of 200 minus spacing
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 94,
                              color: AppColors.softCream,
                              child: const Icon(
                                Icons.image,
                                size: 48,
                                color: AppColors.textSecondary,
                              ),
                            );
                          },
                        ),
                      ),
                    if (photoPaths.length > 1) const SizedBox(height: 12),
                    // Bottom image
                    if (photoPaths.length > 2)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          photoPaths[2],
                          height: 94, // Half of 200 minus spacing
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 94,
                              color: AppColors.softCream,
                              child: const Icon(
                                Icons.image,
                                size: 48,
                                color: AppColors.textSecondary,
                              ),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

