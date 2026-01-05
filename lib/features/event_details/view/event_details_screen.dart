import 'package:adcc/features/event_details/view/sections/event_info.dart';
import 'package:adcc/modals/info_tile.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:adcc/shared/widgets/info_grid_section.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'sections/event_header_section.dart';
import 'sections/event_title_section.dart';
import 'sections/event_description_section.dart';
import 'sections/event_facilities_section.dart';
import 'sections/event_action_buttons_section.dart';

class EventDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> routeData;

  const EventDetailsScreen({
    super.key,
    required this.routeData,
  });

  @override
  Widget build(BuildContext context) {
    final facilities = <Map<String, dynamic>>[
      {'icon': Icons.water_drop, 'label': 'Water'},
      {'icon': Icons.wc, 'label': 'Toilets'},
      {'icon': Icons.local_parking, 'label': 'Parking'},
      {'icon': Icons.lightbulb, 'label': 'Lights'},
    ];

    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            // Header with back button and image
            EventHeaderSection(
              imagePath: routeData['imagePath'] as String? ??
                  'assets/images/cycling_1.png',
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Route Title with Share
            EventTitleSection(
              title: routeData['title'] as String? ?? 'Hudayriyat Night Ride',
              onShare: () {
                // Handle share
              },
            ),

            const SizedBox(height: 16),

            // Route Description
            EventDescriptionSection(
              description: routeData['description'] as String? ??
                  'Join us for an evening ride at Yas Marine Circuit. Perfect for Intermediate to advanced riders to enjoy the night air.',
            ),

            const SizedBox(height: 24),
            InfoGridSection(
              items: const [
                InfoTileData(
                  icon: Icons.access_time,
                  label: 'When',
                  value: 'Today · 8:30 PM',
                ),
                InfoTileData(
                  icon: Icons.location_on,
                  label: 'Location',
                  value: 'Yas Marina Circuit',
                ),
                InfoTileData(
                  icon: Icons.star,
                  label: 'Rating',
                  value: '4.8 / 5.0',
                ),
                InfoTileData(
                  icon: Icons.group,
                  label: 'Riders',
                  value: '42 Joined',
                ),
              ],
            ),

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: 'JOIN THIS RIDE',
                      onPressed: () {
                        // Handle join ride
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// ADD RIDER BUTTON
                  Container(
                    height: 56,
                    width: 56,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C1F23),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SectionHeader(
                title: 'Route Preview',
                showViewAll: false,
                onViewAll: () {},
              ),
            ),
            Column(
              children: [
                // IMAGE SECTION
                Container(
                  margin: const EdgeInsets.all(16),
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/route_preview.png',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                InfoGridSection(
                  items: const [
                    InfoTileData(
                      label: 'When',
                      value: '10 km loop',
                    ),
                    InfoTileData(
                      label: 'Location',
                      value: '10 km loop',
                    ),
                    InfoTileData(
                      label: 'Rating',
                      value: '10 km loop',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(
                    label: 'Preview Full Route',
                    suffixIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      // Handle join ride
                    },
                  ),
                ),
              ],
            ),
            // Facilities
            EventFacilitiesSection(facilities: facilities),

            const SizedBox(height: 24),
            EventInfo(),
            const SizedBox(height: 24),

            // Action Buttons Section (scrollable with content)
            EventActionButtonsSection(
              firstButtonTab: () {},
              secondButtonTab: () {},
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
