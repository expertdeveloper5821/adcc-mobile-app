import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedThoughtsSection extends StatelessWidget {
  final TextEditingController controller;

  const AcceptedThoughtsSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Thoughts',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: AppColors.lightBeige,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: controller,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Share details about your experience.',
              hintStyle: TextStyle(
                color: AppColors.charcoal.withValues(alpha: 0.5),
                fontSize: 14,
              ),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.all(16),
            ),
            style: const TextStyle(
              color: AppColors.charcoal,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
