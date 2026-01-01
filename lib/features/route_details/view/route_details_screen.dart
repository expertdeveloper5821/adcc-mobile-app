import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/route_header_section.dart';
import 'sections/route_title_section.dart';
import 'sections/route_description_section.dart';
import 'sections/route_details_grid_section.dart';
import 'sections/route_feature_tags_section.dart';
import 'sections/route_preview_section.dart';
import 'sections/route_facilities_section.dart';
import 'sections/route_safety_section.dart';
import 'sections/route_photos_section.dart';
import 'sections/route_action_buttons_section.dart';

class RouteDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> routeData;

  const RouteDetailsScreen({
    super.key,
    required this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    // Default route details
    final routeDetails = {
      'Distance': routeData['distance'] as String? ?? '10 km',
      'Elevation': routeData['elevation'] as String? ?? '+12m',
      'Type': routeData['type'] as String? ?? 'Loop Track',
      'Avg Time': routeData['avgTime'] as String? ?? '18-25 min',
      'Pace': routeData['pace'] as String? ?? 'Beginner / Casual',
    };

    final facilities = <Map<String, dynamic>>[
      {'icon': Icons.water_drop, 'label': 'Water'},
      {'icon': Icons.wc, 'label': 'Toilets'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.lightbulb, 'label': 'Lights'},
    ];

    final featureTags = routeData['tags'] as List<String>? ??
        ['Night ride friendly', 'Facilities available', 'Parking', 'Night ride friendly', 'Facilities available', 'Parking'];

    final photos = routeData['photos'] as List<String>? ??
        [
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
          'assets/images/cycling_1.png',
        ];

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with back button and image
            RouteHeaderSection(
              imagePath: routeData['image'] as String? ?? 'assets/images/cycling_1.png',
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Route Title with Share
            RouteTitleSection(
              title: routeData['title'] as String? ?? 'Hudayriyat Night Ride',
              onShare: () {
                // Handle share
              },
            ),

            const SizedBox(height: 16),

            // Route Description
            RouteDescriptionSection(
              description: routeData['description'] as String? ??
                  'Join us for an evening ride at Yas Marine Circuit. Perfect for Intermediate to advanced riders to enjoy the night air.',
            ),

            const SizedBox(height: 24),

            // Route Details Grid
            RouteDetailsGridSection(routeDetails: routeDetails),

            const SizedBox(height: 24),

            // Feature Tags
            RouteFeatureTagsSection(tags: featureTags),

            const SizedBox(height: 24),

            // Route Preview
            RoutePreviewSection(
              startLocation: routeData['startLocation'] != null
                  ? LatLng(
                      routeData['startLocation']['latitude'] as double,
                      routeData['startLocation']['longitude'] as double,
                    )
                  : null,
              endLocation: routeData['endLocation'] != null
                  ? LatLng(
                      routeData['endLocation']['latitude'] as double,
                      routeData['endLocation']['longitude'] as double,
                    )
                  : null,
              onStartRide: () {
                // Handle start ride
              },
            ),

            const SizedBox(height: 24),

            // Facilities
            RouteFacilitiesSection(facilities: facilities),

            const SizedBox(height: 24),

            // Safety Information
            RouteSafetySection(
              safetyMessage: routeData['safetyMessage'] as String? ??
                  'Well-lit path with dedicated cycling lanes. Follow traffic signals and yield to pedestrians.',
            ),

            const SizedBox(height: 24),

            // Route Views & Community Photos
            RoutePhotosSection(photoPaths: photos),

            const SizedBox(height: 24),

            // Action Buttons Section (scrollable with content)
            RouteActionButtonsSection(
              onOpenLinkMyRide: () {
                // Handle open in Link My Ride
              },
              onOpenMaps: () {
                // Handle open in Maps
              },
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
