import 'package:adcc/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CommunityUpdateCard extends StatelessWidget {
  final String profileImage;
  final String name;
  final String locationTime;
  final String postImage;
  final int likes;
  final String caption;

  const CommunityUpdateCard({
    super.key,
    required this.profileImage,
    required this.name,
    required this.locationTime,
    required this.postImage,
    required this.likes,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      width: 320,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.goldenOchre.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(profileImage),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      locationTime,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.more_horiz),
            ],
          ),

          const SizedBox(height: 12),

          // Post Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              postImage,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 12),

          // Actions
          Row(
            children: [
              ClipRRect(
                child: Image.asset(
                  "assets/icons/heart_icon.png",
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                child: Image.asset(
                  "assets/icons/comment_icon.png",
                  height: 25,
                  width: 25,
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                child: Image.asset(
                  "assets/icons/share_icon.png",
                  height: 25,
                  width: 25,
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          // Likes
          Text(
            '$likes likes',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 4),

          // Caption
          RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colors.onSurface,
              ),
              children: [
                TextSpan(
                  text: '$name ',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
