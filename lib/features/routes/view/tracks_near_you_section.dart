import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/section_header.dart';

class TracksNearYouSection extends StatelessWidget {
  const TracksNearYouSection({super.key});

  final List<Map<String, dynamic>> nearbyTracks = const [
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Easy Road',
      'title': 'Hudayriyat Night Ride',
      'location': 'Hudayriyat Island',
      'distance': '35km',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Moderate',
      'title': 'Al Dhafra Desert Ride',
      'location': 'Al Dhafra',
      'distance': '42km',
    },
    {
      'image': 'assets/images/cycling_1.png',
      'tag': 'Easy Road',
      'title': 'Yas Island Circuit',
      'location': 'Yas Island',
      'distance': '28km',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Tracks Near You',
          onViewAll: () {},
          showViewAll: false,
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: nearbyTracks.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final track = nearbyTracks[index];
              return _buildNearbyTrackCard(
                imagePath: track['image'] as String,
                tag: track['tag'] as String,
                title: track['title'] as String,
                location: track['location'] as String,
                distance: track['distance'] as String,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNearbyTrackCard({
    required String imagePath,
    required String tag,
    required String title,
    required String location,
    required String distance,
  }) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 350,
        height: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: 350,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 320,
                        height: 200,
                        color: AppColors.softCream,
                      );
                    },
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
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
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: AppColors.buttonGuest,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Title and Distance on same row
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textDark,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.route,
                                size: 16,
                                color: AppColors.textDark,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                distance,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.textDark,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Location below title
                      Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            size: 16,
                            color: AppColors.textDark,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

