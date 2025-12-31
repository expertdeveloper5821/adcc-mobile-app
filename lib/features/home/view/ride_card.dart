import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class RideCard extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const RideCard({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4E6B8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// IMAGE + TITLE OVERLAY
          ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  height: 300,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// Gradient overlay
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.6),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                /// Title on image
                Positioned(
                  left: 16,
                  bottom: 16,
                  right: 16,
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          /// Subtitle
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),

          const Spacer(),

          /// Button
          AppButton(
            label: 'View Details',
            width: 120,
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            type: AppButtonType.primary,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
