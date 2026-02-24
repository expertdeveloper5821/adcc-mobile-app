import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:flutter/material.dart';

class CommunityCategory {
  final String title;
  final String imagePath;

  const CommunityCategory({
    required this.title,
    required this.imagePath,
  });
}

class CommunityCategoriesGrid extends StatelessWidget {
  final Function(String category)? onCategoryTap;

  /// Backend se types list aayegi
  final List<String> types;

  const CommunityCategoriesGrid({
    super.key,
    this.onCategoryTap,
    required this.types,
  });

  String _getImageForType(String type) {
    final t = type.toLowerCase();

    if (t.contains("family")) return 'assets/images/family-rides.png';
    if (t.contains("women") || t.contains("she")) return 'assets/images/she-rides.png';
    if (t.contains("youth")) return 'assets/images/youth.png';
    if (t.contains("race") || t.contains("performance")) return 'assets/images/racing.png';
    if (t.contains("weekend") || t.contains("social")) return 'assets/images/night-ride.png';
    if (t.contains("night")) return 'assets/images/night-ride.png';
    if (t.contains("mtb") || t.contains("trail")) return 'assets/images/mtb-ride.png';
    if (t.contains("training") || t.contains("clinic")) return 'assets/images/mtb-ride.png';

    
    return 'assets/images/mtb-ride.png';
  }

  @override
  Widget build(BuildContext context) {

    final categories = types.map((t) {
      return CommunityCategory(
        title: t,
        imagePath: _getImageForType(t),
      );
    }).toList();

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
