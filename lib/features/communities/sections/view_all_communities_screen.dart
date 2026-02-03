import 'package:flutter/material.dart';
import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/auth/view/communityDetailScreen/view/community_detail.dart';
import 'package:adcc/shared/widgets/banner_with_search.dart';
import 'package:adcc/shared/widgets/category_selector.dart';

/// ---------------- SORT TYPES ----------------

enum SortType {
  mostActive,
  mostMembers,
  upcomingEvents,
  recentlyCreated,
}

class ViewAllCommunitiesScreen extends StatefulWidget {
  final String title;
  final String? subTitle;
  final List<String> filterPills;
  final List<CommunityModel> communities;

  const ViewAllCommunitiesScreen({
    super.key,
    required this.title,
    this.subTitle,
    required this.filterPills,
    required this.communities,
  });

  @override
  State<ViewAllCommunitiesScreen> createState() =>
      _ViewAllCommunitiesScreenState();
}

class _ViewAllCommunitiesScreenState extends State<ViewAllCommunitiesScreen> {
  int selectedIndex = 0;
  String search = '';

  SortType _selectedSort = SortType.mostActive;

  /// ---------------- FILTER + SORT ----------------

  List<CommunityModel> get filteredList {
    List<CommunityModel> list = [...widget.communities];

    /// Search
    if (search.isNotEmpty) {
      list = list.where((c) {
        return c.title.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    /// Category Filter
    if (selectedIndex != 0) {
      list = list.where((c) {
        return c.category.any(
          (e) => e.toLowerCase().contains(
                widget.filterPills[selectedIndex].toLowerCase(),
              ),
        );
      }).toList();
    }

    /// Sort
    switch (_selectedSort) {
      case SortType.mostActive:
        // Default order (API order)
        break;

      case SortType.mostMembers:
        list.sort(
            (a, b) => (b.membersCount ?? 0).compareTo(a.membersCount ?? 0));
        break;

      case SortType.upcomingEvents:
        list.sort((a, b) => (b.eventsCount ?? 0).compareTo(a.eventsCount ?? 0));
        break;

      case SortType.recentlyCreated:
        list.sort((a, b) => (b.eventsCount ?? 0).compareTo(a.eventsCount ?? 0));
        break;
    }

    return list;
  }

  /// ---------------- UI ----------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8ED),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Back Button
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
              ),
            ),

            /// Banner
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: BannerWithSearch(
                  imagePath: 'assets/images/cycling_1.png',
                  title: widget.title,
                  subtitle: widget.subTitle,
                  wantSearchBar: false,
                  showBackButton: true,
                  height: 200,
                ),
              ),
            ),

            /// Filters + Header
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),

                  /// Category Pills
                  CategorySelector(
                    categories: widget.filterPills,
                    selectedIndex: selectedIndex,
                    onSelected: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),

                  const SizedBox(height: 24),

                  /// Count + Sort
                  _buildHeader(),

                  const SizedBox(height: 16),
                ]),
              ),
            ),

            /// List
            _buildList(),
          ],
        ),
      ),
    );
  }

  /// ---------------- HEADER ----------------

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (widget.title == "Communities in Abu Dhabi")
          Text(
            '${filteredList.length} communities found',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        if (widget.title == "Community Types")
          Text(
            'Family Cycling Communities in Abu Dhabi',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        if (widget.title == "Purpose-Based Communities")
          Text(
            'Explore Communities',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
        if (widget.title == "Communities in Abu Dhabi")
          GestureDetector(
            onTapDown: (details) {
              _showSortMenu(details.globalPosition);
            },
            child: Row(
              children: [
                const Icon(
                  Icons.swap_vert,
                  size: 18,
                  color: AppColors.goldenOchre,
                ),
                const SizedBox(width: 4),
                Text(
                  _getSortLabel(),
                  style: const TextStyle(
                    color: AppColors.goldenOchre,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// ---------------- POPUP MENU ----------------

  void _showSortMenu(Offset position) async {
    final result = await showMenu<SortType>(
      context: context,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        20,
        20,
      ),
      items: [
        _buildMenuItem(
          SortType.mostActive,
          'Most Active',
        ),
        _buildMenuItem(
          SortType.mostMembers,
          'Most Members',
        ),
        _buildMenuItem(
          SortType.upcomingEvents,
          'Upcoming Events',
        ),
        _buildMenuItem(
          SortType.recentlyCreated,
          'Recently Created',
        ),
      ],
    );

    if (result != null) {
      setState(() {
        _selectedSort = result;
      });
    }
  }

  PopupMenuItem<SortType> _buildMenuItem(
    SortType value,
    String text,
  ) {
    return PopupMenuItem<SortType>(
      value: value,
      child: Row(
        children: [
          if (_selectedSort == value)
            const Icon(
              Icons.check,
              size: 16,
              color: AppColors.goldenOchre,
            ),
          if (_selectedSort == value) const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: AppColors.goldenOchre,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------- LABEL ----------------

  String _getSortLabel() {
    switch (_selectedSort) {
      case SortType.mostMembers:
        return 'Most Members';

      case SortType.upcomingEvents:
        return 'Upcoming Events';

      case SortType.mostActive:
        return 'Most Active';

      default:
        return 'Most Active';
    }
  }

  /// ---------------- LIST ----------------

  Widget _buildList() {
    if (filteredList.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: const Center(
          child: Text(
            'No communities found',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final community = filteredList[index];

            return Padding(
              padding: EdgeInsets.only(
                bottom: index < filteredList.length - 1 ? 20 : 0,
              ),
              child: _CommunityListCard(community: community),
            );
          },
          childCount: filteredList.length,
        ),
      ),
    );
  }
}

/// --------------------------------------------------
/// COMMUNITY CARD
/// --------------------------------------------------

class _CommunityListCard extends StatelessWidget {
  final CommunityModel community;

  const _CommunityListCard({
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => CommunityDetailScreen(
        //       community: community,
        //     ),
        //   ),
        // );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.dustyRose,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                community.imageUrl ?? '',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    'assets/images/cycling_1.png',
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  /// Title
                  Text(
                    community.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 4),

                  /// Description
                  Text(
                    community.description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.people, size: 16),
                          const SizedBox(width: 4),
                          Text('${community.membersCount ?? 0} members'),
                          const SizedBox(width: 16),
                          const Icon(Icons.event, size: 16),
                          const SizedBox(width: 4),
                          Text('${community.eventsCount ?? 0} events'),
                        ],
                      ),
                      _MemberAvatarsWidget(
                        images: community.memberImages ??
                            [
                              // Fallback if API gives null
                              "https://randomuser.me/api/portraits/men/1.jpg",
                              "https://randomuser.me/api/portraits/women/2.jpg",
                              "https://randomuser.me/api/portraits/men/3.jpg",
                            ],
                        extraCount: (community.membersCount ?? 0) - 3,
                      ),
                    ],
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

class _MemberAvatarsWidget extends StatelessWidget {
  final List<String> images;
  final int extraCount;

  const _MemberAvatarsWidget({
    required this.images,
    required this.extraCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: List.generate(
            images.length > 3 ? 3 : images.length,
            (index) {
              return Padding(
                padding: EdgeInsets.only(left: index * 18),
                child: CircleAvatar(
                  radius: 12,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 11,
                    backgroundImage: NetworkImage(images[index]),
                  ),
                ),
              );
            },
          ),
        ),
        if (extraCount > 0) ...[
          const SizedBox(width: 8),
          Text(
            '+$extraCount',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }
}
