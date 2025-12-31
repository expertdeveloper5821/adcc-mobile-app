import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';

class RoutePreviewSection extends StatelessWidget {
  final VoidCallback? onStartRide;

  const RoutePreviewSection({
    super.key,
    this.onStartRide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Route Preview',
            style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          // Map Preview
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: AppColors.charcoal,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Placeholder for map
                Center(
                  child: Icon(
                    Icons.map,
                    size: 48,
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                // Location pin and direction indicator
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 50,
                  top: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 + 20,
                  top: 85,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '1km',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Start Ride Button
          AppButton(
            label: 'Start Ride',
            onPressed: onStartRide,
            type: AppButtonType.primary,
            backgroundColor: AppColors.deepRed,
            prefixIcon: Icons.play_arrow,
          ),
        ],
      ),
    );
  }
}

