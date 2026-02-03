import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/communities_awareness.dart';
import 'package:adcc/features/communities/sections/community_card.dart';
import 'package:adcc/features/communities/sections/community_categories_grid.dart';
import 'package:adcc/features/communities/sections/community_horizontal_card.dart';
import 'package:adcc/features/communities/sections/view_all_communities_screen.dart';
import 'package:adcc/features/communities/services/communities_service.dart';
import 'package:adcc/shared/widgets/back_button_widget.dart';
import 'package:adcc/shared/widgets/banner_with_search.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:flutter/material.dart';

class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  int selectedFilterIndex = 0;
  String searchQuery = '';
  bool _isLoading = true;
  String? _errorMessage;
  final CommunitiesService _communitiesService = CommunitiesService();
  List<CommunityModel> _allCommunities = [];

  final List<String> filterPills = [
    'All',
    'Abu Dhabi',
    'Al Ain',
    'Western Region',
  ];

  // Category mappings for different sections - matching API category values
  final List<String> _cityCommunityCategories = ['City Communities'];
  final List<String> _groupCommunityCategories = ['Group Communities'];
  final List<String> _awarenessCommunityCategories = [
    'Awareness & Special Communities'
  ];

  final List<String> communityItems = [
    'All',
    'Family & Leisure',
    'Racing & Performance',
  ];
  final List<String> communityTypes = [
    'Racing & Performance',
    'Family Rides',
    'Women (SheRides)',
  ];
  final List<String> purposeBased = [
    'All',
    'Awareness & Charity',
    'Corporate',
    'Education'
  ];

  @override
  void initState() {
    super.initState();
    _loadCommunities();
  }

  @override
  void dispose() {
    // Clear state when component unmounts to ensure fresh data on next mount
    _allCommunities = [];
    _isLoading = true;
    _errorMessage = null;
    searchQuery = '';
    selectedFilterIndex = 0;
    super.dispose();
  }

  Future<void> _loadCommunities() async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await _communitiesService.getCommunities();

      if (mounted) {
        setState(() {
          _isLoading = false;

          if (response.success && response.data != null) {
            // Extract communities from nested structure
            List<dynamic> communitiesList = [];

            if (response.data is Map) {
              final data = response.data as Map<String, dynamic>;

              // Try different response structures
              if (data.containsKey('data') && data['data'] is Map) {
                final nestedData = data['data'] as Map<String, dynamic>;
                if (nestedData.containsKey('communities')) {
                  communitiesList = nestedData['communities'] as List;
                }
              } else if (data.containsKey('communities')) {
                communitiesList = data['communities'] as List;
              } else if (data.containsKey('data') && data['data'] is List) {
                communitiesList = data['data'] as List;
              }
            } else if (response.data is List) {
              communitiesList = response.data as List;
            }

            // Parse communities into model objects
            _allCommunities = communitiesList
                .map((json) =>
                    CommunityModel.fromJson(json as Map<String, dynamic>))
                .toList();

            _errorMessage = null;
          } else {
            _errorMessage = response.message ?? 'Failed to load communities';
            _allCommunities = [];
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'An unexpected error occurred: $e';
        });
      }
    }
  }

  // Filter communities by category
  List<CommunityModel> _getFilteredCommunities() {
    List<CommunityModel> filtered = _allCommunities;

    // Apply search filter
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((community) {
        final query = searchQuery.toLowerCase();
        return community.title.toLowerCase().contains(query) ||
            community.description.toLowerCase().contains(query) ||
            community.category.any((cat) => cat.toLowerCase().contains(query));
      }).toList();
    }

    // Apply location filter (if needed based on filter pills)
    if (selectedFilterIndex > 0) {
      final selectedLocation = filterPills[selectedFilterIndex];
      filtered = filtered.where((community) {
        return community.title
            .toLowerCase()
            .contains(selectedLocation.toLowerCase());
      }).toList();
    }

    return filtered;
  }

  // Get communities for City Communities section - ONLY communities with exact "City Communities" category
  List<CommunityModel> _getCityCommunities() {
    final filtered = _getFilteredCommunities();

    return filtered.where((community) {
      return community.hasAnyCategory(_cityCommunityCategories);
    }).toList();
  }

  // Get communities for Community Groups section - ONLY communities with exact "Group Communities" category
  List<CommunityModel> _getGroupCommunities() {
    final filtered = _getFilteredCommunities();

    return filtered.where((community) {
      return community.hasAnyCategory(_groupCommunityCategories);
    }).toList();
  }

  // Get communities for Awareness & Special Communities section - ONLY communities with exact "Awareness & Special Communities" category
  List<CommunityModel> _getAwarenessCommunities() {
    final filtered = _getFilteredCommunities();

    return filtered.where((community) {
      return community.hasAnyCategory(_awarenessCommunityCategories);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // Header with Back Button
                Padding(
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
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : _errorMessage != null
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 64,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 16),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                    ),
                                    child: Text(
                                      _errorMessage!,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: _loadCommunities,
                                    child: const Text('Retry'),
                                  ),
                                ],
                              ),
                            )
                          : ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              children: [
                                BannerWithSearch(
                                  imagePath: 'assets/images/cycling_1.png',
                                  title: 'Communities',
                                  wantSearchBar: true,
                                  searchValue: searchQuery,
                                  showBackButton: true,
                                  onChangeHandler: (value) {
                                    setState(() {
                                      searchQuery = value;
                                    });
                                  },
                                  placeholder:
                                      'Search by track name, city, distance or terrain...',
                                ),
                                const SizedBox(height: 24),
                                SectionHeader(
                                  title: 'Communities in Your City',
                                  onViewAll: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ViewAllCommunitiesScreen(
                                          title: 'Communities in Abu Dhabi',
                                          subTitle:
                                              'All cycling communities active near you',
                                          communities:
                                              _getAwarenessCommunities(),
                                          filterPills: communityItems,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                                _buildAwarenessCommunitiesSection(),
                                const SizedBox(height: 24),
                                SectionHeader(
                                  title: 'Browse by Community Type',
                                  onViewAll: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ViewAllCommunitiesScreen(
                                          title: 'Community Types',
                                          subTitle:
                                              "Choose communities based on your riding preference",
                                          communities:
                                              _getAwarenessCommunities(),
                                          filterPills: communityTypes,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                                CommunityCategoriesGrid(
                                  onCategoryTap: (category) {
                                    // Handle category tap
                                    debugPrint('Category tapped: $category');
                                  },
                                ),
                                const SizedBox(height: 24),
                                SectionHeader(
                                  title: 'Purpose-Based Communities',
                                  onViewAll: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            ViewAllCommunitiesScreen(
                                          title: 'Purpose-Based Communities',
                                          subTitle:
                                              "Join local cycling groups, find rides and events, and connect with neighborhood riders.",
                                          communities:
                                              _getAwarenessCommunities(),
                                          filterPills: purposeBased,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 24),
                                _buildGroupCommunitiesSection(),
                              ],
                            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupCommunitiesSection() {
    final groupCommunities = _getGroupCommunities();

    if (groupCommunities.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No community groups found',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: groupCommunities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final community = groupCommunities[index];
          return CommunityHorizontalCard(
            title: community.title,
            description: community.description,
            imagePath: community.imageUrl ?? 'assets/images/cycling_1.png',
            onExplore: () {
              // Handle explore community
            },
          );
        },
      ),
    );
  }

  Widget _buildAwarenessCommunitiesSection() {
    final awarenessCommunities = _getAwarenessCommunities();

    if (awarenessCommunities.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No awareness communities found',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return CommunitiesAwareness(
      communities: awarenessCommunities,
    );
  }
}
