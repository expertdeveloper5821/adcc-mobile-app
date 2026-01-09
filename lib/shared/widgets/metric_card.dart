import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class MetricCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const MetricCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon and label in one line
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: AppColors.charcoal,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // Value below
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.charcoal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

