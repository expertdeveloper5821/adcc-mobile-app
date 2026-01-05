import 'package:adcc/features/events/view/special_ride_card.dart';
import 'package:adcc/features/events/view/upcoming_rides.dart';
import 'package:adcc/features/home/view/upcoming_tracks_list.dart';
import 'package:adcc/l10n/app_localizations.dart';
import 'package:adcc/modals/grid_item.dart';
import 'package:adcc/shared/widgets/asymmetric_Image_grid.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:adcc/shared/widgets/community_event_card.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';

class EventsTab extends StatefulWidget {
  const EventsTab({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _EventsTabState createState() => _EventsTabState();
}

class _EventsTabState extends State<EventsTab> {
  int selectedCategoryIndex = 0;

  final List<String> categories = [
    'All',
    'Community Rides',
    'Family & Kids',
    'Shop',
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final List<Map<String, String>> rides = [
      {
        "image": "assets/images/ride_events.png",
        "title": "UAE National Day Ride",
        "date": "Dec 2",
        "distance": "25 km",
        "riders": "25k riders",
      },
      {
        "image": "assets/images/ride_events.png",
        "title": "UAE National Day Ride",
        "date": "Dec 2",
        "distance": "25 km",
        "riders": "25k riders",
      },
    ];

    final items = [
      GridItem(
        title: 'Hudayriyat',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Yas',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Corniche',
        image: 'assets/images/ride_events.png',
      ),
      GridItem(
        title: 'Al Ain Climb',
        image: 'assets/images/ride_events.png',
      ),
    ];

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CommunityEventCard(
                    imagePath: 'assets/images/community_ride.png',
                    title: 'Events & Community Rides',
                    onTap: () {
                      debugPrint('Card tapped');
                    },
                  ),
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CategorySelector(
                    categories: categories,
                    selectedIndex: selectedCategoryIndex,
                    onSelected: (index) {
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SectionHeader(
                        title: 'Special Rides &\nCampaigns',
                        onViewAll: () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: rides.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final ride = rides[index];
                          return SpecialRideCard(
                            imagePath: ride['image']!,
                            title: ride['title']!,
                            date: ride['date']!,
                            distance: ride['distance']!,
                            riders: ride['riders']!,
                            onTap: () {},
                            onShare: () {},
                          );
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SectionHeader(
                        title: 'Upcoming Rides &\nActivities',
                        showViewAll: false,
                        onViewAll: () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const UpcomingRides(),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SectionHeader(
                        title: 'Upcoming Tracks',
                        onViewAll: () {},
                      ),
                    ),
                    const SizedBox(height: 16),
                    const UpcomingTracksList(),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SectionHeader(
                        title: 'Most Ride Tracks',
                        onViewAll: () {},
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AsymmetricImageGrid(
                        items: items,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
