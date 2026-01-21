import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/banner_with_search.dart';
import '../../../shared/widgets/warning_message.dart';
import '../../../shared/widgets/category_selector.dart';
import 'sections/official_cycling_tracks_section.dart';
import 'sections/tracks_near_you_section.dart';
import 'sections/explore_by_city_section.dart';
import 'sections/ride_by_style_section.dart';

class RoutesTab extends StatefulWidget {
  const RoutesTab({super.key});

  @override
  State<RoutesTab> createState() => _RoutesTabState();
}

class _RoutesTabState extends State<RoutesTab> {
  int selectedFilterIndex = 0;
  String searchQuery = '';

  final List<String> filterPills = [
    'All',
    'Beginner Friendly',
    'Women-Friendly',
    'Nearby',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  children: [
                const SizedBox(height: 16),

                // Banner with Search
                BannerWithSearch(
                  imagePath: 'assets/images/cycling_1.png',
                  title: 'Find a Track',
                  wantSearchBar: true,
                  searchValue: searchQuery,
                  onChangeHandler: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  placeholder: 'Search by track name, city, distance or terrain...',
                ),

                const SizedBox(height: 16),

                // Filter Pills
                CategorySelector(
                  categories: filterPills,
                  selectedIndex: selectedFilterIndex,
                  onSelected: (index) {
                    setState(() {
                      selectedFilterIndex = index;
                    });
                  },
                ),

                const SizedBox(height: 16),

                // Warning Message
                WarningMessage(
                  message: 'Strong winds expected of Al Dhafra today choose sheltered routes',
                  type: MessageType.warning,
                ),

                const SizedBox(height: 24),

                // Official Cycling Tracks Section
                const OfficialCyclingTracksSection(),

                const SizedBox(height: 32),

                // Tracks Near You Section
                const TracksNearYouSection(),

                const SizedBox(height: 32),

                // Explore by City Section
                const ExploreByCitySection(),

                const SizedBox(height: 32),

                // Ride by Style Section
                const RideByStyleSection(),

                const SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
          // Plus button fixed on the right
          Positioned(
            right: 16,
            bottom: MediaQuery.of(context).padding.bottom + 20, // Account for bottom nav (64 + padding 24 + safe area)
            child: GestureDetector(
              onTap: () {
                // Handle plus button tap
              },
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.lightOliveGreen,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 28,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

