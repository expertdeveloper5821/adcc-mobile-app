import 'package:adcc/core/theme/app_colors.dart';
import 'package:adcc/features/event_details/view/sections/event_facilities_section.dart';
import 'package:adcc/features/event_details/view/sections/event_info.dart';
import 'package:adcc/features/event_details/view/sections/event_quick_info.dart';
import 'package:adcc/features/event_details/view/sections/event_rewards_section.dart';
import 'package:adcc/features/events/services/events_service.dart';
import 'package:adcc/features/events/view/cancel_registration.dart';
import 'package:adcc/features/events/view/my_event_screen.dart';
import 'package:adcc/features/events/view/your_registered_screen.dart';
import 'package:adcc/shared/widgets/banner_header.dart';
import 'package:flutter/material.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
bool isRegistered = false;

bool isLoading = false;
final EventsService _eventsService = EventsService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(14, 12, 14, 22),
          children: [
            BannerHeadder(
              imagePath: 'assets/images/cycling_1.png',
              title: 'Track Near You',
              subtitle: 'Cycling tracks closest to your current location',
              onBackTap: () => Navigator.pop(context),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                "Abu Dhabi Night Race Series",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                  color: AppColors.deepRed,
                ),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Description",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                      color: AppColors.charcoal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "The Abu Dhabi Night Race Series is a competitive\ncycling championship organized by the Abu Dhabi...",
                    style: TextStyle(
                      fontSize: 12,
                      height: 1.35,
                      fontWeight: FontWeight.w600,
                      color: AppColors.charcoal.withValues(alpha: 0.60),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: const [
                  Expanded(
                    child: _SmallInfoCard(
                      icon: Icons.directions_bike_outlined,
                      title: "Type",
                      value: "Race",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SmallInfoCard(
                      icon: Icons.groups_2_outlined,
                      title: "Community",
                      value: "Abu Dhabi Road\nRaces",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: const [
                  Expanded(
                    child: _SmallInfoCard(
                      icon: Icons.location_on_outlined,
                      title: "City",
                      value: "Abu Dhabi",
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _SmallInfoCard(
                      icon: Icons.emoji_events_outlined,
                      title: "Total",
                      value: "You Member Circle",
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

EventQuickInfoSection(
  date: "16 Jul 2026",
  time: "5:30 AM",
  distance: "42 km",
  minAge: "10",
  segment: "Beginner",
  registration: "Free",
),


          
            const SizedBox(height: 18),
/// Organized By Title
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2),
  child: Text(
    "Organized By",
    style: TextStyle(
      fontSize: 13,
      fontWeight: FontWeight.w900,
      color: AppColors.charcoal,
    ),
  ),
),

const SizedBox(height: 10),

/// Organized By Box (Button inside)
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2),
  child: Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: AppColors.lightBeige, width: 1.0),
    ),
    child: Row(
      children: [
        /// Icon
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: AppColors.dustyRose,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(
            Icons.directions_bike,
            color: AppColors.charcoal,
            size: 20,
          ),
        ),

        const SizedBox(width: 12),

        /// Community Name
        Expanded(
          child: Text(
            "Abu Dhabi Road Races\nCommunity",
            style: TextStyle(
              fontSize: 12.5,
              height: 1.2,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),
        ),

        const SizedBox(width: 10),

        /// View Community Button (inside box right side)
        SizedBox(
          height: 34,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.deepRed,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text(
              "View Community",
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  ),
),

            const SizedBox(height: 10),

           

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                "Event Schedule",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppColors.charcoal,
                ),
              ),
            ),
            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Row(
                children: const [
                  Expanded(child: _ScheduleCard(time: "08:00", label: "Rider Check-in")),
                  SizedBox(width: 10),
                  Expanded(child: _ScheduleCard(time: "08:30", label: "Safety briefing")),
                  SizedBox(width: 10),
                  Expanded(child: _ScheduleCard(time: "09:00", label: "Race start")),
                ],
              ),
            ),

            const SizedBox(height: 18),

           

          Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2),
  child: EventFacilitiesSection(
    facilities: const [
      {"icon": "assets/icons/water.png", "label": "Water"},
      {"icon": "assets/icons/toilets.png", "label": "Toilets"},
      {"icon": "assets/icons/parking.png", "label": "Parking"},
      {"icon": "assets/icons/light.png", "label": "Medical"},
    ],
  ),
),


            const SizedBox(height: 18),

            const EventInfo(),


            const SizedBox(height: 18),

         const EventRewardSection(
  rewards: [
    EventRewardItem(
      iconPath: "assets/icons/trophy.png",
      label: "300 Points",
    ),
    EventRewardItem(
      iconPath: "assets/icons/trophy.png",
      label: "Night Race...",
    ),
  ],
),

            const SizedBox(height: 14),
Padding(
  padding: const EdgeInsets.symmetric(horizontal: 2),
  child: Container(
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
    decoration: BoxDecoration(
      color: Colors.white, // 🔥 screenshot bg
      borderRadius: BorderRadius.circular(14),
      border: Border.all(
        color: AppColors.lightBeige,
        width: 1,
      ),
    ),
    child: Row(
      children: [
        /// Left icon box
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: const Color(0xFFFFF2D9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Image.asset(
              "assets/icons/bike.jpg", // 🔥 yaha tumhara icon path
              width: 24,
              height: 24,
              fit: BoxFit.contain,
            ),
          ),
        ),

        const SizedBox(width: 12),

        /// Title + subtitle
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Participants Preview",
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w900,
                color: AppColors.charcoal,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              "96 riders registered",
              style: TextStyle(
                fontSize: 11.2,
                fontWeight: FontWeight.w700,
                color: AppColors.charcoal.withValues(alpha: 0.60),
              ),
            ),
          ],
        ),
      ],
    ),
  ),
),


            const SizedBox(height: 18),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Column(
                children: [
                SizedBox(
  width: double.infinity,
  height: 52,
  child: ElevatedButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const MYEVENET(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.deepRed,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    child: const Text(
      "View Past Result",
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
    ),
  ),
),

                  const SizedBox(height: 12),

SizedBox(
  width: double.infinity,
  height: 52,
child: !isRegistered  
      ? ElevatedButton(
         onPressed: isLoading
    ? null
    : () async {
        setState(() => isLoading = true);

        final result = await _eventsService.joinEvent(
          eventId: widget.eventId,
        );

        setState(() => isLoading = false);

        if (!context.mounted) return;

        if (result.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.message ?? "Registered successfully")),
          );

          // UI update
         setState(() => isRegistered = true);


          // Navigate to success screen
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const RegistrationSuccessScreen(
                eventTitle: "Abu Dhabi Night Race Series",
                eventLocationLine: "Yas Marina Circuit",
                date: "18 July 2026",
                location: "Abu dhabi",
                type: "Race",
                community: "Abu Dhabi\nRoad Racers",
                eventImagePath: "assets/images/cycling_1.png",
                redArcImagePath: "assets/images/frame_1.png",
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(result.message ?? "Registration failed")),
          );
        }
      },

          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.deepRed,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
         child: Text(isLoading ? "Please wait..." : "Registration",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        )
      : OutlinedButton(
    onPressed: isLoading
        ? null
        : () async {
            // 🔥 Cancel screen open karo
            final result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CancelRegistrationScreen(
                  eventId: widget.eventId,
                ),
              ),
            );

            // result = true means cancelled successfully
            if (result == true) {
              setState(() => isRegistered = false);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Cancelled successfully")),
              );
            }
          },
    style: OutlinedButton.styleFrom(
      side: const BorderSide(
        color: AppColors.deepRed,
        width: 1.4,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
    ),
    child: Text(
      isLoading ? "Please wait..." : "Cancel Registration",
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: AppColors.deepRed,
      ),
    ),
  ),

),

                ],
              ),
            ),

            const SizedBox(height: 6),
          ],
        ),
      ),
    );
  }
}
class _SmallInfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SmallInfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.cardLightBackground,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.lightBeige, width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.deepRed),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 10.5,
                    fontWeight: FontWeight.w800,
                    color: AppColors.charcoal.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11.7,
                    height: 1.15,
                    fontWeight: FontWeight.w900,
                    color: AppColors.charcoal,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  final String time;
  final String label;

  const _ScheduleCard({required this.time, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.warmSand,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              fontWeight: FontWeight.w900,
              color: AppColors.charcoal,
            ),
          ),
        ],
      ),
    );
  }
}


