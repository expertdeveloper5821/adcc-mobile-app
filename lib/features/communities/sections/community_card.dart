import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  final String category;
  final String title;
  final String imagePath;
  final bool joined;
  final VoidCallback? onTap;

  const CommunityCard({
    super.key,
    required this.category,
    required this.title,
    required this.imagePath,
    this.joined = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 260,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top Chips
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _chip(category),
                if (joined) _joinedChip(),
              ],
            ),

            const SizedBox(height: 12),

            /// Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            /// Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                imagePath,
                height: 140,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _joinedChip() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.deepRed.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Text(
        'Joined',
        style: TextStyle(
          fontSize: 12,
          color: AppColors.deepRed,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
