import 'package:adcc/features/communities/view/community_screen.dart';
import 'package:adcc/features/home/view/quick_action_item.dart';
import 'package:adcc/features/store/view/store_screen.dart';
import 'package:adcc/features/challenges/view/challenges_screen.dart';
import 'package:adcc/features/routes/view/routes_screen_wrapper.dart';
import 'package:adcc/features/events/view/events_screen.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const QuickActionsSection({super.key, this.onTabChange});

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
          children: [
            QuickActionItem(
              title: 'Store',
              imagePath: 'assets/images/store.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const StoreScreen(),
                  ),
                );
              },
            ),
            QuickActionItem(
              title: 'Routes',
              imagePath: 'assets/images/routes.png',
              onTap: () {
                // Switch to Routes tab (index 2) instead of pushing new screen
                if (onTabChange != null) {
                  onTabChange!(2);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RoutesScreenWrapper(),
                    ),
                  );
                }
              },
            ),
            QuickActionItem(
              title: 'Challenges',
              imagePath: 'assets/images/challenges.png',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ChallengesScreen(),
                  ),
                );
              },
            ),
            QuickActionItem(
              title: 'Events',
              imagePath: 'assets/images/events.png',
              onTap: () {
                // Switch to Events tab (index 1) instead of pushing new screen
                if (onTabChange != null) {
                  onTabChange!(1);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EventsScreen(),
                    ),
                  );
                }
              },
            ),
            QuickActionItem(
              title: 'Community',
              imagePath: 'assets/images/community.png',
               onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const CommunitiesScreen(),
                  ),
                );
              },
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
