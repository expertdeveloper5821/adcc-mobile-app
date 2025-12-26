import 'package:adcc/features/home/view/quick_action_item.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  const QuickActionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: const [
            QuickActionItem(
              title: 'Store',
              imagePath: 'assets/images/store.png',
            ),
            QuickActionItem(
              title: 'Routes',
              imagePath: 'assets/images/routes.png',
            ),
            QuickActionItem(
              title: 'Challenges',
              imagePath: 'assets/images/challenges.png',
            ),
            QuickActionItem(
              title: 'Events',
              imagePath: 'assets/images/events.png',
            ),
            QuickActionItem(
              title: 'Community',
              imagePath: 'assets/images/community.png',
            ),
            QuickActionItem(
              title: 'Bike Experience',
              imagePath: 'assets/images/bike_experience.png',
            ),
          ],
        ),
      ],
    );
  }
}
