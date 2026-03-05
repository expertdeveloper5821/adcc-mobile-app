import 'package:flutter/material.dart';

class UpcomingTracksList extends StatelessWidget {
  const UpcomingTracksList({super.key});

  @override
  Widget build(BuildContext context) {
    final events = [
      EventModel(
        image: "assets/images/cycling_1.png",
        title: "Corniche Sunrise Social",
        day: "Every Sunday",
        type: "Social",
      ),
      EventModel(
        image: "assets/images/cycling_1.png",
        title: "Abu Dhabi Night Ride",
        day: "Every Friday",
        type: "Social",
      ),
      EventModel(
        image: "assets/images/cycling_1.png",
        title: "Yas Island Weekend Ride",
        day: "Every Saturday",
        type: "Social",
      ),
    ];

    return SizedBox(
      height: 275,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        physics: const BouncingScrollPhysics(),
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          return UpcomingEventCard(event: events[index]);
        },
      ),
    );
  }
}

class UpcomingEventCard extends StatelessWidget {
  final EventModel event;

  const UpcomingEventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 308,
      child: Stack(
        children: [

          /// BACKGROUND IMAGE
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              event.image,
              height: 275,
              width: 358,
              fit: BoxFit.cover,
            ),
          ),

          /// SHARE BUTTON
          Positioned(
            top: 12,
            right: 12,
            child: Container(
              height: 36,
              width: 36,
              decoration: const BoxDecoration(
                color: Color(0xffC12D32),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.share,
                size: 18,
                color: Colors.white,
              ),
            ),
          ),

          /// INFO CARD
          Positioned(
            left: 15,
            right: 15,
            bottom: 15,
            child: Container(
              width: 328,
              height: 100,
              padding: const EdgeInsets.fromLTRB(15, 9, 15, 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// SOCIAL BADGE
                  Container(
                    width: 62,
                    height: 24,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xffC12D32),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      event.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  /// TITLE
                  Text(
                    event.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 1),

                  /// DAY ROW
                  Row(
                    children: [

                      Image.asset(
                        "assets/icons/calender.png",
                        height: 16,
                        width: 16,
                      ),

                      const SizedBox(width: 2),

                      Text(
                        event.day,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class EventModel {
  final String image;
  final String title;
  final String day;
  final String type;

  EventModel({
    required this.image,
    required this.title,
    required this.day,
    required this.type,
  });
}