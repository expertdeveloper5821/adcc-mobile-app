import 'package:flutter/material.dart';

class TrackCard extends StatelessWidget {
  final String image;
  final String title;
  final String distance;
  final String level;
  final String ridesToday;
  final bool isOpen;

  const TrackCard({
    super.key,
    required this.image,
    required this.title,
    required this.distance,
    required this.level,
    required this.ridesToday,
    this.isOpen = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 260,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF8EED5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          /// IMAGE SECTION
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Stack(
              children: [
                Image.asset(
                  image,
                  height: 160,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),

                /// OPEN NOW BADGE
                if (isOpen)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Open Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),

          /// CONTENT
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TITLE
                 Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  /// INFO ROW
                  Flexible(
                    child: Wrap(
                      spacing: 5,
                      runSpacing: 8,
                      children: [
                        _infoItem(Icons.near_me_outlined, distance),
                        _infoItem(Icons.star_border, level),
                        _infoItem(Icons.directions_bike, ridesToday),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.black87),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 11, color: Colors.black87),
        ),
      ],
    );
  }
}
