import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class JoinCommunityCard extends StatelessWidget {
  final VoidCallback onJoinTap;

  const JoinCommunityCard({super.key, required this.onJoinTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background
            Container(
              height: 160,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFCF9F0C),
        Color(0xCCCF9F0C), // 80% opacity
      ],
    ),
  ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Text(
  'Want to join rides or be\npart of the community?',
  style: theme.textTheme.titleMedium?.copyWith(
    fontFamily: 'Outfit',
    color: Colors.white,
    fontWeight: FontWeight.w600,
    fontSize: 22,
    height: 1.15,
    letterSpacing: 0,
  ),
),
                  const SizedBox(height: 20),
                  AppButton(
  label: 'Join ADCC',
  width: 120,
  height: 35,
  borderRadius: 50,
  textStyle: const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 16,
    fontWeight: FontWeight.w500,
    height: 1.25,
    letterSpacing: 0,
    color: Colors.white,
  ),
  onPressed: () {},
),
                ],
              ),
            ),

            // Decorative red curve
            Positioned(
              right: 20,
              top: 100,
              // bottom: 0,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.deepRed, width: 10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
