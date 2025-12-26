import 'package:adcc/features/home/view/horizontal_rideList.dart';
import 'package:adcc/features/home/view/join_community_card.dart';
import 'package:adcc/features/home/view/quick_actions_section.dart';
import 'package:adcc/features/home/view/community_store_section.dart';
import 'package:adcc/features/home/view/community_updates_section.dart';
import 'package:adcc/features/home/view/promo_carousel.dart';
import 'package:adcc/features/home/view/ride_info_section.dart';
import 'package:adcc/features/home/view/upcoming_tracks_list.dart';
import 'package:adcc/features/home/view/weather_card.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/profile_header.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          ProfileHeader(
            name: l10n.home_profileName,
            location: l10n.home_profileLocation,
            profileImagePath: 'assets/images/profile.png',
            onNotificationTap: () {
              debugPrint('Notification tapped');
            },
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 24),
              children: [
                SizedBox(height: 16),

                SizedBox(child: PromoCarousel()),

                SizedBox(height: 16),

                WeatherCard(
                  city: l10n.cityAbuDhabi,
                  time: '12:22 PM',
                  temperature: 20,
                  highTemp: 28,
                  lowTemp: 21,
                  weatherIcon: 'assets/images/weather_cloud.png',
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: QuickActionsSection(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: HorizontalRideList(),
                ),

                const SizedBox(height: 24),
                CommunityStoreSection(),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Upcoming Tracks',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Row(
                          children: [
                            Text('View All'),
                            SizedBox(width: 4),
                            Icon(Icons.chevron_right, size: 18),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                UpcomingTracksList(),

                const SizedBox(height: 24),
                CommunityUpdatesSection(),

                const SizedBox(height: 24),
                RideInfoSection(),
                
                const SizedBox(height: 24),
                JoinCommunityCard(
                  onJoinTap: () {
                    debugPrint('Join ADCC tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
