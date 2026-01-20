import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedEnjoymentSection extends StatelessWidget {
  final List<String> selectedEnjoyments;
  final Function(String) onEnjoymentToggled;

  const AcceptedEnjoymentSection({
    super.key,
    required this.selectedEnjoyments,
    required this.onEnjoymentToggled,
  });

  @override
  Widget build(BuildContext context) {
    final enjoyments = [
      {
        'id': 'great_challenge',
        'label': 'Great Challenge',
        'image': 'assets/icons/challanges_emoji.png',
      },
      {
        'id': 'perfect_difficulty',
        'label': 'Perfect Difficulty',
        'image': 'assets/icons/lightning_emoji.png',
      },
      {
        'id': 'motivating',
        'label': 'Motivating',
        'image': 'assets/icons/muscle_emoji.png',
      },
      {
        'id': 'achievable_goals',
        'label': 'Achievable Goals',
        'image': 'assets/icons/shining_emoji.png',
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What did you enjoy?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 26),
        Padding(
          padding: const EdgeInsets.only(right: 40), // Add space on the right
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.6, // Adjusted for narrower cards
            ),
            itemCount: enjoyments.length,
            itemBuilder: (context, index) {
              final enjoyment = enjoyments[index];
              final isSelected =
                  selectedEnjoyments.contains(enjoyment['id'] as String);

              return _EnjoymentCard(
                label: enjoyment['label'] as String,
                imagePath: enjoyment['image'] as String,
                isSelected: isSelected,
                onTap: () => onEnjoymentToggled(enjoyment['id'] as String),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _EnjoymentCard extends StatelessWidget {
  final String label;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _EnjoymentCard({
    required this.label,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.goldenOchre : AppColors.dustyRose,
          border: Border.all(
            color: isSelected ? AppColors.goldenOchre : AppColors.dustyRose,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 30,
              height: 30,
              child: Image.asset(
                imagePath,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image,
                    size: 24,
                    color: AppColors.textSecondary,
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.charcoal,
              ),
              textAlign: TextAlign.left,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
