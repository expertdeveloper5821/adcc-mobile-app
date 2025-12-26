import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StoreItemCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String postedBy;
  final String price;

  const StoreItemCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.postedBy,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  imagePath,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              // Share button
              Positioned(
                top: 10,
                left: 10,
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.deepRed,
                  child: Image.asset(
                    "assets/images/share.png",
                    height: 15,
                    width: 15,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Title
          Text(
            title,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 2),

          // Posted by
          Text(
            'Posted by  $postedBy',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),

          const SizedBox(height: 6),

          // Price
          Text(
            price,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.deepRed,
            ),
          ),
        ],
      ),
    );
  }
}
