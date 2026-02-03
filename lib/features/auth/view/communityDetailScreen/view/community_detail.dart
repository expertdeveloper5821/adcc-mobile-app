import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/modals/info_tile.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:adcc/shared/widgets/info_grid_section.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';
import '../section/community_header_section.dart';
import '../section/community_title_section.dart';
import '../section/comunity_description_section.dart';
import '../section/community_facilities_section.dart';
import '../section/community_action_button.dart';

class CommunityDetailScreen extends StatelessWidget {
  final CommunityModel community;

  const CommunityDetailScreen({
    super.key,
    required this.community,
  });

  String _getImagePath() {
    if (community.imageUrl != null && community.imageUrl!.isNotEmpty) {
      return community.imageUrl!;
    }
    return 'assets/images/cycling_1.png';
  }

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
              imagePath: _getImagePath(),
              onBack: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              },
            ),

            const SizedBox(height: 16),

            // Community Title with Share
            EventTitleSection(
              title: community.title,
              onShare: () {
                // Handle share
                debugPrint('Share community: ${community.id}');
              },
            ),

            const SizedBox(height: 16),

            // Community Description
            EventDescriptionSection(
              description: community.description.isNotEmpty
                  ? community.description
                  : 'No description available for this community.',
            ),

            const SizedBox(height: 24),
            InfoGridSection(
              items: [
                InfoTileData(
                  icon: Icons.group,
                  label: 'Members',
                  value: '${community.membersCount ?? 0}',
                ),
                InfoTileData(
                  icon: Icons.event,
                  label: 'Events',
                  value: '${community.eventsCount ?? 0}',
                ),
                InfoTileData(
                  icon: Icons.category,
                  label: 'Type',
                  value:
                      community.type.isNotEmpty ? community.type : 'Community',
                ),
                InfoTileData(
                  icon: Icons.label,
                  label: 'Category',
                  value: community.category.isNotEmpty
                      ? community.category.first
                      : 'General',
                ),
              ],
            ),

            if (community.category.length > 1) ...[
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: InfoGridSection(
                  items: community.category
                      .skip(1)
                      .map(
                        (cat) => InfoTileData(
                          icon: Icons.tag,
                          label: 'Category',
                          value: cat,
                        ),
                      )
                      .toList(),
                ),
              ),
            ],

            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      label: community.isJoined == true
                          ? 'LEAVE COMMUNITY'
                          : 'JOIN COMMUNITY',
                      onPressed: () {
                        // Handle join/leave community
                        debugPrint(
                            '${community.isJoined == true ? 'Leave' : 'Join'} community: ${community.id}');
                      },
                    ),
                  ),

                  const SizedBox(width: 16),

                  /// ADD MEMBER BUTTON
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
                title: 'Community Preview',
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
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: _getImagePath().startsWith('http')
                        ? Image.network(
                            _getImagePath(),
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Image.asset(
                                'assets/images/cycling_1.png',
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            _getImagePath(),
                            width: double.infinity,
                            height: 220,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Image.asset(
                                'assets/images/cycling_1.png',
                                width: double.infinity,
                                height: 220,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                  ),
                ),
                InfoGridSection(
                  items: [
                    InfoTileData(
                      label: 'Members',
                      value: '${community.membersCount ?? 0}',
                    ),
                    InfoTileData(
                      label: 'Events',
                      value: '${community.eventsCount ?? 0}',
                    ),
                    InfoTileData(
                      label: 'Type',
                      value: community.type.isNotEmpty
                          ? community.type
                          : 'Community',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: AppButton(
                    label: 'Explore Community',
                    suffixIcon: Icons.arrow_forward_ios,
                    onPressed: () {
                      // Handle explore community
                    },
                  ),
                ),
              ],
            ),
            // Facilities
            EventFacilitiesSection(facilities: facilities),

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
