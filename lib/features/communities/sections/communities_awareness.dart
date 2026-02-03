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

    return SizedBox(
      height: 380,
      child: ListView.separated(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: (widget.communities.length / 2).ceil(),
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final firstIndex = index * 2;
          final secondIndex = firstIndex + 1;
          return Row(
            children: [
              _buildCommunityCard(
                community: widget.communities[firstIndex],
              ),
              if (secondIndex < widget.communities.length) ...[
                const SizedBox(width: 16),
                _buildCommunityCard(
                  community: widget.communities[secondIndex],
                ),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _buildCommunityCard({
    required CommunityModel community,
  }) {
    // Get category name for tag (use first category or default)
    final categoryName =
        community.category.isNotEmpty ? community.category.first : 'Community';

    // Format members and events count
    final membersCount = community.membersCount ?? 0;
    final eventsCount = community.eventsCount ?? 0;
    final formattedMembers = _formatNumber(membersCount);
    final formattedEvents = _formatNumber(eventsCount);

    return GestureDetector(
      onTap: () {
        // Handle community tap
        debugPrint('Tapped on ${community.title}');
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.cardLightBackground,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image with category tag overlay
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  AdaptiveImage(
                    imagePath:
                        community.imageUrl ?? 'assets/images/cycling_1.png',
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.cover,
                    placeholderColor: AppColors.softCream,
                  ),
                  // Category tag overlay
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "racing",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Content section
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Text(
                            community.title,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 10),
                          // Statistics row
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Members count
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.people_outline,
                                      size: 16,
                                      color: AppColors.textDark
                                          .withValues(alpha: 0.7),
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        '$formattedMembers members',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textDark
                                              .withValues(alpha: 0.7),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              // Events count
                              Flexible(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.event_outlined,
                                      size: 16,
                                      color: AppColors.textDark
                                          .withValues(alpha: 0.7),
                                    ),
                                    const SizedBox(width: 4),
                                    Flexible(
                                      child: Text(
                                        '$formattedEvents events',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.textDark
                                              .withValues(alpha: 0.7),
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          // Description
                          Text(
                            community.description,
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textDark.withValues(alpha: 0.8),
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    // Explore button
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: AppButton(
                        label: "Explore",
                        onPressed: () {
                          // Handle explore community
                          debugPrint('Explore ${community.title}');
                        },
                        backgroundColor: AppColors.deepRed,
                        height: 34,
                        width: 100,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      final thousands = number / 1000;
      if (thousands % 1 == 0) {
        return '${thousands.toInt()}K';
      }
      return '${thousands.toStringAsFixed(1)}K';
    }
    return number.toString();
  }
}
