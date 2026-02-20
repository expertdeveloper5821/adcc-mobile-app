import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/community_highlight_track_card.dart';
import 'package:adcc/features/communities/sections/join_community_screen.dart';
import 'package:adcc/features/communities/sections/leavecommunity.dart';
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
  bool isLoading = false;
  
  //  Local variable to track join status
  late bool _isJoined;

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
    //  Initialize from community model
    _isJoined = widget.community.isJoined;
  }

  //  Method to refresh community data
  Future<void> _refreshCommunityData() async {
    // You can optionally fetch fresh data from API here
    setState(() {
      _isJoined = widget.community.isJoined;
    });
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

            //  JOIN/LEAVE BUTTON with proper state management
            AppButton(
              label: isLoading
                  ? "Please wait..."
                  : (_isJoined ? "Leave Community" : "Join Community"),
              onPressed: isLoading ? null : _handleJoinLeave,
              type: _isJoined ? AppButtonType.danger : AppButtonType.primary,
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

  //  Separate method to handle join/leave logic
  Future<void> _handleJoinLeave() async {
    if (!_isJoined) {
      // JOIN COMMUNITY
      setState(() => isLoading = true);

      final result = await _communitiesService.joinCommunity(
        communityId: widget.community.id,
      );

      setState(() => isLoading = false);

      if (!mounted) return;

      if (result.success) {
        // Update local state
        setState(() {
          _isJoined = true;
          widget.community.isJoined = true;
        });

        // Show success message
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Community joined successfully! 🎉"),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to JoinCommunity screen WITHOUT replacing
        // This ensures when we come back, state is preserved
        final shouldRefresh = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => JoinCommunity(
              community: widget.community,
            ),
          ),
        );

        // If JoinCommunity returns true, refresh data
        if (shouldRefresh == true && mounted) {
          _refreshCommunityData();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message ?? "Join failed ❌"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      // LEAVE COMMUNITY
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (_) => LeaveCommunity(
            community: widget.community,
          ),
        ),
      );

      if (result == true && mounted) {
        // Update local state
        setState(() {
          _isJoined = false;
          widget.community.isJoined = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Community left successfully "),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }
}

// Rest of the widgets remain the same...
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
              color: AppColors.goldenOchre,
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
              width: 72,
              height: 38,
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 9),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.goldenOchre
                    : const Color(0xFFF1F2F4),
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