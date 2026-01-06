import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';

class StoreProductInfoSection extends StatelessWidget {
  final String title;
  final String location;
  final String timePosted;
  final String currentPrice;
  final String? originalPrice;
  final bool isNegotiable;

  const StoreProductInfoSection({
    super.key,
    required this.title,
    required this.location,
    required this.timePosted,
    required this.currentPrice,
    this.originalPrice,
    this.isNegotiable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Title
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 12),

          // Location and Time
          Row(
            children: [
              const Icon(
                Icons.location_on,
                size: 16,
                color: AppColors.charcoal,
              ),
              const SizedBox(width: 4),
              Text(
                location,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.charcoal,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.charcoal,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.access_time,
                size: 16,
                color: AppColors.charcoal,
              ),
              const SizedBox(width: 4),
              Text(
                timePosted,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.charcoal,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Price Section
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Current Price
                    Text(
                      currentPrice,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepRed,
                      ),
                    ),
                    // Original Price (if available)
                    if (originalPrice != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        originalPrice!,
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.charcoal.withValues(alpha: 0.8),
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              // Negotiable Button
              if (isNegotiable)
                AppButton(
                  label: 'Negotiable',
                  onPressed: () {
                    // Handle negotiable tap
                  },
                  type: AppButtonType.secondary,
                  borderColor: AppColors.textDark,
                  // backgroundColor: AppColors.dustyRose,
                  textColor: AppColors.textDark,
                  height: 30,
                  width: 120,
                  borderRadius: 20,
                  textStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

