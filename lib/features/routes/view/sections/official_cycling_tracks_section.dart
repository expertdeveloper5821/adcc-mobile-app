import 'package:adcc/features/routes/view/official_cycling_track_page.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/section_header.dart';
import '../../../route_details/view/route_details_screen.dart';

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

      SectionHeader(
  title: 'Official Cycling Tracks',
  showViewAll: true,
  onViewAll: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const OfficialCyclingTracksPage(),
      ),
    );
  },
),


        const SizedBox(height:20),


        SizedBox(
          height: 303,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: (tracks.length / 2).ceil(),
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = firstIndex + 1;

              return Row(
                children: [
                  _buildTrackCard(
                    context: context,
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
                      context: context,
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
    required BuildContext context,
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
        width: 169,
        height: 303,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
                    width:157,
                    height: 161,
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

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
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

                  Align(
  alignment: Alignment.centerLeft,
  child: SizedBox(
    width: 93,
    height: 30,
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
          horizontal: 12,
          vertical: 7,
        ),

  
        side: const BorderSide(
          color: Colors.white,
          width: 1.24,
        ),


        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.12),
        ),


        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        elevation: 0, 
      ),
      child: const Text(
        'View Track',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          height: 1, // ✅ text center
        ),
      ),
    ),
  ),
)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
