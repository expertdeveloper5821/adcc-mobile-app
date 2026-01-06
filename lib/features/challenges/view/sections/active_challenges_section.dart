import 'package:flutter/material.dart';
import '../widgets/challenge_card.dart';

class ActiveChallengesSection extends StatelessWidget {
  const ActiveChallengesSection({super.key});

  // Sample challenge data - replace with actual data from API
  final List<Map<String, dynamic>> challenges = const [
    {
      'image': 'assets/images/cycling_1.png',
      'difficulty': 'Easy',
      'title': 'December Distance Champion',
      'description': 'Ride 500km this month to earn the champion badge',
      'progress': 324,
      'target': 500,
      'unit': 'km',
      'daysLeft': 12,
      'participants': 234,
    },
    {
      'image': 'assets/images/bike.png',
      'difficulty': 'Hard',
      'title': 'Climbing Warrior',
      'description': 'Gain 2,000m elevation this week',
      'progress': 1245,
      'target': 2000,
      'unit': 'm',
      'daysLeft': 3,
      'participants': 156,
    },
    {
      'image': 'assets/images/route_preview.png',
      'difficulty': 'Medium',
      'title': 'Early Bird Rider',
      'description': 'Complete 5 rides before 7 AM this week',
      'progress': 3,
      'target': 5,
      'unit': 'rides',
      'daysLeft': 4,
      'participants': 89,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: challenges.length,
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final challenge = challenges[index];
            return ChallengeCard(
              imagePath: challenge['image'] as String,
              difficulty: challenge['difficulty'] as String,
              title: challenge['title'] as String,
              description: challenge['description'] as String,
              progress: challenge['progress'] as int,
              target: challenge['target'] as int,
              unit: challenge['unit'] as String,
              daysLeft: challenge['daysLeft'] as int,
              participants: challenge['participants'] as int,
              onTap: () {
                // Navigate to challenge details
                debugPrint('Challenge tapped: ${challenge['title']}');
              },
            );
          },
        ),
      ],
    );
  }
}

