import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:flutter/material.dart';

/// Model for event category (title = displayed translated, filterKey = for callback/filter)
class EventCategory {
  final String title;
  final String imagePath;
  final String filterKey;

  const EventCategory({
    required this.title,
    required this.imagePath,
    required this.filterKey,
  });
}

/// Grid widget displaying event categories
class EventCategoriesGrid extends StatelessWidget {
  final Function(String category)? onCategoryTap;

  const EventCategoriesGrid({
    super.key,
    this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final categories = [
      EventCategory(title: l10n.eventCategoryRaces, imagePath: 'assets/icons/ra.png', filterKey: 'Races'),
      EventCategory(title: l10n.eventCategoryCommunityRides, imagePath: 'assets/icons/cf.png', filterKey: 'Community Rides'),
      EventCategory(title: l10n.eventCategoryTrainingClinics, imagePath: 'assets/icons/tc.png', filterKey: 'Training & Clinics'),
      EventCategory(title: l10n.eventCategoryAwarenessRides, imagePath: 'assets/icons/ra.png', filterKey: 'Awareness Rides'),
      EventCategory(title: l10n.eventCategoryFamilyKids, imagePath: 'assets/icons/cf.png', filterKey: 'Family & Kids'),
      EventCategory(title: l10n.eventCategoryCorporate, imagePath: 'assets/icons/tc.png', filterKey: 'Corporate'),
    ];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
        return _CategoryCard(
          category: category,
          onTap: () {
            onCategoryTap?.call(category.filterKey);
          },
        );
      },
    );
  }
}

/// Individual category card widget
class _CategoryCard extends StatelessWidget {
  final EventCategory category;
  final VoidCallback? onTap;

  const _CategoryCard({
    required this.category,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.cardLightBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title at the top
              Text(
                category.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textDark,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Image illustration - takes most of the space
              Expanded(
                child: Center(
                  child: AdaptiveImage(
                    imagePath: category.imagePath,
                    fit: BoxFit.contain,
                    placeholderColor: AppColors.softCream,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
