import 'package:adcc/core/theme/app_colors.dart';
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
  left: 15,
  right: 15,
  top: 160,
  child: Container(
    width: 328,
    height: 100,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFFFFF9EF), // #FFF9EF
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// Featured Tag
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 3,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffC12D32),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            "Featured",
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        const SizedBox(height: 6),

        /// Title
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.charcoal,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 6),

        /// Date + Distance Row
        Row(
          children: [
            Image.asset(
              "assets/icons/calender.png",
              width: 14,
              height: 14,
            ),
            const SizedBox(width: 4),

            Text(
              date,
              style: const TextStyle(fontSize: 11),
            ),

            const SizedBox(width: 12),

            Image.asset(
              "assets/icons/km_empty.png",
              width: 14,
              height: 14,
            ),

            const SizedBox(width: 4),

            Text(
              distance,
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ],
    ),
  ),
)
          ],
        ),
      ),
    );
  }
}