import 'package:flutter/material.dart';

class FeaturedEventCard extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String distance;

  const FeaturedEventCard({
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
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                image,
                height: 275,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Positioned(
              top: 16,
              right: 16,
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

            Positioned(
              left: 16,
              right: 6,
              bottom: 16,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xffF3EFE6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
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

                    const SizedBox(height: 10),

                  Text(
  title,
  style: const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: Colors.white,
    height: 1.2,
  ),
),

                    const SizedBox(height: 8),

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
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(width: 16),
                        Image.asset(
                          "assets/icons/km_empty.png",
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          distance,
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
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