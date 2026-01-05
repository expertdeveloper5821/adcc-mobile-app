import 'package:adcc/features/event_details/view/event_details_screen.dart';
import 'package:flutter/material.dart';

class SpecialRideCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String date;
  final String distance;
  final String riders;
  final VoidCallback? onShare;
  final VoidCallback? onTap;
  final double width;

  const SpecialRideCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.date,
    required this.distance,
    required this.riders,
    this.onShare,
    this.onTap,
    this.width = 350,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(
              routeData: {
                'imagePath': imagePath,
                'title': title,
                'date': date,
                'distance': distance,
                'riders': riders,
              },
            ),
          ),
        );
      },
      child: SizedBox(
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              /// Background Image
              Image.asset(
                imagePath,
                height: 320,
                fit: BoxFit.cover,
              ),

              /// Share Button
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: onShare,
                  child: SizedBox(
                    width: 36,
                    height: 36,
                    child: Image.asset('assets/icons/share.png'),
                  ),
                ),
              ),

              /// Bottom Info Card
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF9EF),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title + Date
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            date,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      /// Info Row
                      Row(
                        children: [
                          Image.asset(
                            'assets/images/location.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(distance),

                          const SizedBox(width: 16),

                          Image.asset(
                            'assets/icons/bike_icon.png',
                            width: 16,
                            height: 16,
                          ),
                          const SizedBox(width: 6),
                          Text(riders),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
