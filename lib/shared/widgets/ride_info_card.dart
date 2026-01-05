import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class RideInfoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;
  final String? svgPath;

  const RideInfoCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.svgPath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.borderGray.withValues(alpha: 0.5),
              width: 1, 
            ),
          ),
          child: Row(
            children: [
              if (svgPath != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: 50,
                    height: 50,
                    child: Icon(
                      Icons.directions_bike,
                      size: 32,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
