import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/my_community_screen.dart';
import 'package:adcc/shared/widgets/adaptive_image.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:flutter/material.dart';

class JoinCommunity extends StatelessWidget {
  final CommunityModel community;

  const JoinCommunity({
    super.key,
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    final title = community.title.trim().isEmpty
        ? "Abu Dhabi Road Racers"
        : community.title.trim();

    final members = community.membersCount ?? 2800;
    final location = (community.location ?? "Abu Dhabi").trim();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final h = constraints.maxHeight;
            final w = constraints.maxWidth;

            /// Responsive position for frame
            final frameTop = h * 0.36; // 36% from top
            final frameLeft = -w * 0.04; // slight outside
            final frameWidth = w * 0.32; // responsive width

            return Stack(
              children: [
                /// LEFT ARC FRAME (RESPONSIVE)
                Positioned(
                  left: frameLeft,
                  top: frameTop,
                  child: IgnorePointer(
                    child: Image.asset(
                      "assets/images/frame_1.png",
                      width: frameWidth,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// MAIN CONTENT
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
                  child: Column(
                    children: [
                      /// SCROLLABLE PART
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              /// TOP BACK BUTTON
                              Align(
                                alignment: Alignment.centerLeft,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    height: 36,
                                    width: 36,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFEDE6DA),
                                      borderRadius: BorderRadius.circular(14),
                                    ),
                                    child: const Icon(
                                      Icons.arrow_back_ios_new_rounded,
                                      size: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// TOP CIRCLE + DOT
                              Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: 128,
                                      width: 128,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    Positioned(
                                      left: 26,
                                      top: 42,
                                      child: Container(
                                        height: 10,
                                        width: 10,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFB11212),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// TITLE
                              const Text(
                                "Welcome to the\nCommunity!",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  color: Color(0xFF1E1E1E),
                                  height: 1.15,
                                ),
                              ),

                              const SizedBox(height: 10),

                              /// SUBTITLE
                              Text(
                                "You have successfully joined\n$title",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF6B6B6B),
                                  height: 1.35,
                                ),
                              ),

                              const SizedBox(height: 18),

                              /// COMMUNITY CARD
                              _JoinedCommunityCard(
                                title: title,
                                members: members,
                                location: location,
                              ),

                              const SizedBox(height: 18),

                              /// WHAT'S NEXT
                              const Text(
                                "What's Next?",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                ),
                              ),

                              const SizedBox(height: 12),

                              /// OPTIONS
                              _NextOptionTile(
                                icon: Icons.notifications_active_rounded,
                                title: "Notifications Enabled",
                                onTap: () {},
                              ),
                              const SizedBox(height: 10),
                              _NextOptionTile(
                                icon: Icons.chat_bubble_rounded,
                                title: "Join Community Chats",
                                onTap: () {},
                              ),
                              const SizedBox(height: 10),
                              _NextOptionTile(
                                icon: Icons.calendar_month_rounded,
                                title: "Upcoming Events",
                                onTap: () {},
                              ),

                              const SizedBox(height: 18),
                            ],
                          ),
                        ),
                      ),

                      /// FIXED BOTTOM BUTTON
                      AppButton(
                        label: "Start Exploring",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Mycommunity(
                                myCommunities: [community],
                              ),
                            ),
                          );
                        },
                        type: AppButtonType.primary,
                        backgroundColor: const Color(0xFFB11212),
                        textColor: Colors.white,
                        borderRadius: 16,
                        height: 52,
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _JoinedCommunityCard extends StatelessWidget {
  final String title;
  final int members;
  final String location;

  const _JoinedCommunityCard({
    required this.title,
    required this.members,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.buttonGuest,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: AdaptiveImage(
                    imagePath: "assets/images/cycling_1.png",
                    width: 76,
                    height: 76,
                    fit: BoxFit.cover,
                    placeholderColor: AppColors.softCream,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "The main cycling community in\nAbu Dhabi, bringing together...",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          height: 1.3,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF6B6B6B),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _MiniInfoBox(
                    icon: Icons.groups_rounded,
                    title: "Members",
                    value: members.toString(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MiniInfoBox(
                    icon: Icons.location_on_rounded,
                    title: "Location",
                    value: location,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniInfoBox extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MiniInfoBox({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.dustyRose,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.goldenOchre),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF6B6B6B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NextOptionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _NextOptionTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 58,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: BoxDecoration(
          color: const Color(0xFFFFEFD7),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              height: 38,
              width: 38,
              decoration: BoxDecoration(
                color: AppColors.goldenOchre,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Color(0xFF6B6B6B),
            ),
          ],
        ),
      ),
    );
  }
}
