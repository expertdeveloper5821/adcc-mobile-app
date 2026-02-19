import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/community_highlight_track_card.dart';
import 'package:adcc/features/communities/sections/join_community_screen.dart';
import 'package:adcc/features/communities/services/communities_service.dart';
import 'package:adcc/shared/widgets/app_button.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';

class CommunityCityDetails extends StatefulWidget {
  final CommunityModel community;

  const CommunityCityDetails({
    super.key,
    required this.community,
  });

  @override
  State<CommunityCityDetails> createState() => _CommunityCityDetailsState();
}

class _CommunityCityDetailsState extends State<CommunityCityDetails> {
  int selectedTabIndex = 0;

  bool joined = false;   // ✅ NOT final
  bool isLoading = false;

  final CommunitiesService _communitiesService = CommunitiesService();

  final List<String> tabs = const [
    "Events",
    "Tracks",
    "Gallery",
    "Updates",
  ];

  @override
void initState() {
  super.initState();
  joined = widget.community.isJoined ?? false;
}
  @override
  Widget build(BuildContext context) {
    final c = widget.community;

    final title = c.title.trim().isEmpty ? "Community" : c.title.trim();

    final description = c.description.trim().isEmpty
        ? "A friendly community for families and leisure riders.\n\nFocused on safe group riding, cycling education for kids, and weekend outdoor activities."
        : c.description.trim();

    final city = (c.location ?? "Abu Dhabi").trim();
    final category = c.type.trim().isEmpty ? "Family" : c.type.trim();
    final track = (c.trackName ?? "Corniche, Hudayriyat").trim();

    final members = c.membersCount ?? 0;
    final events = c.eventsCount ?? 0;



    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
          children: [
             // TOP BANNER IMAGE
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: " ",
              subtitle: '',
              onBackTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 14),

            // Title + share badge right
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFB11212),
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                _ShareBadge(onTap: () {}),
              ],
            ),

            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: const TextStyle(
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B6B6B),
              ),
            ),

            const SizedBox(height: 16),

            // INFO GRID
            _InfoGrid(
              city: city,
              category: category,
              primaryTrack: track,
              founded: "2022",
              upcomingEvents: "$events",
              members: "$members",
            ),

            const SizedBox(height: 18),

            const Text(
              "Community Highlights",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 12),

            // HIGHLIGHTS
            const _HighlightsCard(),

            const SizedBox(height: 14),

            // TABS
            _TabsRow(
              tabs: tabs,
              selectedIndex: selectedTabIndex,
              onTap: (i) => setState(() => selectedTabIndex = i),
            ),

            const SizedBox(height: 14),

            // TAB CONTENT
            _TabContent(selectedTabIndex: selectedTabIndex),

            const SizedBox(height: 18),
AppButton(
  label: isLoading
      ? "Please wait..."
      : (joined ? "Leave Community" : "Join Community"),
  onPressed: isLoading
      ? null
      : () async {
          final c = widget.community;
          final service = CommunitiesService();

          if (!joined) {
            setState(() => isLoading = true);

            final result = await service.joinCommunity(
              communityId: c.id,
            );

            setState(() => isLoading = false);

     if (result.success) {
  setState(() => joined = true);

  await Future.delayed(const Duration(milliseconds: 300));

  if (!context.mounted) return;

  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => JoinCommunity(community: c),
    ),
  );


            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(result.message ?? "Join failed")),
              );
            }
          } else {
            // Leave screen ya leave api call tum already bana chuke ho
            // yaha tum leave flow call kar sakte ho
          }
        },
  type: joined ? AppButtonType.danger : AppButtonType.primary,
  backgroundColor: const Color(0xFFB11212),
  textColor: Colors.white,
  borderRadius: 16,
  height: 52,
),


          ],
        ),
      ),
    );
  }
}

class _ShareBadge extends StatelessWidget {
  final VoidCallback onTap;

  const _ShareBadge({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            "assets/icons/share.png",
            height: 25,
            width: 25,
            // color: AppColors.brand_green, // agar png white ho
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final String city;
  final String category;
  final String primaryTrack;
  final String founded;
  final String upcomingEvents;
  final String members;

  const _InfoGrid({
    required this.city,
    required this.category,
    required this.primaryTrack,
    required this.founded,
    required this.upcomingEvents,
    required this.members,
  });

  @override
  Widget build(BuildContext context) {
   Widget tile({
  required String iconPath,
  required String label,
  required String value,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFFF5EDE0),
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          iconPath,
          height: 18,
          width: 18,
          color: AppColors.goldenOchre, // agar icon single color hai
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF6B6B6B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                maxLines: 2,
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


    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.55,
    children: [
  tile(
    iconPath: "assets/icons/city.png",
    label: "City",
    value: city,
  ),
  tile(
    iconPath: "assets/icons/category.png",
    label: "Category",
    value: category,
  ),
  tile(
    iconPath: "assets/icons/primary_tracks.png",
    label: "Primary Track",
    value: primaryTrack,
  ),
  tile(
    iconPath: "assets/icons/founded.png",
    label: "Founded",
    value: founded,
  ),
  tile(
    iconPath: "assets/icons/upcoming_events.png",
    label: "Upcoming Events",
    value: upcomingEvents,
  ),
  tile(
    iconPath: "assets/icons/members.png",
    label: "Members",
    value: members,
  ),
],

    );
  }
}

/// ------------------------------------------------------------
/// HIGHLIGHTS
/// ------------------------------------------------------------
class _HighlightsCard extends StatelessWidget {
  const _HighlightsCard();

  @override
  Widget build(BuildContext context) {
    Widget row({
      required IconData icon,
      required String label,
      required String value,
    }) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF5EDE0),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.goldenOchre),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                ),
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        row(
          icon: Icons.groups_rounded,
          label: "Active Members",
          value: "740+",
        ),
        const SizedBox(height: 10),
        row(
          icon: Icons.route_rounded,
          label: "Total Distance This Month",
          value: "6,300 Km",
        ),
        const SizedBox(height: 10),
        row(
          icon: Icons.star_rounded,
          label: "Average Ride Rating",
          value: "4.5",
        ),
      ],
    );
  }
}
class _TabsRow extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _TabsRow({
    required this.tabs,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: tabs.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),

              /// ✅ Fixed width + height
              width: 72,
              height: 38,

              /// ✅ Exact padding
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),

              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.goldenOchre
                    : const Color(0xFFF1F2F4),

                /// ✅ Radius 12px
                borderRadius: BorderRadius.circular(12),
              ),

              alignment: Alignment.center,

              child: Text(
                tabs[index],
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: isSelected ? Colors.white : const Color(0xFF1E1E1E),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _TabContent extends StatelessWidget {
  final int selectedTabIndex;

  const _TabContent({required this.selectedTabIndex});

  @override
  Widget build(BuildContext context) {
    if (selectedTabIndex == 0) {
      return const _HorizontalCards(
        title: "Hudayriyat Island Track",
        subtitle: "19 Jan 2026",
      );
    }

    if (selectedTabIndex == 1) {
      return const _HorizontalCards(
        title: "Corniche Track",
        subtitle: "Abu Dhabi",
      );
    }

    if (selectedTabIndex == 2) {
      return const _HorizontalCards(
        title: "Community Gallery",
        subtitle: "Photos",
      );
    }

    return const _HorizontalCards(
      title: "Latest Updates",
      subtitle: "News",
    );
  }
}

/// ------------------------------------------------------------
/// HORIZONTAL CARDS
/// ------------------------------------------------------------
class _HorizontalCards extends StatelessWidget {
  final String title;
  final String subtitle;

  const _HorizontalCards({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
  return SizedBox(
  height: 250,
  child: ListView.separated(
    scrollDirection: Axis.horizontal,
    physics: const BouncingScrollPhysics(),
    itemCount: 4,
    separatorBuilder: (_, __) => const SizedBox(width: 14),
    itemBuilder: (context, index) {
      return CommunityHighlightTrackCard(
        imagePath: "assets/images/cycling_1.png",
        title: title,
        subtitle: subtitle,
        onTap: () {},
      );
    },
  ),
);

  }
}
