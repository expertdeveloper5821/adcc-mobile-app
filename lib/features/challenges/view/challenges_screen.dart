import 'package:adcc/features/challenges/view/sections/Challenge%20Screen/challenge_header.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/banner_with_search.dart';
import '../../../shared/widgets/back_button_widget.dart';
import '../../../shared/widgets/category_selector.dart';
import 'sections/Challenge Screen/active_challenges_section.dart';
import 'sections/recent_challenges_section.dart';

class ChallengesScreen extends StatefulWidget {
  const ChallengesScreen({super.key});

  @override
  State<ChallengesScreen> createState() => _ChallengesScreenState();
}

class _ChallengesScreenState extends State<ChallengesScreen> {
  int selectedFilterIndex = 0;
  String searchQuery = '';

  final List<String> filterTabs = [
    'Active (3)',
    'Upcoming (2)',
    'Completed (2)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Padding(
     padding: const EdgeInsets.symmetric(vertical: 24),
        child: SafeArea(
          
          child: Column(
            
            children: [
              // Header with Back Button
            
        const SizedBox(height: 8),
        
              // Main Content
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
        ChallengeHeader(
          imagePath: 'assets/images/cycling_1.png',
          title: 'Challenges',
          wantSearchBar: true,
          searchValue: searchQuery,
          placeholder: 'Search events...',
          onChangeHandler: (value) {
            setState(() {
        searchQuery = value;
            });
          },
        ),
        
        const SizedBox(height: 34),
        
                    // Filter Tabs
                    CategorySelector(
                      categories: filterTabs,
                      selectedIndex: selectedFilterIndex,
                      onSelected: (index) {
                        setState(() {
                          selectedFilterIndex = index;
                        });
                      },
                    ),
        
                    const SizedBox(height: 32),
        
                    // Active Challenges Section (shown when Active tab is selected)
                    if (selectedFilterIndex == 0) ...[
                      const ActiveChallengesSection(),
                      const SizedBox(height: 32),
                    ],
        
                    // Upcoming Challenges Section (shown when Upcoming tab is selected)
                    if (selectedFilterIndex == 1) ...[
                      const ActiveChallengesSection(), // Reuse for now, can be customized later
                      const SizedBox(height: 32),
                    ],
        
                    // Completed Challenges Section (shown when Completed tab is selected)
                    if (selectedFilterIndex == 2) ...[
                      const ActiveChallengesSection(), // Reuse for now, can be customized later
                      const SizedBox(height: 32),
                    ],
        
                 
                    const RecentChallengesSection(),
        
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

