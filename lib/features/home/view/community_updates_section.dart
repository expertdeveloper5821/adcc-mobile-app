import 'package:adcc/shared/widgets/community_update_card.dart';
import 'package:flutter/material.dart';

class CommunityUpdatesSection extends StatelessWidget {
  const CommunityUpdatesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Community updates',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('View All ›'),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Feed
          SizedBox(
            height: 430,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                CommunityUpdateCard(
                  profileImage: 'assets/images/profile_sara.png',
                  name: 'Sara Al Ketbi',
                  locationTime: 'Dubai • 2h ago',
                  postImage: 'assets/images/ride.png',
                  likes: 24,
                  caption: '🚴‍♀️ Amazing ride today!...',
                ),
                SizedBox(width: 16),
                 CommunityUpdateCard(
                  profileImage: 'assets/images/profile_sara.png',
                  name: 'Sara Al Ketbi',
                  locationTime: 'Dubai • 2h ago',
                  postImage: 'assets/images/ride.png',
                  likes: 24,
                  caption: '🚴‍♀️ Amazing ride today!...',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
