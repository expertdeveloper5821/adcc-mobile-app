import 'package:adcc/features/profile/view/sections/badges/rider_level_section.dart';
import 'package:adcc/features/profile/view/sections/reward_point/available_points_section.dart';
import 'package:adcc/features/profile/view/sections/reward_point/available_rewards_section.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';

class RewardsPointsScreen extends StatelessWidget {
  const RewardsPointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFFF),
      body: Padding(
              padding:
                  const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
         BannerHeadder(
                      imagePath:
                          'assets/images/cycling_1.png',
                      title: 'Rewards & Points',
                      subtitle:
                          ' Earn points by completing challenges',
                      onBackTap: () =>
                          Navigator.pop(context),
                    ),
          
              const SizedBox(height: 20),
        
             const RiderStatsSection(
  riderLevel: "Rider Level: Intermediate",

  badgesTitle: "Earned This Month",
  badgesValue: "475",

  pointsTitle: "Reward Clamied",
  pointsValue: "08",

  progressTitle: "Current Tier",
  progressValue: "Silver",
),
        const SizedBox(height: 20),
        
              
        const AvailablePointsSection(),
        
              
        
                const SizedBox(height: 16),
        
              const AvailableRewardsSection(),
              ]
            ))
        
       )
      )
        );
  }
}
