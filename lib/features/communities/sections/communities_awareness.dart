import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class CommunitiesAwareness extends StatefulWidget {
  final List<CommunityModel> communities;

  const CommunitiesAwareness({
    super.key,
    required this.communities,
  });

  @override
  State<CommunitiesAwareness> createState() => _CommunitiesAwarenessState();
}

class _CommunitiesAwarenessState extends State<CommunitiesAwareness> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.communities.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 300,
          child: ListView.separated(
            controller: _scrollController,
            scrollDirection: Axis.horizontal,
            itemCount: (widget.communities.length / 2).ceil(),
            separatorBuilder: (_, __) => const SizedBox(width: 18),
            itemBuilder: (context, index) {
              final firstIndex = index * 2;
              final secondIndex = firstIndex + 1;
              return Row(
                children: [
                  _buildTrackCard(
                    community: widget.communities[firstIndex],
                  ),
                  if (secondIndex < widget.communities.length) ...[
                    const SizedBox(width: 12),
                    _buildTrackCard(
                      community: widget.communities[secondIndex],
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
    required CommunityModel community,
  }) {
    return GestureDetector(
      onTap: () {
        // Handle community tap
        debugPrint('Tapped on ${community.title}');
      },
      child: Container(
        width: 180,
        height: 300,
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
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  AdaptiveImage(
                    imagePath:
                        community.imageUrl ?? 'assets/images/cycling_1.png',
                    width: double.infinity,
                    height: 160,
                    fit: BoxFit.cover,
                    placeholderColor: AppColors.softCream,
                  ),
                  // if (community.category.isNotEmpty)
                  // Positioned(
                  //   top: 12,
                  //   left: 12,
                  //   child: Container(
                  //     padding: const EdgeInsets.symmetric(
                  //       horizontal: 12,
                  //       vertical: 6,
                  //     ),
                  //     decoration: BoxDecoration(
                  //       color: Colors.black.withValues(alpha: 0.45),
                  //       borderRadius: BorderRadius.circular(6),
                  //     ),
                  //     child: Text(
                  //       community.category.first,
                  //       style: const TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 10,
                  //         fontWeight: FontWeight.w600,
                  //       ),
                  //     ),
                  //   ),
                  // ),
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
                        community.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      Text(
                        community.description,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textDark,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: AppButton(
                      label: "Explore",
                      onPressed: () {
                        // Handle explore community
                        debugPrint('Explore ${community.title}');
                      },
                      backgroundColor: AppColors.deepRed,
                      height: 30,
                      width: 90,
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
