import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedDifficultySection extends StatelessWidget {
  final String? selectedDifficulty;
  final Function(String) onDifficultySelected;

  const AcceptedDifficultySection({
    super.key,
    required this.selectedDifficulty,
    required this.onDifficultySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'How was the difficulty?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _DifficultyButton(
                label: 'Too Easy',
                icon: Icons.sentiment_very_satisfied,
                isSelected: selectedDifficulty == 'too_easy',
                isFilled: selectedDifficulty == 'too_easy',
                onTap: () => onDifficultySelected('too_easy'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DifficultyButton(
                label: 'Just Right',
                icon: Icons.sentiment_neutral,
                isSelected: selectedDifficulty == 'just_right',
                isFilled: false,
                onTap: () => onDifficultySelected('just_right'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _DifficultyButton(
                label: 'Too Hard',
                icon: Icons.sentiment_very_dissatisfied,
                isSelected: selectedDifficulty == 'too_hard',
                isFilled: false,
                onTap: () => onDifficultySelected('too_hard'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _DifficultyButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final bool isFilled;
  final VoidCallback onTap;

  const _DifficultyButton({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.isFilled,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: isFilled
              ? AppColors.goldenOchre
              : isSelected
                  ? AppColors.dustyRose
                  : Colors.transparent,
          border: Border.all(
            color: isFilled
                ? AppColors.goldenOchre
                : isSelected
                    ? AppColors.goldenOchre
                    : AppColors.dustyRose,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isFilled ? Colors.white : AppColors.charcoal,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isFilled ? Colors.white : AppColors.charcoal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
