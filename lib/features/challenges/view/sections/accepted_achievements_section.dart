import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AcceptedAchievementsSection extends StatelessWidget {
  final String challengeTitle;

  const AcceptedAchievementsSection({
    super.key,
    required this.challengeTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Achievements Unlocked',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.charcoal,
          ),
        ),
        const SizedBox(height: 12),
        _AchievementCard(
          icon: Icons.emoji_events_outlined,
            title: 'Distance Champion Badge',
          subtitle: 'Earned today',
        ),
        const SizedBox(height: 12),
        _AchievementCard(
          icon: Icons.trending_up_outlined,
          title: '+100 Reward Points',
          subtitle: 'Added to your account',
        ),
      ],
    );
  }
}

class _AchievementCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _AchievementCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Golden yellow square icon container
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.goldenOchre,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.charcoal,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.charcoal.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
