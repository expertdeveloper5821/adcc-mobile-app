import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';

class QuickActionItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback? onTap;

  const QuickActionItem({
    super.key,
    required this.title,
    required this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: AppColors.warmSand.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Image.asset(
                imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(height: 8),
         Text(
  title,
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.15, // 115%
    letterSpacing: 0.3275,
    color: Color(0xFF000000),
  ),
)
        ],
      ),
    );
  }
}
