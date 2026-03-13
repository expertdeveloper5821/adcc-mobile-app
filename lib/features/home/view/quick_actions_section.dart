import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/bike_experience/view/bike_experience_screen.dart';
import 'package:adcc/features/communities/view/community_screen.dart';
import 'package:adcc/features/home/view/quick_action_item.dart';
import 'package:adcc/features/store/view/Screen/store_screen.dart';
import 'package:adcc/features/challenges/view/challenges_screen.dart';
import 'package:adcc/features/routes/view/routes_screen_wrapper.dart';
import 'package:adcc/features/events/view/events_screen.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class QuickActionsSection extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const QuickActionsSection({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.quickActions,
          style: const TextStyle(
            fontFamily: 'Outfit',
            fontSize: 20,
            fontWeight: FontWeight.w400,
            height: 1, // 100% line height
            letterSpacing: 0,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 21),
        GridView.count(
          crossAxisCount: 3,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            QuickActionItem(
              title: l10n.store,
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
              title: l10n.tracks,
              imagePath: 'assets/icons/tracks.gif',
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
              title: l10n.challenges,
              imagePath: 'assets/icons/challenges.gif',
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
              title: l10n.events,
              imagePath: 'assets/icons/events_calender.gif',
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
              title: l10n.community,
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
              title: l10n.bikeExperience,
              imagePath: 'assets/icons/bike_experience.gif',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BikeExperienceScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
