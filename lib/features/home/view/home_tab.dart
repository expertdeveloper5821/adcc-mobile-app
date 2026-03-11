import 'package:adcc/features/home/view/horizontal_rideList.dart';
import 'package:adcc/features/home/view/join_community_card.dart';
import 'package:adcc/features/home/view/near_by_track.dart';
import 'package:adcc/features/home/view/quick_actions_section.dart';
import 'package:adcc/features/home/view/community_store_section.dart';
import 'package:adcc/features/home/view/community_updates_section.dart';
import 'package:adcc/features/home/view/promo_carousel.dart';
import 'package:adcc/features/home/view/random_card.dart';
import 'package:adcc/features/home/view/recently_posted_section.dart.dart';
import 'package:adcc/features/home/view/ride_info_section.dart';
import 'package:adcc/features/home/view/upcoming_tracks_list.dart';
import 'package:adcc/features/home/view/weather_card.dart';
import 'package:adcc/features/home/view/weather_screen.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'section/profile_header.dart';

class HomeTab extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const HomeTab({super.key, this.onTabChange});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SafeArea(
      child: Column(
        children: [
          ProfileHeader(
            name: l10n.home_profileName,
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
                SizedBox(height: 34),

                SizedBox(child: PromoCarousel()),

                SizedBox(height: 30),

                WeatherScreen(),
                     SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: QuickActionsSection(onTabChange: onTabChange),
                ),
                const SizedBox(height:30 ),

const Padding(
  padding: EdgeInsets.symmetric(horizontal: 16),
  child: Text(
    "Featured Events",
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
  ),
),

                 const SizedBox(height: 24),
               const FeaturedEventCard(
  image: "assets/images/cycling_1.png",
  title: "Bike Abu Dhabi Gran Fondo 2025",
  date: "21 Dec 2026",
  distance: "150 Km",
),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: HorizontalRideList(),
                ),

                const SizedBox(height: 50),
                // CommunityStoreSection(),

               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 16),
                 child: SectionHeader(title: "Upcoming Events"),
               ),
               const SizedBox(height: 22),
                UpcomingTracksList(),
                const SizedBox(height: 50),

NearbyTracksSection(),
const SizedBox(height: 52),
RecentlyPost(),
                const SizedBox(height: 50),
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
