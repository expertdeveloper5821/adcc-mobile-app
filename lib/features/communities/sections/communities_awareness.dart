import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class CommunitiesAwareness extends StatefulWidget {
  const CommunitiesAwareness({super.key});

  @override
  State<CommunitiesAwareness> createState() =>
      _CommunitiesAwarenessState();
}

class _CommunitiesAwarenessState
    extends State<CommunitiesAwareness> {
  final ScrollController _scrollController = ScrollController();

  final List<Map<String, dynamic>> tracks = [
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Awareness Rides Community',
      'sub-title': 'Health and social awareness through cycling initiatives.',
    },
     {
      'image': 'assets/images/cycling_1.png',
      'title': 'Awareness Rides Community',
      'sub-title': 'Health and social awareness through cycling initiatives.',
    },
   {
      'image': 'assets/images/cycling_1.png',
      'title': 'Awareness Rides Community',
      'sub-title': 'Health and social awareness through cycling initiatives.',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'title': 'Awareness Rides Community',
      'sub-title': 'Health and social awareness through cycling initiatives.',
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
                    title: tracks[firstIndex]['title'],
                    subTitle: tracks[firstIndex]['sub-title'],
                  ),
                  if (secondIndex < tracks.length) ...[
                    const SizedBox(width: 12),
                    _buildTrackCard(
                      imagePath: tracks[secondIndex]['image'],
                      title: tracks[secondIndex]['title'],
                      subTitle: tracks[secondIndex]['sub-title'],
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
    required String title,
    required String subTitle,
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
                    height: 160,
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
                     
                       Text(
                        subTitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.textDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton(label: "Explore", onPressed: () {},
                     backgroundColor: AppColors.deepRed,
                     height:35,
                     width:90
                     )
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

