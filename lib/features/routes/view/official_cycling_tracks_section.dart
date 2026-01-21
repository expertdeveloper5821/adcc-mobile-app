import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/section_header.dart';
import '../../route_details/view/route_details_screen.dart';

class OfficialCyclingTracksSection extends StatefulWidget {
  const OfficialCyclingTracksSection({super.key});

  @override
  State<OfficialCyclingTracksSection> createState() =>
      _OfficialCyclingTracksSectionState();
}

class _OfficialCyclingTracksSectionState
    extends State<OfficialCyclingTracksSection> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> tracks = [
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Road Bike',
      'title': 'Mountain Warm-Up Ride',
      'date': 'Friday',
      'time': '6:15 AM',
      'riders': '28 Riders',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Open for all',
      'title': 'Night Community Ride',
      'date': 'Tomorrow',
      'time': '8:45 PM',
      'riders': '65 Riders',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Road Bike',
      'title': 'Mountain Warm-Up Ride',
      'date': 'Friday',
      'time': '6:15 AM',
      'riders': '28 Riders',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Open for all',
      'title': 'Night Community Ride',
      'date': 'Tomorrow',
      'time': '8:45 PM',
      'riders': '65 Riders',
    },
  ];

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 300,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with navigation buttons
        Row(
          children: [
            Expanded(
              child: SectionHeader(
                title: 'Official Cycling Tracks',
                onViewAll: () {},
                showViewAll: false,
              ),
            ),
            // Navigation buttons
            Row(
              children: [
                GestureDetector(
                  onTap: _scrollLeft,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.warmSand,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: _scrollRight,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.warmSand,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Scrollable 2-column grid
        SizedBox(
          height: 360,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: (tracks.length / 2).ceil(),
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = firstIndex + 1;
              return Row(
                children: [
                  _buildTrackCard(
                    imagePath: tracks[firstIndex]['image'],
                    tag: tracks[firstIndex]['tag'],
                    title: tracks[firstIndex]['title'],
                    date: tracks[firstIndex]['date'],
                    time: tracks[firstIndex]['time'],
                    riders: tracks[firstIndex]['riders'],
                  ),
                  if (secondIndex < tracks.length) ...[
                    const SizedBox(width: 12),
                    _buildTrackCard(
                      imagePath: tracks[secondIndex]['image'],
                      tag: tracks[secondIndex]['tag'],
                      title: tracks[secondIndex]['title'],
                      date: tracks[secondIndex]['date'],
                      time: tracks[secondIndex]['time'],
                      riders: tracks[secondIndex]['riders'],
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTrackCard({
    required String imagePath,
    required String tag,
    required String title,
    required String date,
    required String time,
    required String riders,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 180,
        height: 340,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardLightBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with tag
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: double.infinity,
                        height: 180,
                        color: AppColors.softCream,
                      );
                    },
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Content - Expanded to push button to bottom
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Date, time and riders
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  date,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.charcoal,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  time,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppColors.charcoal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              riders,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.charcoal,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // View Route button - width according to text, aligned consistently
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RouteDetailsScreen(
                              routeData: {
                                'image': imagePath,
                                'title': title,
                                'date': date,
                                'time': time,
                                'riders': riders,
                                'tag': tag,
                              },
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.deepRed,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'View Track',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

