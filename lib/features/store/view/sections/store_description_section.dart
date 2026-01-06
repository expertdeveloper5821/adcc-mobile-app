import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class StoreDescriptionSection extends StatelessWidget {
  final String description;

  const StoreDescriptionSection({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Description',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style:  TextStyle(
              fontSize: 14,
              color: AppColors.textDark.withValues(alpha: 0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

