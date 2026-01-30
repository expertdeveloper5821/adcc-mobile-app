import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class CategorySelector extends StatelessWidget {
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 9,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.goldenOchre
                    : AppColors.textSecondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textDark,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
