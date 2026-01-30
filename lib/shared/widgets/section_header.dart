import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAll;
  final bool showViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.showViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.charcoal,
            ),
          ),
        ),
        if (showViewAll)
          InkWell(
            onTap: onViewAll,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8), // spacing between text & icon
                Image.asset(
                  "assets/icons/right_arrow.png",
                  height: 8,
                  width: 8,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
