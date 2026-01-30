import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/models/community_model.dart';
import 'package:adcc/features/communities/sections/communities_awareness.dart';
import 'package:adcc/features/communities/sections/community_card.dart';
import 'package:adcc/features/communities/sections/community_horizontal_card.dart';
import 'package:adcc/features/communities/services/communities_service.dart';
import 'package:adcc/shared/widgets/back_button_widget.dart';
import 'package:adcc/shared/widgets/banner_with_search.dart';
import 'package:adcc/shared/widgets/category_selector.dart';
import 'package:adcc/shared/widgets/section_header.dart';
import 'package:adcc/shared/widgets/warning_message.dart';
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
    } catch (e, stackTrace) {
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

    // final filtered = _allCommunities.where((community) =>  community.category.contains('City Communities'));
    print("filtered ${filtered.length}");
    print("city ${filtered.where((community) {
          return community.hasAnyCategory(_cityCommunityCategories);
        }).toList().length}");

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
                // Padding(
                //   padding: const EdgeInsets.all(16),
                //   child: Row(
                //     children: [
                //       AppBackButton(
                //         backgroundColor:
                //             AppColors.paleGreen.withValues(alpha: 0.36),
                //         iconColor: AppColors.brand_green,
                //         onBack: () {
                //           if (Navigator.of(context).canPop()) {
                //             Navigator.of(context).pop();
                //           }
                //         },
                //       ),
                //     ],
                //   ),
                // ),
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
                                  onChangeHandler: (value) {
                                    setState(() {
                                      searchQuery = value;
                                    });
                                  },
                                  placeholder:
                                      'Search by tracks name, city, distance, or terrain…',
                                ),
                                const SizedBox(height: 30),
                                CategorySelector(
                                  categories: filterPills,
                                  selectedIndex: selectedFilterIndex,
                                  onSelected: (index) {
                                    setState(() {
                                      selectedFilterIndex = index;
                                    });
                                  },
                                ),
                                const SizedBox(height: 30),
                                WarningMessage(
                                  message:
                                      'Join the ADCC ecosystem. Communities form by location and interests.',
                                  type: MessageType.warning,
                                ),
                                const SizedBox(height: 30),
                                SectionHeader(
                                  title: 'City Communities',
                                  onViewAll: () {},
                                ),
                                const SizedBox(height: 20),
                                _buildCityCommunitiesSection(),
                                const SizedBox(height: 30),
                                SectionHeader(
                                  title: 'Community Groups',
                                  onViewAll: () {},
                                ),
                                const SizedBox(height: 20),
                                _buildGroupCommunitiesSection(),
                                const SizedBox(height: 30),
                                SectionHeader(
                                  title: 'Awareness & Special\nCommunities',
                                  onViewAll: () {},
                                ),
                                const SizedBox(height: 20),
                                _buildAwarenessCommunitiesSection(),
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

  Widget _buildCityCommunitiesSection() {
    final cityCommunities = _getCityCommunities();

    if (cityCommunities.isEmpty) {
      return const SizedBox(
        height: 100,
        child: Center(
          child: Text(
            'No city communities found',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      );
    }

    return SizedBox(
      height: 280,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: cityCommunities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final community = cityCommunities[index];
          return CommunityCard(
            category: community.category.isNotEmpty
                ? community.category.first
                : 'Community',
            title: community.title,
            imagePath: community.imageUrl ?? 'assets/images/cycling_1.png',
            joined: community.isJoined ?? false,
            description: community.description,
            onTap: () {
              // Handle community tap
            },
            onExplore: () {
              // Handle explore community
            },
          );
        },
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
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: groupCommunities.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
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
