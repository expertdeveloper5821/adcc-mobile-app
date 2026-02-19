import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:flutter/material.dart';

class CommunityListCard extends StatelessWidget {
  final CommunityModel community;
  final VoidCallback? onTap;

  const CommunityListCard({
    super.key,
    required this.community,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358,
      height: 286,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11.5872),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.dustyRose,
              borderRadius: BorderRadius.circular(11.5872),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ---------------- IMAGE ----------------
                SizedBox(
                  width: 358,
                  height: 178.6592,
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.4581),
                        child: Image.network(
                          community.imageUrl ?? '',
                          width: 358,
                          height: 178.6592,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) {
                            return Image.asset(
                              "assets/images/cycling_1.png",
                              width: 358,
                              height: 178.6592,
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),

                      /// Tag (top-left)
                      Positioned(
                        left: 12,
                        top: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.35),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                            community.category.isNotEmpty
                                ? community.category.first
                                : "Racing",
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ---------------- CONTENT ----------------
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 10, 14, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Title
                        Text(
                          community.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w900,
                            color: AppColors.charcoal,
                            height: 1.1,
                          ),
                        ),

                        const SizedBox(height: 4),

                        /// Subtitle
                        Text(
                          community.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w700,
                            height: 1.25,
                            color: AppColors.charcoal.withValues(alpha: 0.55),
                          ),
                        ),

                        const Spacer(),

                        /// Bottom Stats Row
                        Row(
                          children: [
                            Icon(
                              Icons.people_alt_outlined,
                              size: 15,
                              color:
                                  AppColors.charcoal.withValues(alpha: 0.70),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${community.membersCount ?? 0} members',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.charcoal.withValues(
                                  alpha: 0.70,
                                ),
                              ),
                            ),

                            const SizedBox(width: 14),

                            Icon(
                              Icons.calendar_month_outlined,
                              size: 15,
                              color:
                                  AppColors.charcoal.withValues(alpha: 0.70),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              '${community.eventsCount ?? 0} events',
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w800,
                                color: AppColors.charcoal.withValues(
                                  alpha: 0.70,
                                ),
                              ),
                            ),

                            const Spacer(),

                            /// Avatars + count
                            const _AvatarStack(countText: "+456"),
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
      ),
    );
  }
}

/// ----------------------------------------------------------------
/// Avatar Stack Widget
/// ----------------------------------------------------------------
class _AvatarStack extends StatelessWidget {
  final String countText;

  const _AvatarStack({
    required this.countText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 46,
          height: 22,
          child: Stack(
            children: const [
              _AvatarCircle(left: 0, imagePath: "assets/images/cycling_1.png"),
              _AvatarCircle(left: 14, imagePath: "assets/images/cycling_1.png"),
              _AvatarCircle(left: 28, imagePath: "assets/images/cycling_1.png"),
            ],
          ),
        ),
        const SizedBox(width: 6),
        Text(
          countText,
          style: TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w900,
            color: AppColors.charcoal.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

class _AvatarCircle extends StatelessWidget {
  final double left;
  final String imagePath;

  const _AvatarCircle({
    required this.left,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: Container(
        height: 22,
        width: 22,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.dustyRose, width: 2),
        ),
        child: ClipOval(
          child: Image.asset(
            imagePath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
