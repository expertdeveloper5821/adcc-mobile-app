import 'package:adcc/features/route_details/view/sections/route_communities_section.dart';
import 'package:adcc/features/route_details/view/sections/route_events_section.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/route_header_section.dart';
import 'sections/route_title_section.dart';
import 'sections/route_description_section.dart';
import 'sections/route_details_grid_section.dart';
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
    'Distance': "${routeData['distance'] ?? '10'} km",

      'Elevation': routeData['elevation'] as String? ?? '+12m',
      'Type': routeData['type'] as String? ?? 'Loop Track',
    'Avg Time': routeData['avgtime'] as String? ?? '18-25 min',

      'Pace': routeData['pace'] as String? ?? 'Beginner / Casual',
    };

    final facilities = <Map<String, dynamic>>[
  {"icon": "assets/icons/water.png", "label": "Water"},
  {"icon": "assets/icons/toilets.png", "label": "Toilets"},
  {"icon": "assets/icons/parking.png", "label": "Parking"},
  {"icon": "assets/icons/light.png", "label": "Lights"},
    ];



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

           RouteTitleSection(
  title: routeData['title'] as String? ?? 'Hudayriyat Night Ride',
  status: routeData['status'] as String? ?? 'Open',
  onShare: () {},
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

    

         

            // Facilities
            RouteFacilitiesSection(facilities: facilities),

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
       
              // Route Views & Community Photos
            RoutePhotosSection(photoPaths: photos),

            const SizedBox(height: 24),

 RouteEventsSection(
  events: routeData['events'] as List<Map<String, dynamic>>? ?? [],
),

const SizedBox(height: 24),

// ✅ Communities Using This Track
RouteCommunitiesSection(
  communities: routeData['communities'] as List<Map<String, dynamic>>? ?? [],
),

const SizedBox(height: 24),
           RouteSafetySection(
  safetyMessage: routeData['safetyMessage'] as String? ??
      "• Ride early morning or late evening in summer\n"
      "• Carry sufficient water\n"
      "• Helmets mandatory\n"

),


            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
