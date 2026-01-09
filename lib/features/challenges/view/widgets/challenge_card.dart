import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ChallengeCard extends StatelessWidget {
  final String imagePath;
  final String difficulty;
  final String title;
  final String description;
  final int progress;
  final int target;
  final String unit;
  final int daysLeft;
  final int participants;
  final VoidCallback? onTap;

  const ChallengeCard({
    super.key,
    required this.imagePath,
    required this.difficulty,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.unit,
    required this.daysLeft,
    required this.participants,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final progressPercentage = (progress / target).clamp(0.0, 1.0);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with difficulty tag and title overlay
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 200,
                        color: AppColors.softCream,
                      );
                    },
                  ),
                  // Gradient overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Difficulty tag
                  Positioned(
                    top: 12,
                    left: 12,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(43234732),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(26, 28, 32, 0.15),
                            borderRadius: BorderRadius.circular(43234732),
                          ),
                          child: Text(
                            difficulty,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Title overlay
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content section
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.charcoal,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Progress section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Progress label and numbers
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Text(
                            'Progress',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColors.textDark.withValues(alpha: 0.6),
                            ),
                          ),
                          Text(
                            '$progress / $target $unit',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppColors.charcoal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progressPercentage,
                          minHeight: 8,
                          backgroundColor: AppColors.softCream,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.goldenOchre,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Days left and participants
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Container with days left and participants grouped together
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                size: 16,
                                color: AppColors.textDark.withValues(alpha: 0.6),

                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$daysLeft days left',
                                style: TextStyle(
                                color: AppColors.textDark.withValues(alpha: 0.6),
                                fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 16,
                                color: AppColors.textDark.withValues(alpha: 0.6),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '$participants',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.textDark.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      // Arrow icon with space from the grouped container
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: AppColors.textDark.withValues(alpha: 0.6),
                      ),
                    ],
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

