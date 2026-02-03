import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:flutter/material.dart';

/// Model for community category
class CommunityCategory {
  final String title;
  final String imagePath;

  const CommunityCategory({
    required this.title,
    required this.imagePath,
  });
}

/// Grid widget displaying community categories
class CommunityCategoriesGrid extends StatelessWidget {
  final Function(String category)? onCategoryTap;

  const CommunityCategoriesGrid({
    super.key,
    this.onCategoryTap,
  });

  // List of community categories matching the design
  static final List<CommunityCategory> categories = [
    const CommunityCategory(
      title: 'Family Rides',
      imagePath: 'assets/images/family-rides.png',
    ),
    const CommunityCategory(
      title: 'Women (SheRides)',
      imagePath: 'assets/images/she-rides.png',
    ),
    const CommunityCategory(
      title: 'Youth Cycling',
      imagePath: 'assets/images/youth.png',
    ),
    const CommunityCategory(
      title: 'Racing & Performance',
      imagePath: 'assets/images/racing.png',
    ),
    const CommunityCategory(
      title: 'Weekend Social',
      imagePath: 'assets/images/night-ride.png',
    ),
    const CommunityCategory(
      title: 'Night Riders',
      imagePath: 'assets/images/night-ride.png',
    ),
    const CommunityCategory(
      title: 'MTB / Trail',
      imagePath: 'assets/images/mtb-ride.png',
    ),
    const CommunityCategory(
      title: 'Training & Clinics',
      imagePath: 'assets/images/mtb-ride.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
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
            onCategoryTap?.call(category.title);
          },
        );
      },
    );
  }
}

/// Individual category card widget
class _CategoryCard extends StatelessWidget {
  final CommunityCategory category;
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
                  fontSize: 11,
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
