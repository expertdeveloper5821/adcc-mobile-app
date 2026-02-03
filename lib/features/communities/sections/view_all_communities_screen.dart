import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/shared/widgets/back_button_widget.dart';
import 'package:adcc/shared/widgets/banner_with_search.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:flutter/material.dart';

class ViewAllCommunitiesScreen extends StatefulWidget {
  final String title;
  final List<CommunityModel> communities;

  const ViewAllCommunitiesScreen({
    super.key,
    required this.title,
    required this.communities,
  });

  @override
  State<ViewAllCommunitiesScreen> createState() =>
      _ViewAllCommunitiesScreenState();
}

class _ViewAllCommunitiesScreenState extends State<ViewAllCommunitiesScreen> {
  int selectedIndex = 0;
  String search = '';

  final List<String> filterPills = [
    'All',
    'Family & Leisure',
    'Racing & Performance',
  ];

  List<CommunityModel> get filteredList {
    List<CommunityModel> list = widget.communities;

    /// Search
    if (search.isNotEmpty) {
      list = list.where((c) {
        return c.title.toLowerCase().contains(search.toLowerCase());
      }).toList();
    }

    /// Filter
    if (selectedIndex != 0) {
      list = list.where((c) {
        return c.category.any(
          (e) => e.toLowerCase().contains(
                filterPills[selectedIndex].toLowerCase(),
              ),
        );
      }).toList();
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFF8ED),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            /// Back Button at top
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    AppBackButton(
                      backgroundColor:
                          AppColors.paleGreen.withValues(alpha: 0.36),
                      iconColor: AppColors.brand_green,
                      onBack: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),

            /// Banner (scrollable) with horizontal padding
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverToBoxAdapter(
                child: BannerWithSearch(
                  imagePath: 'assets/images/cycling_1.png',
                  title: widget.title,
                  wantSearchBar: true,
                  searchValue: search,
                  onChangeHandler: (v) {
                    setState(() => search = v);
                  },
                  placeholder: 'Search communities...',
                ),
              ),
            ),

            /// Content with horizontal padding
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),

                  // Filter Pills
                  CategorySelector(
                    categories: filterPills,
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

            /// List without horizontal padding (image will be full width)
            _buildList(),
          ],
        ),
      ),
    );
  }

  // ---------------- Count + Sort ----------------

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${filteredList.length} communities found',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        Row(
          children: const [
            Icon(
              Icons.swap_vert,
              size: 18,
              color: Colors.orange,
            ),
            SizedBox(width: 4),
            Text(
              'Most Active',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ---------------- List ----------------

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

// --------------------------------------------------
// Community Card (Same UI as Design)
// --------------------------------------------------

class _CommunityListCard extends StatelessWidget {
  final CommunityModel community;

  const _CommunityListCard({
    required this.community,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                /// Tag
                // if (community.category.isNotEmpty)
                //   Container(
                //     padding:
                //         const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                //     decoration: BoxDecoration(
                //       color: Colors.black.withValues(alpha: 0.6),
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     child: Text(
                //       community.category.first,
                //       style: const TextStyle(
                //         color: Colors.white,
                //         fontSize: 12,
                //       ),
                //     ),
                //   ),

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

                /// Stats
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
