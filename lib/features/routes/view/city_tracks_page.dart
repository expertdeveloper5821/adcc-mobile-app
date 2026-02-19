import 'package:adcc/features/route_details/view/route_details_screen.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:adcc/shared/widgets/track_card.dart';

class CityTracksPage extends StatefulWidget {
  final String cityName;

  const CityTracksPage({
    super.key,
    required this.cityName,
  });

  @override
  State<CityTracksPage> createState() => _CityTracksPageState();
}

class _CityTracksPageState extends State<CityTracksPage> {
  int selectedFilterIndex = 0;

  final List<String> filters = const ['All', 'Open', 'Limited', 'Closed'];

  late final List<_TrackItem> tracks;

  @override
  void initState() {
    super.initState();
    tracks = _demoTracks(widget.cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F1E6),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 20),
          children: [
            const SizedBox(height: 6),

            // Banner
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: 'Cycling Tracks in ${widget.cityName}',
              subtitle:
                  'Explore official and community cycling tracks across ${widget.cityName}',
              onBackTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 16),

            // Filter Pills
            CategorySelector(
              categories: filters,
              selectedIndex: selectedFilterIndex,
              onSelected: (index) {
                setState(() => selectedFilterIndex = index);
              },
            ),

            const SizedBox(height: 14),

            // Count
            Text(
              '${tracks.length} communities found',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.black54,
              ),
            ),

            const SizedBox(height: 12),

            // ✅ Track Cards (global TrackCard)
            ...tracks.map(
              (t) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: TrackCard(
                  width: double.infinity,
                  height: 281,
                  imagePath: t.imagePath,
                  title: t.title,
                  city: t.city,
                  distance: "${t.distanceKm} km",
                  subtitle: t.subtitle,
                  difficulty: t.difficulty,
                  status: t.status,

                  // ✅ Navigate to RouteDetailsScreen
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RouteDetailsScreen(
                          routeData: {
                            "image": t.imagePath,
                            "title": t.title,
                            "city": t.city,
                            "distance": "${t.distanceKm} km",
                            "subtitle": t.subtitle,
                            "tag": t.difficulty,
                            "status": t.status,
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}


List<_TrackItem> _demoTracks(String city) {
  if (city.toLowerCase().contains('dubai')) {
    return const [
      _TrackItem(
        title: 'Al Qudra Cycling Track',
        city: 'Dubai',
        distanceKm: 50,
        difficulty: 'Beginner Friendly',
        status: 'Open',
        subtitle: 'Desert loop • Smooth roads • Facilities',
        imagePath: 'assets/images/track_1.png',
      ),
      _TrackItem(
        title: 'Nad Al Sheba Cycle Park',
        city: 'Dubai',
        distanceKm: 12,
        difficulty: 'Beginner–Intermediate',
        status: 'Open',
        subtitle: 'Road cycling • Training loop • Lighting',
        imagePath: 'assets/images/track_1.png',
      ),
      _TrackItem(
        title: 'Al Barsha Cycling Track',
        city: 'Dubai',
        distanceKm: 10,
        difficulty: 'Beginner Friendly',
        status: 'Open',
        subtitle: 'City route • Smooth surface • Facilities',
        imagePath: 'assets/images/track_1.png',
      ),
      _TrackItem(
        title: 'Dubai Autodrome Cycling Track',
        city: 'Dubai',
        distanceKm: 5,
        difficulty: 'Beginner Friendly',
        status: 'Open',
        subtitle: 'Safe loop • Closed track • Lighting',
        imagePath: 'assets/images/track_1.png',
      ),
    ];
  }

  // Default fallback
  return [
    _TrackItem(
      title: '$city Cycling Track',
      city: city,
      distanceKm: 20,
      difficulty: 'Beginner Friendly',
      status: 'Open',
      subtitle: 'Lighting • Water stations • Restrooms',
      imagePath: 'assets/images/track_1.png',
    ),
    _TrackItem(
      title: '$city Waterfront Track',
      city: city,
      distanceKm: 15,
      difficulty: 'Beginner Friendly',
      status: 'Open',
      subtitle: 'Smooth route • Views • Facilities',
      imagePath: 'assets/images/track_1.png',
    ),
    _TrackItem(
      title: '$city Training Loop',
      city: city,
      distanceKm: 30,
      difficulty: 'Beginner–Intermediate',
      status: 'Open',
      subtitle: 'Wide lanes • Training friendly • Lighting',
      imagePath: 'assets/images/track_1.png',
    ),
  ];
}

class _TrackItem {
  final String title;
  final String city;
  final int distanceKm;
  final String difficulty;
  final String status;
  final String subtitle;
  final String imagePath;

  const _TrackItem({
    required this.title,
    required this.city,
    required this.distanceKm,
    required this.difficulty,
    required this.status,
    required this.subtitle,
    required this.imagePath,
  });
}
