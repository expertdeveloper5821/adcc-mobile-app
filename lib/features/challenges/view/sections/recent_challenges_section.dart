import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/recent_challenge_card.dart';

class RecentChallengesSection extends StatelessWidget {
  const RecentChallengesSection({super.key});

  // Sample recent challenge data - replace with actual data from API
  final List<Map<String, dynamic>> recentChallenges = const [
    {
      'title': 'Evening Ride of Corniche',
      'distance': '18.2 km',
      'duration': '52 min',
      'timeAgo': 'Yesterday',
    },
    {
      'title': 'SheRides Community Event',
      'distance': '22.0 km',
      'duration': '1h 15min',
      'timeAgo': '2 days ago',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Challenges',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 16),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: recentChallenges.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final challenge = recentChallenges[index];
            return RecentChallengeCard(
              title: challenge['title'] as String,
              distance: challenge['distance'] as String,
              duration: challenge['duration'] as String,
              timeAgo: challenge['timeAgo'] as String,
              onTap: () {
                // Navigate to challenge details
                debugPrint('Recent challenge tapped: ${challenge['title']}');
              },
            );
          },
        ),
      ],
    );
  }
}

