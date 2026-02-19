import 'package:flutter/material.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:adcc/shared/widgets/track_card.dart';
import 'package:adcc/features/route_details/view/route_details_screen.dart';

class TrackNearAllPage extends StatefulWidget {
  const TrackNearAllPage({super.key});

  @override
  State<TrackNearAllPage> createState() => _TrackNearAllPageState();
}

class _TrackNearAllPageState extends State<TrackNearAllPage> {
  int selectedFilterIndex = 0;

  final List<String> filters = const ['All', 'Open', 'Limited', 'Closed'];

  final List<Map<String, dynamic>> tracks = const [
    {
      'image': 'assets/images/track_1.png',
      'title': 'Al Hudayriyat Island Cycle Track',
      'city': 'Abu Dhabi',
      'distance': '35 km',
      'subtitle': 'Multi-surface social circuit • Lighting • Facilities',
      'tag': 'Beginner–Intermediate',
      'status': 'Open',
    },
    {
      'image': 'assets/images/track_1.png',
      'title': 'Al Wathba Circuit Track',
      'city': 'Abu Dhabi',
      'distance': '32 km',
      'subtitle': 'Flat loop • Street cycling • Rest areas',
      'tag': 'Beginner–Intermediate',
      'status': 'Open',
    },
    {
      'image': 'assets/images/track_1.png',
      'title': 'Corniche Beach Cycling Track',
      'city': 'Abu Dhabi',
      'distance': '15 km',
      'subtitle': 'Seafront route • Smooth surface • Family friendly',
      'tag': 'Beginner Friendly',
      'status': 'Open',
    },
    {
      'image': 'assets/images/track_1.png',
      'title': 'Al Wathba Cycle Track',
      'city': 'Abu Dhabi',
      'distance': '30 km',
      'subtitle': 'Lighting • Water stations • Restrooms',
      'tag': 'Beginner–Intermediate',
      'status': 'Open',
    },
    {
      'image': 'assets/images/track_1.png',
      'title': 'Reem Island Waterfront Track',
      'city': 'Abu Dhabi',
      'distance': '18 km',
      'subtitle': 'Waterfront route • City views • Facilities',
      'tag': 'Beginner Friendly',
      'status': 'Open',
    },
    {
      'image': 'assets/images/track_1.png',
      'title': 'Mubadala Cycling Loop',
      'city': 'Abu Dhabi',
      'distance': '20 km',
      'subtitle': 'Smooth loop • Wide lanes • Rest areas',
      'tag': 'Beginner–Intermediate',
      'status': 'Open',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E6),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          children: [
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: 'Track Near You',
              subtitle: 'Cycling tracks closest to your current location',
              onBackTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 16),

            CategorySelector(
              categories: filters,
              selectedIndex: selectedFilterIndex,
              onSelected: (index) {
                setState(() => selectedFilterIndex = index);
              },
            ),

            const SizedBox(height: 14),

            Text(
              '${tracks.length} tracks found',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            ...tracks.map((t) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TrackCard(
                  width: double.infinity,
                  height: 281,
                  imagePath: t['image'] ?? '',
                  title: t['title'] ?? '',
                  city: t['city'] ?? '',
                  distance: t['distance'] ?? '',
                  subtitle: t['subtitle'] ?? '',
                  difficulty: t['tag'] ?? '',
                  status: t['status'] ?? '',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RouteDetailsScreen(routeData: t),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
