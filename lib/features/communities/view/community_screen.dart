import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/communities/sections/communities_awareness.dart';
import 'package:adcc/features/communities/sections/community_card.dart';
import 'package:adcc/features/communities/sections/community_horizontal_card.dart';
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

  final List<String> filterPills = [
    'All',
    'Abu Dhabi',
    'Al Ain',
    'Western Region',
  ];

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
                  child: ListView(
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
                            'Search by track name, city, distance or terrain...',
                      ),
                      const SizedBox(height: 16),
                      CategorySelector(
                        categories: filterPills,
                        selectedIndex: selectedFilterIndex,
                        onSelected: (index) {
                          setState(() {
                            selectedFilterIndex = index;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      WarningMessage(
                        message:
                            'Join the ADCC ecosystem. Communities form by location and interests.',
                        type: MessageType.warning,
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Most Ride Tracks',
                        onViewAll: () {},
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 280,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return CommunityCard(
                              category: 'Social',
                              title: 'Abu Dhabi\nCommunity',
                              imagePath: 'assets/images/cycling_1.png',
                              joined: index == 0,
                              onTap: () {},
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Community Groups',
                        onViewAll: () {},
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        height: 250,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          separatorBuilder: (_, __) =>
                              const SizedBox(width: 16),
                          itemBuilder: (context, index) {
                            return CommunityHorizontalCard(
                              title: 'Family\nCommunity',
                              description:
                                  'A community focused on safe, fun, and inclusive cycling activities for families and children of all ages.',
                              imagePath: 'assets/images/cycling_1.png',
                              onExplore: () {},
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      SectionHeader(
                        title: 'Awareness & Special Communities',
                        onViewAll: () {},
                      ),
                      const SizedBox(height: 24),
                      const CommunitiesAwareness(),
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
}
