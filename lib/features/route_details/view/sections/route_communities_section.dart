import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class RouteCommunitiesSection extends StatelessWidget {
  final List<Map<String, dynamic>> communities;

  const RouteCommunitiesSection({
    super.key,
    required this.communities,
  });

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = communities.isNotEmpty
        ? communities
        : [
            {
              "image": "assets/images/cycling_1.png",
              "joined": true,
              "title": "Abu Dhabi Road Racers",
              "subtitle": "Weekly high-pace road rides & race training",
              "members": "2,800 members",
            },
            {
              "image": "assets/images/cycling_1.png",
              "joined": false,
              "title": "Yas Cycling Club",
              "subtitle": "Social rides • Weekly sessions • Beginners welcome",
              "members": "1,820 members",
            },
          ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Communities Using This Track",
                      style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 12),

          SizedBox(
            height: 273, 
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: data.length,
              separatorBuilder: (_, __) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final c = data[index];

                return CommunityCard(
                  imagePath: c["image"] as String,
                  title: c["title"] as String,
                  subtitle: c["subtitle"] as String,
                  members: c["members"] as String,
                  joined: c["joined"] as bool? ?? false,
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CommunityCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String members;
  final bool joined;
  final VoidCallback onTap;

  const CommunityCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.members,
    required this.joined,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 358, 
      height: 273, 
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(11.59),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(11.59), 
            child: Container(
              color: const Color(0xFFFFF3E2),
              child: Column(
                children: [
                  
                  SizedBox(
                    width: 358,
                    height: 178.66,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                           
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10.46),
                              topRight: Radius.circular(10.46),
                            ),
                            child: Image.asset(
                              imagePath,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) {
                                return Container(color: AppColors.softCream);
                              },
                            ),
                          ),
                        ),

                        // overlay
                        Positioned.fill(
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.10),
                          ),
                        ),

                        // Joined chip
                        if (joined)
                          const Positioned(
                            top: 12,
                            left: 12,
                            child: _JoinChip(),
                          ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            subtitle,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textSecondary,
                              height: 1.25,
                            ),
                          ),
                          const Spacer(),

                          // Members row
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/members.png", 
                                width: 16,
                                height: 16,
                                fit: BoxFit.contain,
                                errorBuilder: (_, __, ___) {
                                  return const Icon(
                                    Icons.groups_2_outlined,
                                    size: 16,
                                    color: AppColors.textSecondary,
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              Text(
                                members,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textSecondary,
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
        ),
      ),
    );
  }
}

class _JoinChip extends StatelessWidget {
  const _JoinChip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(999),
      ),
      child: const Text(
        "Joined",
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}
