import 'package:adcc/shared/widgets/track_header.dart';
import 'package:flutter/material.dart';
import '../../../shared/widgets/banner_with_search.dart';
import '../../../shared/widgets/warning_message.dart';
import '../../../shared/widgets/category_selector.dart';
import 'sections/official_cycling_tracks_section.dart';
import 'sections/tracks_near_you_section.dart';
import 'sections/explore_by_city_section.dart';


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
    'Open',
    'Limited',
    'Closed',
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

              TrackHeader(
  imagePath: 'assets/images/cycling_1.png',
  title: 'Find a Track',
  wantSearchBar: true,
  searchValue: searchQuery,
  onChangeHandler: (value) {
    setState(() => searchQuery = value);
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

                  // Tracks Near You Section
                const TracksNearYouSection(),
              

                const SizedBox(height: 32),
                  // Official Cycling Tracks Section
                const OfficialCyclingTracksSection(),
               

                const SizedBox(height: 32),

                // Explore by City Section
                const ExploreByCitySection(),

                const SizedBox(height: 32),

        
                  ],
                ),
              ),
            ],
          ),
        
        ],
      ),
    );
  }
}

