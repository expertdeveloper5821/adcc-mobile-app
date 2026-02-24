import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class BannerHeadder extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final VoidCallback? onBackTap;

  const BannerHeadder({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 210, // screenshot ke close
        width: double.infinity,
        child: Stack(
          children: [
            // Background Image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: AppColors.softCream,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.image,
                      size: 34,
                      color: Colors.black45,
                    ),
                  );
                },
              ),
            ),

            // Gradient Overlay (bottom black)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withValues(alpha: 0.05),
                      Colors.black.withValues(alpha: 0.35),
                      Colors.black.withValues(alpha: 0.85),
                    ],
                  ),
                ),
              ),
            ),

            // Back Button (top-left)
            Positioned(
              left: 14,
              top: 14,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onBackTap ?? () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_rounded,
                      color: Color(0xFFB93A3A),
                      size: 22,
                    ),
                  ),
                ),
              ),
            ),

            // Text content (bottom-left)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
