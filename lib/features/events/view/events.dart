import 'package:adcc/features/events/view/special_ride_card.dart';
import 'package:adcc/l10n/app_localizations.dart';
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

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 24),
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

                // Example usage
                // Expanded(
                //   child: Center(
                //     child: Text(
                //       'Selected: ${categories[selectedCategoryIndex]}',
                //       style: const TextStyle(fontSize: 18),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
