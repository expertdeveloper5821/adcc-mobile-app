import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/app_button.dart';
import 'sections/profile_header_section.dart';
import 'sections/profile_menu_section.dart';
import 'sections/route_details_integration_section.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.softCream,
      child: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: 100, // Space for bottom navigation bar
          ),
          children: [
            // Header with Profile title (now scrollable)
            ProfileHeaderSection(
              name: 'Andrew',
              location: 'Abu Dhabi City',
              skillLevel: 'Intermediate rider',
              profileImagePath: 'assets/images/profile.png',
              stats: {
                'km': '2,340',
                'rides': '126',
                'events': '14',
              },
            ),
            // Menu Options (positioned to overlap header bottom by 20-30px)
            Transform.translate(
              offset: const Offset(0, -30), // Move up 30px to overlap only bottom of header
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ProfileMenuSection(
                  menuItems: [
                    {
                      'icon': Icons.directions_bike,
                      'label': 'My cycling details',
                    },
                    {
                      'icon': Icons.history,
                      'label': 'Event history & results',
                    },
                    {
                      'icon': Icons.workspace_premium,
                      'label': 'Badges & achievements',
                    },
                    {
                      'icon': Icons.card_giftcard,
                      'label': 'Rewards and points',
                    },
                    {
                      'icon': Icons.settings,
                      'label': 'Settings & preferences',
                    },
                  ],
                  onItemTap: (index, label) {
                    // Handle menu item tap
                    debugPrint('Tapped: $label');
                  },
                ),
              ),
            ),
            // Content below header with horizontal padding
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  // Route Details Integration
                  RouteDetailsIntegrationSection(
                    serviceName: 'Garmin',
                    onConnect: () {
                      // Handle connect action
                      debugPrint('Connect Garmin tapped');
                    },
                  ),
                  const SizedBox(height: 24),
                  // Logout Button
                  AppButton(
                    label: 'Logout',
                    onPressed: () {
                      // Handle logout
                      debugPrint('Logout tapped');
                    },
                    type: AppButtonType.danger,
                    backgroundColor: AppColors.deepRed,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

