import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/community_highlight_track_card.dart';
import 'package:adcc/features/communities/sections/join_community_screen.dart';
import 'package:adcc/features/communities/sections/leavecommunity.dart';
import 'package:adcc/features/communities/services/communities_service.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';

class ExploreCommunityScreen extends StatefulWidget {
  final CommunityModel community;

  const ExploreCommunityScreen({
    super.key,
    required this.community,
  });

  @override
  State<ExploreCommunityScreen> createState() => _ExploreCommunityScreenState();
}

class _ExploreCommunityScreenState extends State<ExploreCommunityScreen> {
  int selectedTabIndex = 0;
  
  //  Local state variables
  late bool _isJoined;
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
    //  Initialize from community model
    _isJoined = widget.community.isJoined;
  }

  // Method to refresh local state
  void _refreshJoinStatus() {
    setState(() {
      _isJoined = widget.community.isJoined;
    });
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.community;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5EF),
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
          children: [
            // TOP BANNER IMAGE
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: " ",
              subtitle: '',
              onBackTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 14),

            // Title + Share icon
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    c.title,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFB11212),
                      height: 1.1,
                    ),
                  ),
                ),
                const SizedBox(width: 12),

                //  SHARE ICON
                _ShareButton(
                  onTap: () {
                    // TODO: Share logic later
                  },
                ),
              ],
            ),

            const SizedBox(height: 8),

            //  Description
            Text(
              c.description.trim().isEmpty
                  ? "Join this community to explore group rides, training sessions, and weekend cycling meetups.\n"
                      "Connect with riders, share routes, and stay updated on upcoming events.\n"
                      "Perfect for cyclists who love consistency, fitness, and community spirit."
                  : c.description,
              style: const TextStyle(
                fontSize: 13,
                height: 1.35,
                fontWeight: FontWeight.w500,
                color: Color(0xFF6B6B6B),
              ),
            ),

            const SizedBox(height: 16),

            _InfoGrid(community: c),

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

            _HighlightsCard(),

            const SizedBox(height: 14),

            // Tabs
            _TabsRow(
              tabs: tabs,
              selectedIndex: selectedTabIndex,
              onTap: (i) => setState(() => selectedTabIndex = i),
            ),

            const SizedBox(height: 14),

            // Tab content
            _TabContent(selectedTabIndex: selectedTabIndex),

            const SizedBox(height: 18),

            //  Dynamic button based on join status
            _BottomButton(
              title: isLoading 
                  ? "Please wait..." 
                  : (_isJoined ? "Leave Community" : "Join Community"),
              onTap: isLoading ? null : _handleJoinLeave,
              isLoading: isLoading,
              isJoined: _isJoined,
            ),
          ],
        ),
      ),
    );
  }

  //  Main method to handle join/leave logic
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Community joined successfully! 🎉"),
            backgroundColor: Colors.green,
          ),
        );

        // Navigate to JoinCommunity screen and wait for result
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
          _refreshJoinStatus();
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

class _ShareButton extends StatelessWidget {
  final VoidCallback onTap;

  const _ShareButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 38,
        width: 38,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Icon(
          Icons.share_rounded,
          size: 18,
          color: AppColors.brand_green,
        ),
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final CommunityModel community;

  const _InfoGrid({required this.community});

  @override
  Widget build(BuildContext context) {
    final c = community;

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
          value: (c.location ?? "Abu Dhabi"),
        ),
        tile(
          iconPath: "assets/icons/category.png",
          label: "Category",
          value: c.type.isEmpty ? "—" : c.type,
        ),
        tile(
          iconPath: "assets/icons/primary_tracks.png",
          label: "Primary Track",
          value: (c.trackName ?? "—"),
        ),
        tile(
          iconPath: "assets/icons/founded.png",
          label: "Founded",
          value: "2019",
        ),
        tile(
          iconPath: "assets/icons/upcoming_events.png",
          label: "Upcoming Events",
          value: "${c.eventsCount ?? 0}",
        ),
        tile(
          iconPath: "assets/icons/members.png",
          label: "Members",
          value: "${c.membersCount ?? 0}",
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
                  fontWeight: FontWeight.w700,
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
          value: "1,506+",
        ),
        const SizedBox(height: 10),
        row(
          icon: Icons.route_rounded,
          label: "Total Distance This Month",
          value: "12,450 Km",
        ),
        const SizedBox(height: 10),
        row(
          icon: Icons.star_rounded,
          label: "Average Ride Rating",
          value: "4.8",
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
      return _HorizontalCards(
        title: "Hudayriyat Island Track",
        subtitle: "19 Jan 2026",
      );
    }

    if (selectedTabIndex == 1) {
      return _HorizontalCards(
        title: "Al Wathba Cycling Track",
        subtitle: "Abu Dhabi",
      );
    }

    if (selectedTabIndex == 2) {
      return _HorizontalCards(
        title: "Community Gallery",
        subtitle: "Photos",
      );
    }

    return _HorizontalCards(
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

class _BottomButton extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool isLoading;
  final bool isJoined;

  const _BottomButton({
    required this.title,
    required this.onTap,
    required this.isLoading,
    required this.isJoined,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isJoined 
              ? const Color(0xFFB11212)  // Red for leave
              : const Color(0xFFB11212),  // Same red for join (or change if you want different)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}