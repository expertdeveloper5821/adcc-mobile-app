import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChallengeHeaderSection extends StatelessWidget {
  final String imagePath;

  const ChallengeHeaderSection({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      child: Image.asset(
        imagePath,
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 400,
            color: AppColors.softCream,
          );
        },
      ),
    );
  }
}

