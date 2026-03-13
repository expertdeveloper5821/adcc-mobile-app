import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/profile/view/sections/badges/rider_level_section.dart';
import 'package:adcc/features/profile/view/sections/event_history/completed_event_card.dart';
import 'package:adcc/features/profile/view/sections/event_history/perfromance_insights_card.dart';
import 'package:adcc/features/profile/view/sections/event_history/upcoming_event_card_section.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';


class EventHistoryScreen extends StatelessWidget {
  const EventHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softCream,
      body: Padding(
        padding:   const EdgeInsets.fromLTRB(16, 16, 16, 20),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
         BannerHeadder(
                      imagePath:
                          'assets/images/cycling_1.png',
                      title: 'Event History',
                      subtitle:
                          '',
                          centerTitle: true,
                      onBackTap: () =>
                          Navigator.pop(context),
                    ),
          
              const SizedBox(height: 20),
        
     const RiderStatsSection(
  riderLevel: "Rider Level: Intermediate",

  badgesTitle: "Total Events",
  badgesValue: "14",

  pointsTitle: "Completed",
  pointsValue: "12",

  progressTitle: "Podium Finishes",
  progressValue: "03",
),
        
                const SizedBox(height: 30),
         const PerformanceInsightsCard(),

                const SizedBox(height: 40),
        
        
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2),
  child:Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    const Text(
  "Completed Events",
  style: const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1, // 100% line height
    letterSpacing: 0,
    color: AppColors.charcoal,
  ),
),

    Row(
      children: const [
       Text(
  "View All",
  textAlign: TextAlign.center,
  style: const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 1, // 100% line height
    letterSpacing: 0,
    color: Color(0xFF484A4D),
  ),
),
        SizedBox(width: 4),
        Icon(
          Icons.chevron_right,
          size: 18,
              color: Color(0xFF484A4D),
        )
      ],
    )
  ],
),
),

const SizedBox(height: 6),

CompletedEventCard(
  title: "ADCC New Year Ride 2026",
  subtitle: "Community Ride",
  date: "Jan 1, 2026",
  status: "Completed",
  distance: "45 km",
  time: "1h 52m",
  rank: "24th of 156",
  image:
     'assets/images/cycling_1.png',
),

CompletedEventCard(
  title: "Desert Challenge 500K",
  subtitle: "Community Ride",
  date: "Jan 1, 2026",
  status: "Completed",
  distance: "45 km",
  time: "1h 52m",
  rank: "24th of 156",
  image:
     'assets/images/cycling_1.png',
),

CompletedEventCard(
  title: "Family Fun Ride",
   subtitle: "Community Ride",
  date: "Jan 1, 2026",
  status: "Completed",
  distance: "45 km",
  time: "1h 52m",
  rank: "24th of 156",
  image:
     'assets/images/cycling_1.png',
),
        
                const SizedBox(height: 40),
        
        Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [

    const Padding(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Text(
  "Upcoming Events",
  style: const TextStyle(
    fontFamily: 'Outfit',
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1, // 100% line height
    letterSpacing: 0,
    color: AppColors.charcoal,
  ),
)
    ),

    const SizedBox(height: 12),

    SizedBox(
      height: 392,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 2),
        children: const [

          UpcomingEventCard(
            title: "Winter Training Series - Week 2",
            date: "Jan 8, 2026",
            distance: "35 km",
            image:  'assets/images/cycling_1.png',
          ),

          UpcomingEventCard(
            title: "Youth Cycling District Championship",
            date: "Jan 12, 2026",
            distance: "42 km",
            image: 'assets/images/cycling_1.png',
          ),

          UpcomingEventCard(
            title: "City Riders Marathon",
            date: "Jan 20, 2026",
            distance: "50 km",
            image: 'assets/images/cycling_1.png',
          ),

        ],
      ),
    ),
  ],
)
              ],
            ),
          ),
        ),
      ),
    );
  }
}



