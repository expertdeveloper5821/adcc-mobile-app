import 'package:flutter/material.dart';

class RandomCard extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String distance;

  const RandomCard({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.distance,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 275,
        width: double.infinity,
        child: Stack(
          children: [

            /// BACKGROUND IMAGE
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                height: 275,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            /// SHARE BUTTON
            Positioned(
              top: 14,
              right: 14,
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                  color: Color(0xffC12D32),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ),

            /// INFO CARD
            Positioned(
              left: 14,
              right: 14,
              bottom: 14,
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xffF3EFE6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    /// FEATURED BADGE
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffC12D32),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        "Featured",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// TITLE
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 6),

                    /// DATE + DISTANCE
                    Row(
                      children: [

                        Image.asset(
                          "assets/icons/calender.png",
                          width: 16,
                          height: 16,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          date,
                          style: const TextStyle(fontSize: 14),
                        ),

                        const SizedBox(width: 16),

                        Image.asset(
                          "assets/icons/distance.png",
                          width: 16,
                          height: 16,
                        ),

                        const SizedBox(width: 6),

                        Text(
                          distance,
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}