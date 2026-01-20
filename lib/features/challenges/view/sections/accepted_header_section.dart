import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedHeaderSection extends StatelessWidget {
  final String challengeTitle;

  const AcceptedHeaderSection({
    super.key,
    required this.challengeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Trophy icon with gradient background
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(206, 105, 33, 0.25),
                Color.fromRGBO(239, 119, 34, 0.25),
              ],
            ),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/svg/winner_trophy.svg',
              width: 60,
              height: 60,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Title
        const Text(
          'Challenge Complete!',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
          ),
        ),

        const SizedBox(height: 8),

        // Subtitle
        Text(
          'How was your experience?',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.charcoal.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
