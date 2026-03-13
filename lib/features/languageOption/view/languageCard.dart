import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  final String image;
  final String label;
  final VoidCallback onTap;
  final bool isSelected;

  const LanguageCard({
    super.key,
    required this.image,
    required this.label,
    required this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        height: 240,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.cardLightBackground : Colors.white,
          borderRadius: BorderRadius.circular(80),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              width: 80,
              height: 100,
            ),
            const SizedBox(height: 16),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
